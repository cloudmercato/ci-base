#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo=$(which sudo)

$sudo apt -y -qq update
$sudo apt install -y -q python3 jq wget bc

echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $FLAVOR_ID,
  \"image\": $IMAGE_ID
}" > .cb_client.json
