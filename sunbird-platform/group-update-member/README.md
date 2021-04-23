### Test Scenario

Benchmarking Group  Member Update API.


### Test Environment Details
1. No of AKS node - 24
2. No of Group service replicas - 2
3. Cassandra Cluster- 5 Nodes; CPU- 16Core; Memory- 64GB
4. Release version - Release 2.8.0


**API End Point:** 
`/api/group/v1/update`


**Executing the test scenario using JMeter
```
./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_GROUPDATA_FILE> <CSV_USERDATA_FILE> <pathPrefix>
```
e.g.
```
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' group-update-member group-update-member_RunID01 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/group-update-member/host.csv ~/sunbird-platform/group-update-member/groupData.csv ~/sunbird-platform/group-update-member/userData.csv /api/group/v1/update
```

**Note**
-  Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `groupData.csv` with valid groups Ids.
- Update `userData.csv` with valid user Ids.



### Test Result

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|Group Update Member|200         |1000000 |0(0.00%) | 5479.4       | 31           |  37     |52.99   |
