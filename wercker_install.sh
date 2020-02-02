#!/bin/bash

sudo=$(which sudo)

export DEBIAN_FRONTEND=noninteractive
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

echo -e "$DATASTORE_TYPE_ID" > .datastore_type_id
echo -e "{
  \"host\": \"redis\",
  \"port\": \"6379\",
  \"password\": \"\"
}" > .redis.json
