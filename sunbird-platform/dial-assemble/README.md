
### Test Scenario

Benchmarking Dial Assemble API.


### Test Environment Details
1. No of AKS node - 16
2. No of search service replicas - 8 (1 core and 3 GB)
4. ES Cluster - 3 nodes (CPU- 8core ; Memory- 32GB)
5. Cassandra Cluster- 5 Nodes (CPU- 16Core; Memory- 64GB)
6. Release version - Release 3.9.0


**API End Point:** 
`/api/data/v1/dial/assemble`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' dial-assemble dial-assemble-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/dialcodes.csv /api/data/v1/dial/assemble```



**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `dialcodes.csv` file data with valid dialcodes.



### Test Result:

| API           | Thread Count  | Samples  | Errors%   | Throughput/sec|Avg Resp Time| 95th pct | 99th pct |
| ------------- | ------------- | -------- | --------- | --------------|-------------|----------|----------|
| Dial Assemble | 200           | 500000   | 0(0.00%)  | 845.7        |    234      |     397  |  505.99 |


### Server Utilisation:
| Backend       | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| LMS Service (CPU- 1Core; Memory- 3GB)  |36% |548 MiB   |
| Search Service (CPU- 1Core; Memory- 3GB)  | 42%|431 MiB |
| ES (CPU- 8core ; Memory- 32GB)| 30.13%|19.58 GB |
