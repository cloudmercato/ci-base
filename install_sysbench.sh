#!/bin/bash

sudo=$(which sudo)
dirname=$(dirname $0)
sysbench_version=${sysbench_version:-1.0.8}

wget -q https://github.com/akopytov/sysbench/archive/${sysbench_version}.tar.gz
tar xf ${sysbench_version}.tar.gz

cd sysbench-${sysbench_version}
[[ -n "$1" ]] && ../${1}_sysbench_install.sh

make clean
./autogen.sh
./configure --without-gcc-arch --without-mysql
make
sudo make install
