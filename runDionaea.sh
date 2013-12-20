#!/bin/bash

#Start p0f
p0f -i eth1 -Q /tmp/p0f.sock -l -d -o /var/log/p0f.log

#Start Dionaea as daemon
/opt/dionaea/bin/dionaea -D -l all,-debug -L '*' -c /opt/dionaea/etc/dionaea/dionaea.conf -p /opt/dionaea/var/run/dionaea.pid