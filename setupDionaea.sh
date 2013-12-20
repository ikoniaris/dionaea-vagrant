#!/bin/bash

#Update & upgrade system
aptitude update && aptitude -y safe-upgrade

#Install required packages from repos
aptitude -y install libudns-dev libglib2.0-dev libssl-dev libcurl4-openssl-dev \
libreadline-dev libsqlite3-dev python-dev libtool automake autoconf build-essential \
subversion git-core flex bison pkg-config

#Create the Dionaea directory in /opt
mkdir /opt/dionaea
cd /opt/dionaea

#Install liblcfg
git clone git://git.carnivore.it/liblcfg.git liblcfg
cd liblcfg/code
autoreconf -vi
./configure --prefix=/opt/dionaea
make install
cd ../../

#Install libemu
git clone git://git.carnivore.it/libemu.git libemu
cd libemu
autoreconf -vi
./configure --prefix=/opt/dionaea
make install
cd ..

#Install libnl
aptitude -y install libnl-3-dev libnl-genl-3-dev libnl-nf-3-dev libnl-route-3-dev

#Install libev
wget http://dist.schmorp.de/libev/Attic/libev-4.04.tar.gz
tar xfz libev-4.04.tar.gz
cd libev-4.04
./configure --prefix=/opt/dionaea
make install
cd ..

#Install Python
wget http://www.python.org/ftp/python/3.2.2/Python-3.2.2.tgz
tar xfz Python-3.2.2.tgz
cd Python-3.2.2/
./configure --enable-shared --prefix=/opt/dionaea --with-computed-gotos \
--enable-ipv6 LDFLAGS="-Wl,-rpath=/opt/dionaea/lib/ -L/usr/lib/x86_64-linux-gnu/"
make
make install
cd..

#Install Cython
wget http://cython.org/release/Cython-0.15.tar.gz
tar xfz Cython-0.15.tar.gz
cd Cython-0.15
/opt/dionaea/bin/python3 setup.py install
cd ..

#Install libcurl
aptitude -y install curl libcurl3 python-pycurl

#Install libpcap
wget http://www.tcpdump.org/release/libpcap-1.1.1.tar.gz
tar xfz libpcap-1.1.1.tar.gz
cd libpcap-1.1.1
./configure --prefix=/opt/dionaea
make
make install
cd ..

#Install Dionaea
git clone git://git.carnivore.it/dionaea.git dionaea
cd dionaea
autoreconf -vi
./configure --with-lcfg-include=/opt/dionaea/include/ \
--with-lcfg-lib=/opt/dionaea/lib/ \
--with-python=/opt/dionaea/bin/python3.2 \
--with-cython-dir=/opt/dionaea/bin \
--with-udns-include=/opt/dionaea/include/ \
--with-udns-lib=/opt/dionaea/lib/ \
--with-emu-include=/opt/dionaea/include/ \
--with-emu-lib=/opt/dionaea/lib/ \
--with-gc-include=/usr/include/gc \
--with-ev-include=/opt/dionaea/include \
--with-ev-lib=/opt/dionaea/lib \
--with-nl-include=/opt/dionaea/include \
--with-nl-lib=/opt/dionaea/lib/ \
--with-curl-config=/usr/bin/ \
--with-pcap-include=/opt/dionaea/include \
--with-pcap-lib=/opt/dionaea/lib/
make
make install
cd ~

#Install p0f
aptitude -y install p0f

