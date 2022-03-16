#!/bin/bash
# init
WORKING_DIR=$(cd $(dirname $0);pwd)
cd $WORKING_DIR
source config/config.conf
if [ ! -e $DATA_DIR ]; then
    mkdir -p $DATA_DIR
fi

NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"node1"}
CONTAINER_NAME=${CHAIN}-${NODE_NAME}
NODE_DIR=${DATA_DIR}/${NODE_NAME}
DATA_HASH=${DATA_DIR}/${NODE_NAME}/ethash

echo "Destroying old container $CONTAINER_NAME..."
docker rm -f $CONTAINER_NAME &> /dev/null
BOOTNODE_URL=$(./get_bootnode_url.sh)
if [ ! -f $GENESIS_FILE ]; then
    echo "No genesis.json file found. Aborting."
    exit
fi

if [ ! -d $NODE_DIR/keystore ]; then
    echo "$NODE_DIR/keystore not found, running 'geth init'..."
    echo "$DATA_DIR/$GENESIS_FILE"
    docker run --rm \
        -v $NODE_DIR:/root/.ethereum \
        -v $WORKING_DIR/$GENESIS_FILE:/opt/genesis.json \
        $TOOLS_IMAGE geth init /opt/genesis.json
    echo "...done!"
fi

# creates docker network
if [[ $DOCKER_NETWORK -ne "host" ]]
then
    [ ! "$(docker network ls | grep $DOCKER_NETWORK)" ] && docker network create $DOCKER_NETWORK
fi

echo "Running new container $CONTAINER_NAME..."
docker run -d --name $CONTAINER_NAME \
    --network $DOCKER_NETWORK \
    -v $NODE_DIR:/root/.ethereum \
    -v $DATA_HASH:/root/.ethash \
    -v $DATA_DIR/${GENESIS_FILE}/genesis.json:/opt/genesis.json \
    $TOOLS_IMAGE geth --bootnodes=$BOOTNODE_URL $NODE_ARGS --cache=512 --verbosity=4 --maxpeers=10 ${@:2}