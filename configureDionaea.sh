#!/bin/bash

#Go to Dionaea's config folder
cd /opt/dionaea/etc/dionaea

#Remove debug messages from log
sed -i 's/levels = "all"/levels = "all,-debug"/g' dionaea.conf

#Change to correct interface
sed -i 's/mode = "getifaddrs"/mode = "manual"/g' dionaea.conf
sed -i 's/addrs = { eth0 = \["::"\] }/addrs = { eth1 = \["0.0.0.0"\] }/g' dionaea.conf

#Enable p0f ihandler
sed -i -r 's/\/\/\t\t\t"p0f"/\t\t\t"p0f"/g' dionaea.conf

cd ~