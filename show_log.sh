#!/bin/bash
WORKING_DIR=$(cd $(dirname $0);pwd)
cd $WORKING_DIR
source config/config.conf
NODE=$1
NODE=${NODE:-"node1"}
CONTAINER_NAME="$CHAIN-$NODE"
docker logs -f $CHAIN-$NODE