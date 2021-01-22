#!/bin/bash

sudo=$(which sudo)

export DEBIAN_FRONTEND=noninteractive
$sudo apt -y -qq update
$sudo apt install -y -q python3 jq wget bc
$sudo sysctl -w net.ipv4.tcp_tw_reuse=1
