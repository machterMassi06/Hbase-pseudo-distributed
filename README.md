# HBase Pseudo-Distributed Cluster with HDFS

A Dockerized **Hadoop + HBase pseudo-distributed cluster** with integrated monitoring using **JMX Exporter**, **Prometheus**, and **Grafana**.

# Architecture

The Hadoop-HBase cluster Docker image (see [Dockerfile](./Dockerfile)) contains:

* Java 11
* Hadoop 3.3.6
* HBase 2.5.8 (compatible with Hadoop 3.3.x)
* HDFS (pseudo-distributed mode)
* YARN
* SSH and basic system utilities
* ZooKeeper (embedded HBase mode)

**CI**: In this repository, the GitHub Actions workflow automatically builds and pushes the **hadoop-hbase-cluster** Docker image to Docker Hub (`massmach/hadoop-hbase-cluster`) on every push to the `main` branch.

In addition to the **hadoop-hBase-cluster** image, the stack defined in [docker-compose.yml](./docker-compose.yml) includes:

* Prometheus
* Grafana
* JMX Exporter

**Monitoring Architecture**:

In this pseudo-distributed mode, HBase runs a single **HMaster** and a single **HRegionServer**. JMX Exporter exposes metrics from both services, which are then scraped by Prometheus and visualized in Grafana.

```text
    HMaster     -------- 
                        |
                        --> JMX Exporter --> Prometheus --> Grafana (dashboard)
                        |
    HRegionServer-------
```

---

# Setup  

## Start the Stack

Build and start all services:

```bash
docker compose up -d 
```


## Verify Containers

```bash
docker compose ps
```

Expected services:

```text
NAME                    STATUS
hadoop-hbase-cluster    Up
prometheus              Up
grafana                 Up
```

---

# Verify Hadoop Hbase Cluster

## Enter the Hadoop/HBase Container

```bash
docker exec -it hadoop-hbase-cluster bash
```

Check running Java processes:

```bash
jps 
```

Expected output:

```text
NameNode
DataNode
SecondaryNameNode
ResourceManager
NodeManager
HMaster
HRegionServer
HQuorumPeer
Jps
```

## Verify HBase 

Open HBase shell:

```bash
hbase shell
```

Check cluster status:

```ruby
status 'detailed'
```

Expected:

```text
...
1 live servers
...
0 dead servers
```

## Access Cluster Web Interfaces

you can access:

* Hadoop NameNode UI → [http://localhost:9870](http://localhost:9870)
* YARN ResourceManager UI → [http://localhost:8088](http://localhost:8088)
* HBase Master UI → [http://localhost:16010](http://localhost:16010)

---

# Monitoring

## Verify JMX Exporter Endpoints

HMaster metrics:

```bash
curl http://localhost:9404/metrics
```

RegionServer metrics:

```bash
curl http://localhost:9405/metrics
```

You should see Prometheus-formatted metrics.

Example:

```text
jvm_memory_bytes_used
hadoop_*
hbase_*
```


## Prometheus

To get acces to Prometheus, Open in your browser:

```text
http://localhost:9091
```

Useful queries:

```promql
up
```


## Grafana

To acces Grafana , in your browser open:

```text
http://localhost:3001
```

Default credentials:

```text
Username: admin
Password: admin
```

After this step, you can change the default password to your own.

### Grafana Setup

1. Go to [http://localhost:3001](http://localhost:3001/)
2. Add data source → Prometheus
3. URL of the source:

```
http://prometheus:9090
```

4. Import a Kafka dashboard (example **dahboard json file** in **monitoring/grafana/**)

---

# Stop the Stack

If you want to stop all containers:

```bash
docker compose down
```

To Remove containers and all associed volumes:

```bash
docker compose down -v
```

--- 

# TODO

- Improve the hbase grafana dashboard in **monitoring/grafana/hbase-dashboard.json**
