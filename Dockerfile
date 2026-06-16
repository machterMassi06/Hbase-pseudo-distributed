FROM ubuntu:latest

WORKDIR /root

# dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    openssh-server \
    ssh \
    wget \
    curl \
    vim \
    python3 && \
    maven && \
    rm -rf /var/lib/apt/lists/*

# SSH setup
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Hadoop 3 
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
    tar -xzf hadoop-3.3.6.tar.gz && \
    mv hadoop-3.3.6 /usr/local/hadoop && \
    rm hadoop-3.3.6.tar.gz

# HBase 
RUN wget https://archive.apache.org/dist/hbase/2.5.8/hbase-2.5.8-bin.tar.gz && \
    tar -xzf hbase-2.5.8-bin.tar.gz && \
    mv hbase-2.5.8 /usr/local/hbase && \
    rm hbase-2.5.8-bin.tar.gz

# ENV
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV HBASE_HOME=/usr/local/hbase
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HBASE_HOME/bin

#configs
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> $HBASE_HOME/conf/hbase-env.sh && \
    echo "export HBASE_MANAGES_ZK=true" >> $HBASE_HOME/conf/hbase-env.sh
COPY configs/ $HADOOP_HOME/etc/hadoop/
COPY configs/ $HBASE_HOME/conf/

# scripts
COPY start-all.sh /root/start-all.sh
RUN bash -c "chmod +x /root/start-all.sh"

# HDFS dirs
RUN mkdir -p /root/hdfs/namenode && \
    mkdir -p /root/hdfs/datanode && \
    mkdir -p /root/zookeeper

# format HDFS
RUN hdfs namenode -format

CMD ["/bin/bash", "/root/start-all.sh"]