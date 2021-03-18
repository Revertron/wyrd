# Wyrd (deprecated)
Automatic, NodeInfo based DNS implementation for Yggdrasil

This project is deprecated in favor of blockchain based DNS - [ALFIS](https://github.com/Revertron/Alfis), the crawler is stopped forever (no more new domains).


Now working servers are here:

| Server IP      | Location                  |
|:--------------:|:--------------------------|
|`301:2522::53`  | Praha, Czechia            |
|`301:2923::53`  | Bratislava, Slovakia      |
|`300:4523::53`  | Duesseldorf, Germany      |
|`303:8b1a::53`  | Saint Petersburg, Russia  |

They will be migrated to ALFIS DNS soon.


## Introduction
If you use Yggdrasil network, then you've thought about new DNS. Not only to convert names to IPs, but use some additional records, that you can't add to `hosts` file, like CNAME, MX or TXT. And the system should be reliable, if someone got one domain, it must maintain it's owner, and not give it to some second guy.
There are some "crypto-dns" systems, like EmerDNS and alike, but they need you to have some gigabytes of HDD-space to store that blockchain. We cannot afford this in mobile phones and tablets.
Then, we need to use some ordinary caching server to provide those DNS-records, to set them in mobile and use like ordinary DNS.

## What is Wyrd?
Wyrd is a crawler script for BIND DNS-server, to collect and validate DNS-records from NodeInfo data from all nodes.
It gets data - domains, DNS-records, checks for "owner", and stores them in MySQL database (one simple table), then gets all records from that table and feeds it to BIND server.

## How it works?
1. Checks all nodes (like in map.ygg crawler) for DNS info.
2. Iterates over domains found, and checks their validity, zone and ownership. If the domain is new, it is added, if the owner (IPv6 of the node) is the same, it updates DNS-records, if IPv6 != owner, it just ignores the domain.
3. When the domain is added, the node (represented by IPv6) is saved as an owner, and datetime (`seen_first`) is saved along it.
4. If you need to change the owner to some other node, you set `owner` property to the new IPv6, and it will be changed in DB.
5. If you want to use some other node as a "backup owner" in case first node dies, you can set `fallback` property, and that second node will become a new owner when the first will be gone for some time (not yet implemented).
6. In future version every domain will need to be "bought" by PoW. Simple mining of `nonce`, that will eliminate squatting, or make it hard enough.

How to add your domain to those servers? Easy! Just add needed DNS-records to your zoneinfo like this:

### One domain
Althought it has a lot of different brackets, but it is simple
```
NodeInfo: {
  dns: {
    domains: [
      {
        domain: example.ygg
        ip: 200:1111:2222:3333:4444:5555:6666:7777
      }
    ]
  }
}
```
### One domain with subdomains
If you use the `records` array with `type` and/or `ttl`, then you need to change `ip` to `data`, because there may be some CNAME also, not only IP.
```
NodeInfo: {
  dns: {
    domains: [
      {
        domain: example.ygg
        records: [
            {
                data: 200:1111:2222:3333:4444:5555:6666:7777
                name: @
                ttl: 300
                type: AAAA
            }
            {
                data: 200:1111:2222:3333:4444:5555:6666:7778
                name: ftp
                ttl: 600
                type: AAAA
            }
        ]
      }
    ]
  }
}
```
### All other variants with explanation
```
"nodeinfo": {
    "dns": {
      // You may add some contact, just how WHOIS does
      "contact": mail@example.com
      "domains": [
        {
          "domain": "test.ygg", // Your desired domain
          "records": [
            {
              // The IP address to resolve to, it may be different from your node's address
              "data": "200:149b::b722:fe09:d31:84a4",
              "name": "*", // You can omit it, default "@" will be used
              "ttl": 300, // You can omit it too, default 3600 (one hour) will be used
              "type": "AAAA" // And this one can be omited, AAAA will be used as default
            }
          ],
          // Tags will be used for ranking and searching in the future, stay tuned ;)
          "tags": [
            "test",
            "dns",
            "experiment"
          ]
        },
        {
          // You can try some real domains, but they will be ignored :)
          "domain": "google.com",
          // Instead of "records" array you can just enter an IP address,
          // type and TTL will be default - AAAA & 3600
          "ip": "200:149b::b722:fe09:d31:84a4"
        }
      ]
    },
    "location": "Somewhere on Earth", // The common fields
    "name": "My meganode!",
  }
```
Currently only this TLD is supported: `.ygg`. If the community will need some more, we can add some.

## Installation (if you want to run your instance)
1. You need to have installed bind9, python3 and python3-mysqldb. For example: `apt-get install bind9 python3 python3-mysqldb`
2. Clone this repository
3. Create a database `wyrd`, user `wyrd` and give this user all privileges for this DB
4. Import DB dump from `./db`
5. Copy all contains in `bind` directory to `/etc/bind/`
6. Change a password in `./src/config.py`
7. Check your yggdrasil adminlisten block. It should be tcp://localhost:9001
8. Run it by `python3 ./src/crawler.py` or `./run.sh & / disown %1`
9. It would be great to add it to the cron, like for every 15 minutes

## Synchronization
You can ask - what if I run it on my server, and get some domain from already ignored squatter, not from legitimate owner?
Okay, for that I have a solution, but not implemented yet. As I have a first Wyrd server, I will push DB states after every modification to this repository, and anyone who is starting his server would not start from a scratch. His server would be populated with all current records in a glance. And, what is more important - all the changes in domains and records could be monitored easily.
