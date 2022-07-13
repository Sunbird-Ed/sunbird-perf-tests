### Test Scenario

Benchmarking BMGS Update API.


### Test Environment Details
1. No of AKS node - 16
2. No of learner service replicas - 16 (1Core and 3 GB)
3. Cassandra Cluster- 7 Nodes; CPU- 8Core; Memory- 32GB
4. ES Cluster - 3 nodes; CPU- 16core ; Memory- 64GB
5. Release version - Release 4.8.0


**API End Point:** 
`/api/user/v1/update`
`/api/user/v2/update`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```


e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-bmgs-update user-bmgs-update_Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv  ~/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /api/user/v1/update```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` with valid userIds and user access token.

### Test Result:

|API          |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------|------------|--------|---------| -------------|--------------|---------|--------|
|BMGS Update -v1 |200         |2000000  |0(0.00%) | 1599.5      | 119         |  200    |294 |
|BMGS Update -v2 |200         |2000000  |0(0.00%) | 1621.8     | 118         |  191    |209 |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Learner Service (CPU-1 Core; Memory- 3 GB)  | 100%|  764 MiB|
| Cassandra (CPU- 16Core; Memory- 64GB)|50.65% |13.89 GB   |
| ES (CPU- 16core ; Memory- 64GB)|    28.50%    |   28.53 GB   |
