### Test Scenario

Benchmarking BMGS Update API.


### Test Environment Details
1. No of AKS node -24
2. No of learner service replicas - 8
3. Release version - 


**API End Point:** 
`/api/user/v1/update`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```


e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-bmgs-update user-bmgs-update_Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv  ~/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /api/user/v1/update```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` with valid userIds and user access token.

### Test Result

|API          |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------|------------|--------|---------| -------------|--------------|---------|--------|
|BMGS Update  |200         |500000  |0(0.00%) | 1832.3       | 91           |  583    |1380.95 |
