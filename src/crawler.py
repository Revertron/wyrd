#!/usr/bin/python3
#some of this code was contributed by Arcelier
#original code https://github.com/Arceliar/yggdrasil-map/blob/master/scripts/crawl-dht.py
#multithreaded by neilalexander

# version 0.1.6

import MySQLdb
import json
import socket
import sys
import os
import time
import ipaddress
import traceback
import runpy
import re
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

def is_valid_domain(domain):
    in_valid_zone = False
    for zone in config["ZONES"]:
        if domain.endswith(zone):
            in_valid_zone = True
            break

    return in_valid_zone and re.match(r'^(?=.{4,255}$)([a-zA-Z0-9][a-zA-Z0-9-]{,61}[a-zA-Z0-9]\.)+[a-zA-Z0-9]{2,6}$', domain)

def record_to_string(domain, record):
    result = ""
    if "ip" not in record and "data" not in record:
        return result
    data = ""
    if "ip" in record:
        data = record["ip"]
    elif "data" in record:
        data = record["data"]

    pos = domain.rfind('.')
    domain_name = domain[0:pos] if pos > -1 else ""
    if len(domain_name) == 0:
        return ""

    name = record["name"] if "name" in record else domain_name
    if name == "@":
        name = domain_name
    ttl = record["ttl"] if "ttl" in record else 300
    type = record["type"] if "type" in record else "AAAA"
    if name == domain_name:
        result = "%s\t%s\tIN\t%s\t%s" % (domain_name, ttl, type, data)
    else:
        result = "%s\t%s\tIN\t%s\t%s" % (name + "." + domain_name, ttl, type, data)
    print("Got record:", result)
    return result

def get_valid_owner(ipv6, domain, dbconn):
    print("Checking domain %s against IP %s..." % (domain, ipv6))
    owner = ''
    new_owner = ''
    fallback_owner = ''
    legacy = 0
    cur = dbconn.cursor()
    cur.execute("SELECT owner, fallback, legacy FROM domains WHERE domain=%s;", (domain,))
    for row in cur.fetchall():
        owner = row[0]
        fallback = row[1]
        legacy = row[2]
    cur.close()

    if legacy > 0:
        print("Ignoring owner change to legacy domain %s" % domain)
        return False

    if owner != '' and owner != ipv6 and ipv6 != fallback:
        return False
    if owner == ipv6 or owner == '':
        return ipv6
    return False

def get_dns_records(ipv6, dns, dbconn):
    if "domains" not in dns:
        return ""
    domains = dns["domains"]
    result = []

    for d in domains:
        records = []
        if "domain" not in d:
            print("Object does not contain domain field, ignoring")
            continue
        domain = d["domain"]
        if not is_valid_domain(domain):
            print("%s is not valid domain, ignoring" % domain)
            continue
        owner = get_valid_owner(ipv6, domain, dbconn)
        if not owner or ipv6 != owner:
            print("Wrong owner for domain %s: ipv6 is %s, but owner is %s" % (domain, ipv6, owner))
            continue
        if "records" not in d and "ip" in d:
            print("%s does simple ip mode" % domain)
            ip = d["ip"]
            if ip and valid_ipv6_check(ip):
                records.append("%s.\t3600\tIN\tAAAA\t%s" % (domain, ip))
                result.append((domain, ipv6, records))
            continue
        if "records" not in d:
           print("%s does not contain nor records nor ip, ignoring" % domain)
           continue
        for record in d["records"]:
            r = record_to_string(domain, record)
            if r:
                records.append(r)
        if records:
            result.append((domain, ipv6, records))

    return result

def insert_new_records(records, dbconn):
    timestamp = str(int(time.time()))
    cursor = dbconn.cursor()
    for domain, ipv6, recs in records:
        record_string = "\n".join(recs)
        cursor.execute("SELECT records FROM domains WHERE domain=%s LIMIT 1;", (domain,))
        old = cursor.fetchall()
        if not old:
            cursor.execute(
               "INSERT INTO domains (domain, owner, seen_first, records) VALUES(%s, %s, %s, %s) ON DUPLICATE KEY UPDATE owner=%s, records=%s;",
               (domain, ipv6, timestamp, record_string, ipv6, record_string)
            )
            print("\nRecords added:\n%s\n" % (record_string));
        else:
            for rec in old:
                if not rec[0] == record_string:
                    cursor.execute(
                       "INSERT INTO domains (domain, owner, seen_first, records) VALUES(%s, %s, %s, %s) ON DUPLICATE KEY UPDATE owner=%s, records=%s;",
                       (domain, ipv6, timestamp, record_string, ipv6, record_string)
                    )
                    print("\nRecords updated:\n%s\n%s\n" % (rec[0], record_string));
    cursor.close()

def check_owner_transfers(ipv6, dns, dbconn):
    if "domains" not in dns:
        return False
    for domain in dns["domains"]:
        if "owner" in domain:
            name = domain["domain"]
            owner = domain["owner"]
            print("Changing owner of %s from %s to %s" % (name, ipv6, owner))
            cursor = dbconn.cursor()
            cursor.execute("UPDATE domains SET owner=%s WHERE domain=%s AND owner=%s;", (owner, name, ipv6))
            cursor.close()
            return True
    return False

def insert_new_entry(ipv6, coords):
    try:
        nodename = ""
        nodejson = "{}"
        dns = ""
        if ipv6 in nodeinfo:
            with nodeinfomutex:
                nodejson = json.dumps(nodeinfo[ipv6])
                nodename = nodeinfo[ipv6]["name"] if "name" in nodeinfo[ipv6] else ""
                dns = nodeinfo[ipv6]["dns"] if "dns" in nodeinfo[ipv6] else ""
                if not dns:
                    return

        dbconn = MySQLdb.connect(host=config['DB_HOST'], db=config['DB_NAME'], user=config['DB_USER'], passwd=config['DB_PASSWORD'])
        records = get_dns_records(ipv6, dns, dbconn)
        if records:
            #print("Got records: %s" % records)
            insert_new_records(records, dbconn)
        check_owner_transfers(ipv6, dns, dbconn)

        dbconn.commit()
        dbconn.close()
    except Exception as e:
        print("  Error inserting records from %s" % ipv6)
        traceback.print_exc()

def read_file(file_name):
    with open(file_name, 'r') as f:
        buf = f.read().replace('\r', '')
        return buf

def update_zone_serial(path):
    with open(path, "r+") as zonefile:
        zone = zonefile.read()

        lines = zone.split('\n')
        for i in range(len(lines)):
            line = lines[i]
            pos = line.find("\t; serial")
            if pos < 0:
                continue
            serial = line[:pos].strip()
            new_serial = int(serial) + 1
            lines[i] = "\t\t\t%d\t; serial" % new_serial

        new_zone = "\n".join(lines)
        zonefile.seek(0)
        zonefile.truncate(0)
        zonefile.write(new_zone)

def save_zone_info(path, zone):
    try:
        dbconn = MySQLdb.connect(host=config['DB_HOST'], db=config['DB_NAME'], user=config['DB_USER'], passwd=config['DB_PASSWORD'])
        cursor = dbconn.cursor()
        cursor.execute("SELECT records FROM domains WHERE domain LIKE %s;", ("%" + zone,))
        lines = []
        for rec in cursor.fetchall():
            lines.append(rec[0])
        data = "\n".join(lines) + "\n"

        current_zone = read_file(path + ".records")
        if current_zone == data:
            print("Skipping update of zone %s, no changes found" % zone)
            return False

        # Saving to file
        with open(path + ".records", 'w') as f:
            f.write(data)
        update_zone_serial(path)
        print("Updated zone %s, something has changed" % zone)
        return True
    except Exception as e:
        print("  Error saving zone info '%s' to %s" % (zone, path))
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
        nodeinfo[str(address)] = data['response']['nodeinfo']

def handleResponse(address, info, data):
    global visited
    global rumored
    global timedout

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
        print("Visited", str(address))
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

print("\nNodeinfopool is ready, nodeinfo length is", len(nodeinfo))
for x, y in visited.items():
    if valid_ipv6_check(x) and check_coords(y):
        insert_new_entry(x, y)

print("Done with updating. Saving zones.")

updated = False
for zone in config['ZONES']:
    updated = save_zone_info("/etc/bind/wyrd/db%s" % zone, zone) or updated

if updated and config['PUSH_DB_TO_GIT']:
    os.system('/bin/systemctl reload bind9')
    os.system('mysqldump --skip-dump-date --compact --skip-extended-insert --skip-comments --order-by-primary wyrd domains > db/domains.sql')
    os.system('git add db/domains.sql')
    os.system('git commit -m "Autocommit changed zone."')
    os.system('git push origin')
