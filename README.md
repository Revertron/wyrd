# Wyrd
Decentralized DNS implementation by Medium for Yggdrasil

Just add needed DNS-records to your zoneinfo like this:

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
              "ip": "200:149b::b722:fe09:d31:84a4",
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
Currently these TLDs are supported: `.ygg`, `.medium`, `.ea`, `.um`.
