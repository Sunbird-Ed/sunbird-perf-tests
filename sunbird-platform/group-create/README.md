### Test Scenario

Benchmarking Group Create API.


### Test Environment Details
1. No of AKS node - 24
2. No of group service replicas - 2
3. Cassandra Cluster- 5 Nodes; CPU- 16Core; Memory- 64GB
4. Release version - Release 2.8.0


**API End Point:** 
`/api/group/v1/create`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' group-create group-create_ID01 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/testdata/host.csv ~/sunbird-platform/testdata/groups_testdata/userToken.csv  /api/group/v1/create ```

**Notee**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userToken.csv` file with valid user access tokens.



### Test Result

| API             | Thread Count  | Samples  | Errors%   | Throughput/sec  | Avg Resp Time |   95th pct  |  99th pct   |
| ----------------| ------------- | -------- | --------- | --------------- | --------------|-------------|-------------|
| Group Create    | 200           | 1000000  | 0(0.00%)  | 3954.8          | 44            |    48       |   69.99     |
