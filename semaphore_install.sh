#!/bin/bash

sudo=$(which sudo)

if [[ "$SEMAPHORE_AGENT_MACHINE_OS_IMAGE" == "ubuntu"* ]] ; then
    export DEBIAN_FRONTEND=noninteractive
    $sudo apt -y -qq update
    $sudo apt install -y -q python3 jq wget
elif [[ "$SEMAPHORE_AGENT_MACHINE_OS_IMAGE" == "macos"* ]] ; then
    brew upgrade ruby
    brew install jq wget
fi

echo -e "{
  \"images\": {
      \"ubuntu1804_VM\": \"$UBUNTU_1804_VM_ID\",
      \"ubuntu1804_container\": \"$UBUNTU_1804_CONTAINER_ID\",
      \"macos_mojave_xcode11_VM\": \"$MACOS_MOJAVE_VM_ID\"
  },
  \"flavors\": {
      \"e1_standard_2_VM\": \"$E1_2_ID\",
      \"e1_standard_4_VM\": \"$E1_4_ID\",
      \"e1_standard_8_VM\": \"$E1_8_ID\"
  }
}" > .infra-opts.json

image_id=$(jq .images."${SEMAPHORE_AGENT_MACHINE_OS_IMAGE//-/_}_${SEMAPHORE_AGENT_MACHINE_ENVIRONMENT_TYPE}" .infra-opts.json)
flavor_id=$(jq .flavors."${SEMAPHORE_AGENT_MACHINE_TYPE//-/_}_${SEMAPHORE_AGENT_MACHINE_ENVIRONMENT_TYPE}" .infra-opts.json)
echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $flavor_id,
  \"image\": $image_id
}" > .cb_client.json
