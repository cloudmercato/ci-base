#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt -y -qq update
apt install -y -q python3 python3-distutils jq wget bc

wget -q https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
pip3 install -q https://github.com/cloudmercato/cb-client/archive/master.tar.gz
