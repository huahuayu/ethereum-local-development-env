#!/bin/bash
WORKING_DIR=$(cd $(dirname $0);pwd)
cd $WORKING_DIR
source config/config.conf
echo $(docker logs ${BOOTNODE_CONTAINER} 2>&1 | grep enode | head -n 1)