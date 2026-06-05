#!/bin/bash
export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root

service ssh start 

echo "Starting Hadoop..."

start-dfs.sh 
start-yarn.sh 

echo "Starting Hbase ..."

start-hbase.sh 

echo "pseudo distributed cluster ready ."

tail -f /dev/null 