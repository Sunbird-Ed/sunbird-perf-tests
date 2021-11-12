### Test Scenario

Benchmarking User Self Declaration API.


### Test Environment Details
1. No of AKS node - 16
2. No of learner service replicas - 16 (1 Core and 3 GB)
3. Cassandra Cluster- 5 Nodes (CPU- 8Core; Memory- 32GB)
4. ES Cluster - 3 nodes (CPU- 16core ; Memory- 64GB)
5. Release version - Release 4.3.0


**API End Point:** 
`/api/user/v1/declarations`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```


e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-self-declaration user-self-declaration_Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv  ~/sunbird-perf-tests/sunbird-platform/account-merge/userData.csv /api/user/v1/declarations```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` file with valid userIds and user access token
- 

### Test Result:

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|Self Declaration   |200         |2000000 |0(0.00%) | 3269.1       | 58          |  87     |104      |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Learner Service (CPU-1 Core; Memory- 3 GB)  |99% |  895 MiB  |
| Cassandra (CPU- 16Core; Memory- 64GB)|   28.95% |13.19 GB|
| ES (CPU- 16core ; Memory- 64GB)|   3.88%    | 28.51 GB|
