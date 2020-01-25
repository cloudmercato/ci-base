#!/bin/bash

sudo=$(which sudo)

if [[ "$DRONE_STAGE_OS" == "linux" ]] ; then
    export DEBIAN_FRONTEND=noninteractive
    $sudo apt -y -qq update
    $sudo apt install -y -q python3 jq wget
elif [[ "$DRONE_STAGE_OS" == "darwin" ]] ; then
    brew upgrade ruby
    brew install jq wget
fi

echo -e "{
  \"images\": {
      \"amd64_docker_linux\": \"$AMD64_DOCKER_LINUX_IMAGE_ID\",
      \"arm64_docker_linux\": \"$ARM64_DOCKER_LINUX_IMAGE_ID\"
  },
  \"flavors\": {
      \"amd64_docker\": \"$AMD64_DOCKER_FLAVOR_ID\",
      \"arm64_docker\": \"$ARM64_DOCKER_FLAVOR_ID\" 
  },
  \"volume_flavors\": {
      \"amd64_docker\": \"$AMD64_DOCKER_VOLUME_FLAVOR_ID\",
      \"arm64_docker\": \"$ARM64_DOCKER_VOLUME_FLAVOR_ID\" 
  }
}" > .infra-opts.json

image_id=$(jq .images.${DRONE_STAGE_ARCH}_${DRONE_STAGE_TYPE}_${DRONE_STAGE_OS} .infra-opts.json)
flavor_id=$(jq .flavors.${DRONE_STAGE_ARCH}_${DRONE_STAGE_TYPE} .infra-opts.json)
volume_flavor_id=$(jq .volume_flavors.${DRONE_STAGE_ARCH}_${DRONE_STAGE_TYPE} .infra-opts.json)

echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $flavor_id,
  \"image\": $image_id
}" > .cb_client.json
echo -e "$volume_flavor_id" | sed 's/"//g' > .volume_flavor_id
