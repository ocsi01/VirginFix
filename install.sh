#! /bin/bash

wget https://github.com/appneta/tcpreplay/releases/download/v4.1.0/tcpreplay-4.1.0.tar.gz
tar xf tcpreplay-4.1.0.tar.gz
cd tcpreplay-4.1.0
./configure
make
sudo make test
sudo make install
tcpreplay -V