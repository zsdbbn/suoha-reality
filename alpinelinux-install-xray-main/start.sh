#!/usr/bin/env bash

# check file(./xray/xray) is exist
if [ ! -f "./xray/xray" ]; then
    echo "error: ./xray/xray not found, please run install.sh first."
    exit 1
fi

# check file log.txt exist and rm it
if [ -f "./log.txt" ]; then
    rm -rf ./log.txt
fi

# find process ./xray/xray and kill it
ps -ef | grep "./xray/xray" | grep -v grep | awk '{print $1}' | xargs kill -9

# run ./xray/xray in backgroud
nohup ./xray/xray -c server.json > log.txt &