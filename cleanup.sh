#!/bin/bash
WORKING_DIR=$(cd $(dirname $0);pwd)
cd $WORKING_DIR
source config/config.conf
echo "clean up..."
for i in $(docker ps | grep ${CHAIN}- | awk '{print $NF}'); do echo -n "rm container: " && docker rm -f $i; done
echo "rm datadir: $DATA_DIR" && rm -rf $DATA_DIR
echo "done"
