# HBase Pseudo-Distributed Cluster with HDFS (Hadoop Pseudo-Distributed Mode)

---

## 1. Build the Hadoop Base Image

First, we build a **base Hadoop image** used by all cluster nodes (NameNode and DataNode).

This image includes:

* Java 11
* Hadoop 3.3.6
* Basic system dependencies

All commands are executed from `hbase-pseudo-distributed`:

```bash
docker build -t my-hadoop-base ./hadoop
```

---

### Verify the image

```bash
sudo docker images
```

Expected output:

```text
IMAGE                     TAG       IMAGE ID       SIZE
my-hadoop-base           latest    9359341f2409   ~2.2GB
```

---

## 2. Start HDFS in Pseudo-Distributed Mode

We launch a **pseudo-distributed HDFS cluster** using Docker Compose.

This cluster consists of:

* 1 NameNode (metadata manager)
* 1 DataNode (storage node; more can be added in `docker-compose.yml` depending on resources)

Note:
All nodes use the same base image (`my-hadoop-base`) but run different roles via entrypoints and configuration.

---

### Start the cluster

```bash
sudo docker compose up -d
```

---

### Check running containers

```bash
sudo docker ps
```

Expected output:

```text
CONTAINER ID   IMAGE                     NAME
xxxx           hdfs_namenode            namenode
xxxx           hdfs_datanode            datanode1
```

---

## 3. Access HDFS Web Interfaces

* NameNode UI:
  [http://localhost:9870](http://localhost:9870)

* HDFS RPC endpoint (used later by HBase):
  hdfs://localhost:9000

---

## 4. Why this is important

This HDFS cluster will be used by HBase to:

* Store region data (HFiles)
* Provide distributed storage for tables

---

## 5. Verify the hadoop cluster

### Step 1: Enter NameNode

```bash
docker exec -it namenode bash
```

### Step 2: Check DataNodes

```bash
hdfs dfsadmin -report
```

Expected:

```text
Live datanodes (1):
```

This means:

* NameNode is running
* DataNode is connected
* Cluster is working

---

## 6. HBase pseudo-distributed (next step)

TODO:

* Install HBase in a container
* Configure `hbase-site.xml`
* Point HBase to HDFS (`hdfs://namenode:9000`)
* Start HBase Master + RegionServer
* Validate with HBase shell (`create`, `put`, `scan`)
