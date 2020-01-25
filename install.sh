#!/bin/bash

sudo=$(which sudo)
dirname=$(dirname $0)

$dirname/${1}_install.sh
[[ -n "$2" ]] && $dirname/install_${2}.sh $1 $3

$sudo wget -q https://bootstrap.pypa.io/get-pip.py
$sudo python get-pip.py
$sudo pip install -q https://github.com/cloudspectatordevelopment/cb-client/archive/master.tar.gz
