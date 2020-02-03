#!/bin/bash

sudo=$(which sudo)

if [[ "$FLAVOR" == 'linux' ]] ; then
    export DEBIAN_FRONTEND=noninteractive
    $sudo apt -y -q update
    $sudo apt install -y -q python3 jq wget bc
elif [[ "$FLAVOR" == 'macos' ]] ; then
    brew install wget jq
fi

echo -e "{
  \"images\": {
      \"Ubuntu1804\": \"$UBUNTU_1804\",
      \"macOS_Mojave\": \"$MACOS_MOJAVE\"
  },
  \"flavors\": {
      \"linux\": \"$LINUX_FLAVOR_ID\",
      \"macos\": \"$MACOS_FLAVOR_ID\"
  }
}" > .infra-opts.json

image_id=$(jq .images.${IMAGE} .infra-opts.json)
flavor_id=$(jq .flavors.${FLAVOR} .infra-opts.json)
echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $flavor_id,
  \"image\": $image_id
}" > .cb_client.json
