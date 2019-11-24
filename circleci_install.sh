#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt -y -qq update
apt install -y -q python3 python3-pip jq wget
update-alternatives --install /usr/bin/python python /usr/bin/python3 0

echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $flavor_id,
  \"image\": $image_id
}" > .cb_client.json
