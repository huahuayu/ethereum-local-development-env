#!/bin/bash
WORKING_DIR=$(cd $(dirname $0);pwd)
cd $WORKING_DIR
source config/config.conf
NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"miner1"}
ARGS=${@:2}
ARGS=${ARGS:-$NODE_ARGS}
./run_node.sh $NODE_NAME --mine --miner.etherbase=${ETHERBASE} --miner.threads=4 $ARGS
