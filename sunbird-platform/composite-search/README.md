### Test Scenario:

Benchmarking Composite Search API.


### Test Environment Details:
1. No of AKS node - 16
2. No of search service replicas - 6 (1Core and 3GB)
3. ES Cluster - 3 Nodes; CPU - 16core ; Memory - 32 GB
4. Release version - Release 4.3.0


**API End Point:** `/api/composite/v1/search`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' composite-search composite-search-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/dialcodes.csv /api/composite/v1/search```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `dialcodes.csv` file data with valid dialcodes.

### Test Result:

| API               | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time |   95th pct |  99th pct   |
| ------------------| ------------- | -------- | --------- | --------------- |--------------|------------|-------------|
| Composite Search | 200           |2000000  |  0(0.00%) | 2705        |71         | 66             |85         |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Search Service (CPU-1 Core; Memory- 3 GB)  |89% | 540 MiB |
| ES (CPU- 8core ; Memory- 32GB)|56.46%  |19.5943 GB	|
