#!/bin/bash

sudo=$(which sudo)

$sudo apt install -y -q vim-common
if [[ "$2" == 'mysql' ]] ; then
    $sudo apt install -y libmysqlclient-dev libssl-dev
fi
