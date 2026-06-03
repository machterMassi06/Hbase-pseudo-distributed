FROM ubuntu:24.04

WORKDIR /root

RUN apt-get update && \
    apt-get install -y \
        openjdk-11-jdk \
        openssh-server \
        ssh \
        wget \
        curl \
        vim \
        python3 && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz&& \
    tar -xzf hadoop-3.3.6.tar.gz && \
    mv hadoop-3.3.6 /usr/local/hadoop && \
    rm hadoop-3.3.6.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

ENV HADOOP_HOME=/usr/local/hadoop
ENV HADOOP_COMMON_HOME=/usr/local/hadoop
ENV HADOOP_HDFS_HOME=/usr/local/hadoop
ENV HADOOP_MAPRED_HOME=/usr/local/hadoop
ENV YARN_HOME=/usr/local/hadoop

ENV HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR=/usr/local/hadoop/etc/hadoop

ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin

CMD ["/bin/bash"]