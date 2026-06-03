#!/bin/bash
set -e

echo "Formatting NameNode..."

if [ ! -d "/hdfs/namenode/current" ]; then
    hdfs namenode -format -force
fi

echo "Starting NameNode..."

exec hdfs namenode