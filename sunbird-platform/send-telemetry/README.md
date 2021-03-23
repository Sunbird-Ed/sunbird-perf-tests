### Test Scenario

Benchmarking Merge Account API.


### Test Environment Details
1. No of AKS node - 24
2. No of learner service replicas - 
3. Release version - 


**API End Point:** 
`/api/data/v1/telemetry`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <TELEMETRY_FILE_PATH> <pathPrefix> ```


e.g. 

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' send-telemetry send-telemetry 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/ /api/data/v1/telemetry```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Need to add telemetry gz file in `~/sunbird-perf-tests/sunbird-platform/testdata/` location



### Test Result

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|Send Telemetry     |800         |4000000 |0(0.00%) | 3326.5       | 233          |  483    |565     |
