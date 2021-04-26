### Test Scenario

Benchmarking Identifier Freeup API.


### Test Environment Details
1. No of AKS node - 24
2. No of learner service replicas - 8
3. Cassandra Cluster- 5 Nodes; CPU- 8Core; Memory- 32GB
4. ES Cluster - 3 nodes; CPU- 16core ; Memory- 64GB
5. Release version - NA


**API End Point:** 
`/private/user/v1/identifier/freeup`


**Executing the test scenario using JMeter**

```
./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> 
<pathPrefix>
```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-identifier-freeup user-identifier-freeup 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /private/user/v1/identifier/freeup```

**NOTE**
- Update `userData.csv` with user's email Ids.
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Same user id cannot be reused for the test once mobile number/email id identifier freeup is done


### Test Result

|API                    |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-----------------------|------------|--------|---------| -------------|--------------|---------|--------|
|User Identifier Freeup |100         |200000  |0(0.00%) | 2062.2       | 45           |  84     |175     |



