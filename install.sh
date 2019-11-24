#!/bin/bash

sudo=$(which sudo)
dirname=$(dirname $0)

$dirname/${1}_install.sh

$sudo wget -q https://bootstrap.pypa.io/get-pip.py
$sudo python get-pip.py
$sudo pip install https://github.com/cloudspectatordevelopment/cb-client/archive/master.tar.gz

