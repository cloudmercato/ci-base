#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo=$(which sudo)

$sudo apt -y -qq update
$sudo apt install -y -q python3 python3-distutils jq wget bc
$sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 0

echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $FLAVOR_ID,
  \"image\": $IMAGE_ID
}" > .cb_client.json
