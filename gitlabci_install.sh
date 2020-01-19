#!/bin/bash

sudo=$(which sudo)

export DEBIAN_FRONTEND=noninteractive
$sudo apt -y -qq update
$sudo apt install -y -q jq wget

image_id="$IMAGE_ID"
flavor_id="$FLAVOR_ID"
echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $flavor_id,
  \"image\": $image_id
}" > .cb_client.json
