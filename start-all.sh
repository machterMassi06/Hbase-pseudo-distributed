#!/bin/bash
export HDFS_NAMENODE_USER=root
export HDFS_DATANODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root

export HBASE_OPTS="$HBASE_OPTS -Djava.net.preferIPv4Stack=true"

#JMX
export HBASE_MASTER_OPTS="$HBASE_MASTER_OPTS -javaagent:/usr/local/jmx/jmx_prometheus_javaagent.jar=9404:/usr/local/jmx/hbase-jmx.yml"
export HBASE_REGIONSERVER_OPTS="$HBASE_REGIONSERVER_OPTS -javaagent:/usr/local/jmx/jmx_prometheus_javaagent.jar=9405:/usr/local/jmx/hbase-jmx.yml"

service ssh start 

echo "Starting Hadoop..."

start-dfs.sh 
start-yarn.sh 

echo "Starting Hbase ..."
hbase-daemon.sh start zookeeper
start-hbase.sh 

echo "pseudo distributed cluster ready ."

tail -f /dev/null 