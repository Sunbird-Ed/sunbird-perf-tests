### Test Scenario

Benchmarking Page Assemble API with "?orgdetails=orgName,email" params.


### Test Environment Details
1. No of AKS node - 16
2. No of lms service replicas - 8 (1 Core and 3 GB)
3. No of search service replicas - 8 (1 Core and 3 GB)
4. Cassandra Cluster- 5 Nodes (CPU- 8Core; Memory- 32GB)
5. Release version - Release 4.3.0


**API End Point:** 
`/api/data/v1/page/assemble`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' page-assemble page-assemble-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/dialcodes.csv /api/data/v1/page/assemble```

**Notee**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `dialcodes.csv` with valid dialcodes.


### Test Result:

|API           |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|--------------|------------|--------|---------| -------------|--------------|---------|--------|
|Page Assemble |200         |1000000  |0(0.00%))| 790.5          | 251         |  400   |545.99 |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| LMS Service (CPU-1 Core; Memory- 3 GB)  |29%|  544 MiB |
| Search Service (CPU-1 Core; Memory- 2 GB)  |27% | 311 MiB |
| ES (CPU- 8core ; Memory- 32GB)| 27.33%  |19.62 GB |
