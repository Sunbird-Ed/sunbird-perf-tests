### Test Scenario

Benchmarking Send Telemetry API.


### Test Environment Details
1. No of AKS node - 16
2. No of telemetry service replicas - 16 (1 Core and 1 GB)
3. Kafka Cluster - 3 nodes (CPU - 4core and Memory - 16GB)
4. Release version - Release 4.8.0


**API End Point:** 
`/api/data/v1/telemetry`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <TELEMETRY_FILE_PATH> <pathPrefix> ```


e.g. 

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' send-telemetry send-telemetry 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/ /api/data/v1/telemetry```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Need to add telemetry gz file in (`~/sunbird-perf-tests/sunbird-platform/testdata/`) location



### Test Result:

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|Send Telemetry     |200         |4000000 |0(0.00%) | 7425.2      | 25         |  52.95    |69.99    |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Telemetry Service (CPU-1 Core; Memory- 1 GB)  |100% |10% |
| Kafka (CPU - 4core; Memory - 16GB)|   33.68% | 5.016 GB    |
