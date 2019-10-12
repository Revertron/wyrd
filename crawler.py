#!/usr/bin/python3
#some of this code was contributed by Arcelier
#original code https://github.com/Arceliar/yggdrasil-map/blob/master/scripts/crawl-dht.py
#multithreaded by neilalexander

import MySQLdb
import json
import socket
import sys
import time
import ipaddress
import traceback
import runpy
from threading import Lock, Thread
from queue import Queue

class Worker(Thread):
    def __init__(self, tasks):
        Thread.__init__(self)
        self.tasks = tasks
        self.daemon = True
        self.start()

    def run(self):
        while True:
            func, args, kargs = self.tasks.get()
            try:
                func(*args, **kargs)
            except Exception as e:
                pass
            finally:
                self.tasks.task_done()

class ThreadPool:
    def __init__(self, threads):
        self.tasks = Queue(128)
        for _ in range(threads):
            Worker(self.tasks)

    def add(self, func, *args, **kargs):
        self.tasks.put((func, args, kargs))

    def wait(self):
        self.tasks.join()

visited = dict() # Add nodes after a successful lookup response
rumored = dict() # Add rumors about nodes to ping
timedout = dict()
nodeinfo = dict()
nodeinfomutex = Lock()
nodeinfopool = ThreadPool(30)

host_port = ('localhost', 9001)

config = runpy.run_module("config")

def recv_until_done(soc):
    all_data = []
    while True:
        incoming_data = soc.recv(8192)
        if not incoming_data:
            soc.close()
            break
        all_data.append(incoming_data.decode())
    return ''.join(all_data)


def getDHTPingRequest(key, coords, target=None):
    if target:
        return '{{"request":"dhtPing", "box_pub_key":"{}", "coords":"{}", "target":"{}"}}'.format(key, coords, target)
    else:
        return '{{"request":"dhtPing", "box_pub_key":"{}", "coords":"{}"}}'.format(key, coords)


def getNodeInfoRequest(key, coords):
    return '{{"request":"getNodeInfo", "box_pub_key":"{}", "coords":"{}"}}'.format(key, coords)


def getNodeInfoTask(address, info):
    handleNodeInfo(address, doRequest(getNodeInfoRequest(info['box_pub_key'], info['coords'])))


def doRequest(req):
    try:
        ygg = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        ygg.connect(host_port)
        ygg.send(str.encode(req))
        data = json.loads(recv_until_done(ygg))
        ygg.close()
        return data
    except:
        traceback.print_exc()
        return None


def check_coords(coords):
    coord_len = coords.replace(' ', '').replace('[', '').replace(']', '')
    digits_found = [x for x in coord_len if x.isdigit()]

    if len(digits_found) == len(coord_len):
        crus = True
    else:
        crus = False
    return crus


def valid_ipv6_check(ipv6add):
    try:
        if ipaddress.IPv6Address(ipv6add):
            addr = True
    except:
        traceback.print_exc()
        addr = False
    return addr


def insert_new_entry(ipv6, coords):
    try:
        nodename = ""
        nodejson = "{}"
        if ipv6 in nodeinfo:
            with nodeinfomutex:
                nodejson = json.dumps(nodeinfo[ipv6])
                nodename = nodeinfo[ipv6]["name"] if "name" in nodeinfo[ipv6] else ""
        dbconn = MySQLdb.connect(host=config['DB_HOST'], db=config['DB_NAME'], user=config['DB_USER'], passwd=config['DB_PASSWORD'])
        cur = dbconn.cursor()
        cur.execute(
            "INSERT INTO yggindex (ipv6, coords, unixtstamp, name) VALUES(%s, %s, %s, %s) ON DUPLICATE KEY UPDATE unixtstamp=%s, coords=%s, name=%s;",
            (ipv6, coords, str(int(time.time())), nodename, str(int(time.time())), coords, nodename)
        )
        cur.execute(
            "INSERT INTO yggnodeinfo (ipv6, nodeinfo, timestamp) VALUES(%s, %s, NOW()) ON DUPLICATE KEY UPDATE nodeinfo=%s, timestamp=NOW();",
            (ipv6, nodejson, nodejson)
        )
        dbconn.commit()
        cur.close()
        dbconn.close()
    except Exception as e:
        print("database error inserting")
        traceback.print_exc()

def handleNodeInfo(address, data):
    global nodeinfo

    with nodeinfomutex:
        nodeinfo[str(address)] = {}
        if not data:
            return
        if 'response' not in data:
            return
        if 'nodeinfo' not in data['response']:
            return
        if 'dns' in data['response']['nodeinfo']:
            print("DNS info:", data['response']['nodeinfo']['dns'])
        #print("Adding nodeinfo for:", address)
        nodeinfo[str(address)] = data['response']['nodeinfo']

def handleResponse(address, info, data):
    global visited
    global rumored
    global timedout

    #print("handleResponse:", address, info, data)

    timedout[str(address)] = {'box_pub_key':str(info['box_pub_key']), 'coords':str(info['coords'])}

    if not data:
        return
    if 'response' not in data:
        return
    if 'nodes' not in data['response']:
        return
    for addr,rumor in data['response']['nodes'].items():
        if addr in visited: continue
        rumored[addr] = rumor
    if address not in visited:
        visited[str(address)] = info['coords']
    if address in timedout:
        del timedout[address]

    nodeinfopool.add(getNodeInfoTask, address, info)

# Get self info
selfInfo = doRequest('{"request":"getSelf"}')
print("selfInfo:", selfInfo)

# Initialize dicts of visited/rumored nodes
for k,v in selfInfo['response']['self'].items():
    rumored[k] = v

# Loop over rumored nodes and ping them, adding to visited if they respond
while len(rumored) > 0:
    for k,v in rumored.items():
        handleResponse(k, v, doRequest(getDHTPingRequest(v['box_pub_key'], v['coords'])))
        break
    del rumored[k]
#End

nodeinfopool.wait()

print("Nodeinfopool is ready, nodeinfo length is", len(nodeinfo))
for x, y in visited.items():
    if valid_ipv6_check(x) and check_coords(y):
        insert_new_entry(x, y)

print("Done.")
