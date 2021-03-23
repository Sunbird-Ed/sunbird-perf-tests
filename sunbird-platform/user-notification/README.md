### Test Scenario

Benchmarking User Notification API.


### Test Environment Details
1. No of AKS node - 24
2. No of learner service replicas - 
3. Release version - 


**API End Point:** 
`/api/user/v2/notification`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-notification user-notification_Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/account-merge/userData.csv /api/user/v2/notification```


**Note**

- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` with valid users email Ids.


### Test Result

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |
|-------------------|------------|--------|---------| -------------|--------------|
|User Notification  |200         |1000000 |0(0.00%) | 1830.7       | 99           |
