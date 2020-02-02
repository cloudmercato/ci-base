#!/bin/bash

sudo=$(which sudo)

if [[ "$SEMAPHORE_AGENT_MACHINE_OS_IMAGE" == "ubuntu"* ]] ; then
    export DEBIAN_FRONTEND=noninteractive
    $sudo apt -y -qq update
    $sudo apt install -y -q python3 jq wget bc
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
  },
  \"volume_flavors\": {
      \"e1_standard_2_VM\": \"$E1_2_VOLUME_FLAVOR_ID\",
      \"e1_standard_4_VM\": \"$E1_4_VOLUME_FLAVOR_ID\",
      \"e1_standard_8_VM\": \"$E1_8_VOLUME_FLAVOR_ID\"
  },
  \"datastore_types\": {
      \"mysql\": \"$MYSQL_DATASTORE_TYPE_ID\",
      \"redis\": \"$REDIS_DATASTORE_TYPE_ID\"
  }
}" > .infra-opts.json

image_id=$(jq .images."${SEMAPHORE_AGENT_MACHINE_OS_IMAGE//-/_}_${SEMAPHORE_AGENT_MACHINE_ENVIRONMENT_TYPE}" .infra-opts.json)
flavor_id=$(jq .flavors."${SEMAPHORE_AGENT_MACHINE_TYPE//-/_}_${SEMAPHORE_AGENT_MACHINE_ENVIRONMENT_TYPE}" .infra-opts.json)
volume_flavor_id=$(jq .volume_flavors."${SEMAPHORE_AGENT_MACHINE_TYPE//-/_}_${SEMAPHORE_AGENT_MACHINE_ENVIRONMENT_TYPE}" .infra-opts.json)
datastore_type_id=$(jq .datastore_types."${SEMAPHORE_DATABASE}" .infra-opts.json)

echo -e "{
  \"master_url\": \"$MASTER_URL\",
  \"token\": \"$TOKEN\",
  \"provider\": \"$PROVIDER_ID\",
  \"datacenter\": \"$DATACENTER_ID\",
  \"flavor\": $flavor_id,
  \"image\": $image_id
}" > .cb_client.json
echo -e "$volume_flavor_id" | sed 's/"//g' > .volume_flavor_id
echo -e "$datastore_type_id" | sed 's/"//g' > .datastore_type_id
echo -e "{
  \"host\": \"0.0.0.0\",
  \"port\": \"3306\",
  \"user\": \"root\",
  \"password\": \"\",
  \"database\": \"testdb\"
}" > .mysql.json
echo -e "{
  \"host\": \"127.0.0.1\",
  \"port\": \"6379\",
  \"password\": \"\"
}" > .redis.json
