FROM my-hadoop-base

WORKDIR /root

COPY configs/core-site.xml $HADOOP_HOME/etc/hadoop/
COPY configs/hdfs-site.xml $HADOOP_HOME/etc/hadoop/

COPY hdfs_namenode/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /hdfs/namenode

ENTRYPOINT ["/entrypoint.sh"]