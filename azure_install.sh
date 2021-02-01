#!/bin/bash

sudo=$(which sudo)

$sudo apt install -y python3 python3-pip jq wget bc

echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $FLAVOR_ID,
  \"image\": $IMAGE_ID
}" > .cb_client.json
