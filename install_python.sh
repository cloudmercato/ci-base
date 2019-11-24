#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt -y update
apt install -y -q python3

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

echo -e "{
  \"images\": {
      \"amd64_linux_xenial\": \"$AMD64_XENIAL_IMAGE_ID\",
      \"arm64_linux_xenial\": \"$ARM64_XENIAL_IMAGE_ID\",
      \"amd64_osx_\": \"$AMD64_OSX_IMAGE_ID\"
  },
  \"flavors\": {
      \"amd64_linux\": \"$AMD64_LINUX_FLAVOR_ID\",
      \"amd64_osx\": \"$AMD64_OSX_FLAVOR_ID\"
  }
}" > .infra-opts.json
image_id=$(jq .images.${TRAVIS_CPU_ARCH}_${TRAVIS_OS_NAME}_${TRAVIS_DIST} .infra-opts.json)
flavor_id=$(jq .flavors.${TRAVIS_CPU_ARCH}_${TRAVIS_OS_NAME} .infra-opts.json)
echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $flavor_id,
  \"image\": $image_id
}" > .cb_client.json

pip install https://github.com/cloudspectatordevelopment/cb-client/archive/master.tar.gz
