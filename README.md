# HBase Pseudo-Distributed Cluster with HDFS

---

## 1. Build the Hadoop + HBase Base Image

First, we build a single **Docker image** that contains both Hadoop and HBase in pseudo-distributed mode.

This image includes:

* Java 11
* Hadoop 3.3.6
* HBase (compatible version for Hadoop 3)
* SSH + basic system utilities

From the project root:

```bash
sudo docker build -t hadoop-hbase-cluster .
```

---

### Verify the image

```bash
sudo docker images
```

You should see your image listed:

```text
REPOSITORY              TAG       IMAGE ID       SIZE
hadoop-hbase-cluster    latest    xxxxxxxx       xxxMB
```

---

## 2. Run the Pseudo-Distributed Cluster

### Start the container

```bash
docker run -d -p 9870:9870 -p 8088:8088 -p 16010:16010 hadoop-hbase-cluster
```

---

### Check running container

```bash
sudo docker ps
```

Example output:

```text
CONTAINER ID   IMAGE                  STATUS   PORTS
cc27bda19a49   hadoop-hbase-cluster   Up       9870, 8088, 16010
```

---

### Enter the container

```bash
sudo docker exec -it <container_id> bash
```

Check Hadoop processes:

```bash
jps
```

Expected processes:

* NameNode
* DataNode
* SecondaryNameNode
* ResourceManager
* NodeManager
* HMaster
* HRegionServer
* HQuorumPeer

---

## 3. Access Web Interfaces

Once the cluster is running, you can access:

* Hadoop NameNode UI → [http://localhost:9870](http://localhost:9870)
* YARN ResourceManager UI → [http://localhost:8088](http://localhost:8088)
* HBase Master UI → [http://localhost:16010](http://localhost:16010)

---

## 4. Important Notes

This pseudo-distributed setup uses:

* A single Docker container
* Local HDFS (not real multi-node hdfs cluster)
* Embedded HBase running on top of Hadoop HDFS

---

- TO DO : FIX RPC in hbase shell : aucun commande ne marche car le master tombe a chaque fois !!