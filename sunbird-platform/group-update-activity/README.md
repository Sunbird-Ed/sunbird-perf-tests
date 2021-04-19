### Test Scenario

Benchmarking Group Activity Update API.


### Test Environment Details
1. No of AKS node - 24
2. No of Group service replicas - 2
3. Release version - Release 2.8.0


**API End Point:** 
`/api/group/v1/update`


**Executing the test scenario using JMeter**

```
./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>
````
e.g.
```
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' group-update-activity group-update-activity_RunID01 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/create-group/host.csv ~/sunbird-platform/group-update-activity/groupData.csv /api/group/v1/update
```


**Note**
-  Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `groupData.csv` with valid groups Ids

### Test Result

|API                  |Thread Count|Samples |Errors% |Throughput/sec| Avg Resp Time |95th pct |99th pct|
|---------------------|------------|--------|--------|--------------| --------------|---------|--------|
|Group Update Activity|150         |1125000 |0(0.00%)|5203.1        | 24            |  20     |30      |
