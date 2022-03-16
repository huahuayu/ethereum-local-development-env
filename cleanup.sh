#!/bin/bash
WORKING_DIR=$(cd $(dirname $0);pwd)
cd $WORKING_DIR
source config/config.conf
rm -rf $DATA_DIR
