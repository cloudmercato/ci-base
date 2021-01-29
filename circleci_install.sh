#!/bin/bash

sudo=$(which sudo)

export DEBIAN_FRONTEND=noninteractive
$sudo apt -y -qq update
$sudo apt install -y -q python3 python3-pip jq wget bc
$sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 0
$sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 0

echo -e "{
  \"images\": {
      \"ubuntu\": \"$IMAGE_UBUNTU_ID\",
      \"macos\": \"$IMAGE_MACOS_ID\",
      \"windows\": \"$IMAGE_WINDOWS_ID\"
  },
  \"flavors\": {
      \"docker_small\": \"$FLAVOR_DOCKER_SMALL_ID\",
      \"docker_medium\": \"$FLAVOR_DOCKER_MEDIUM_ID\",
      \"docker_mediump\": \"$FLAVOR_DOCKER_MEDIUMP_ID\",
      \"docker_large\": \"$FLAVOR_DOCKER_LARGE_ID\",
      \"docker_xlarge\": \"$FLAVOR_DOCKER_XLARGE_ID\",
      \"docker_2xlarge\": \"$FLAVOR_DOCKER_2XLARGE_ID\",
      \"docker_2xlargep\": \"$FLAVOR_DOCKER_2XLARGEP_ID\",
      \"machine_medium\": \"$FLAVOR_MACHINE_MEDIUM_ID\",
      \"machine_large\": \"$FLAVOR_MACHINE_LARGE_ID\",
      \"machine_xlarge\": \"$FLAVOR_MACHINE_XLARGE_ID\",
      \"machine_2xlarge\": \"$FLAVOR_MACHINE_2XLARGE_ID\",
      \"macos_medium\": \"$FLAVOR_MACOS_MEDIUM_ID\",
      \"macos_large\": \"$FLAVOR_MACOS_LARGE_ID\",
      \"windows_medium\": \"$FLAVOR_WINDOWS_MEDIUM_ID\",
      \"windows_large\": \"$FLAVOR_WINDOWS_LARGE_ID\",
      \"windows_xlarge\": \"$FLAVOR_WINDOWS_XLARGE_ID\",
      \"windows_2xlarge\": \"$FLAVOR_WINDOWS_2XLARGE_ID\",
      \"gpu_machine_small\": \"$FLAVOR_GPU_MACHINE_SMALL_ID\",
      \"gpu_machine_medium\": \"$FLAVOR_GPU_MACHINE_MEDIUM_ID\",
      \"gpu_windows_small\": \"$FLAVOR_GPU_WINDOWS_SMALL_ID\",
      \"gpu_windows_medium\": \"$FLAVOR_GPU_WINDOWS_MEDIUM_ID\"
  }
}" > .infra-opts.json

image_id=$(jq .images.${IMAGE_NAME} .infra-opts.json)
flavor_id=$(jq .flavors.${FLAVOR_NAME} .infra-opts.json)
echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $flavor_id,
  \"image\": $image_id
}" > .cb_client.json
