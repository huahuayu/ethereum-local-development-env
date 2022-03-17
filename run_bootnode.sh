#!/bin/bash
#
# Runs a bootnode with ethereum official "alltools" image.
#

# init
WORKING_DIR=$(cd $(dirname $0);pwd)
cd $WORKING_DIR
source config/config.conf
mkdir -p $DATA_DIR

# clean up
docker rm -f $BOOTNODE_CONTAINER &> /dev/null

# generate bootnode key if needed
mkdir -p ${BOOTNODE_DIR}
if [ ! -f ${BOOTNODE_DIR}/boot.key ]; then
    echo "${BOOTNODE_DIR}/boot.key not found, generating..."
    docker run --rm \
        -v ${BOOTNODE_DIR}:/opt/bootnode \
        $TOOLS_IMAGE bootnode --genkey /opt/bootnode/boot.key
    echo "...done!"
fi

# creates docker network
if [[ $DOCKER_NETWORK -ne "host" ]]
then
    [ ! "$(docker network ls | grep $DOCKER_NETWORK)" ] && docker network create $DOCKER_NETWORK
fi

# run bootnode image
RESULT=$( docker run -d --restart always --name $BOOTNODE_CONTAINER \
    -v ${BOOTNODE_DIR}:/opt/bootnode \
    --network $DOCKER_NETWORK \
    $TOOLS_IMAGE bootnode --nodekey /opt/bootnode/boot.key --verbosity=3 "$@" ) 

echo "bootnode container: ${BOOTNODE_CONTAINER} ${RESULT}"
BOOTNODE_URL=$(docker logs ${BOOTNODE_CONTAINER} 2>&1 | grep enode | head -n 1)
echo $BOOTNODE_URL