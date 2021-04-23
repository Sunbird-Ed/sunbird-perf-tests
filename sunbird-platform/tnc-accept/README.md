### Test Scenario

Benchmarking TNC Accept API.


### Test Environment Details
1. No of AKS node - 24
2. No of learner service replicas - 8
3. Cassandra Cluster- 5 Nodes; CPU- 16Core; Memory- 64GB
4. ES Cluster - 3 nodes; CPU- 16core ; Memory- 64GB
5. Release version - 3.2.0


**API End Point:** 
`/api/user/v1/tnc/accept`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' tnc-accept tnc-accept_Run1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/ext-user-data/userToken.csv /api/user/v1/tnc/accept```

**Note**

- tnc version which is there in `tnc-accept.jmx` file should match with the tnc version in Database.
- Update `userToken.csv` file with valid userIds and user access token.
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.


### Test Result

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|TNC Accept         |200         |1000000 |0(0.00%)| 4005.7        | 48           |  65     |104.99  |
