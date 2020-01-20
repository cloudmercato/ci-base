#!/bin/bash

sudo=$(which sudo)
dirname=$(dirname $0)
sysbench_version=${sysbench_version:-1.0.8}

[[ -n "$1" && -e "${dirname}/${1}_sysbench_install.sh" ]] && $dirname/${1}_sysbench_install.sh

wget -q https://github.com/akopytov/sysbench/archive/${sysbench_version}.tar.gz
tar xf ${sysbench_version}.tar.gz

cd sysbench-${sysbench_version}

make clean
./autogen.sh
./configure --without-gcc-arch --without-mysql
make
$sudo make install
