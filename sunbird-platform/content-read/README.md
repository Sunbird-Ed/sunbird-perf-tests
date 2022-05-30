### Test Scenario: ```Cached API```

Benchmarking content read API.


### Test Environment Details:
1. No of AKS node - 16
2. No of content service replica - 6 (1 Core and 3 GB)
3. ES Cluster - 3 Nodes  (CPU - 16core ; Memory - 32 GB)
4. Cassandra Cluster- 5 Nodes (CPU- 8Core; Memory- 32GB)
5. Redis - 1 node  (CPU- 2core; Memory - 8GB)
6. Release version - Release 4.8.0


**API End Point:** 
`/api/content/v1/read`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' content-read content-read-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/contents.csv /api/content/v1/read```


**Notes**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `contents.csv` file data with content Ids

### Test Result:

| API           | Thread Count  | Samples  | Errors %     | Throughput/sec |Avg Resp Time|95th pct| 99th pct |
| ------------- | ------------- | -------- | -------------| ---------------|-------------|--------|----------|
| Content Read  | 200           | 20000000  | 0 (0.00%) | 30073.8          |    1      |    2  |    6    |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Content Service (CPU- 1core; Memory- 3GB)  |32% |472 MiB 	|
| Cassandra (CPU- 16Core; Memory- 64GB)|15.40% | 13.22 GB|
