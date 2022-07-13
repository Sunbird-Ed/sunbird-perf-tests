### Test Scenario

Benchmarking User Existence API.


### Test Environment Details
1. No of AKS node - 16
2. No of learner service replicas - 16 (1 Core and 3 GB)
3. Cassandra Cluster- 7 Nodes (CPU- 16Core; Memory- 64GB)
4. ES Cluster - 3 nodes (CPU- 16core ; Memory- 64GB)
5. Release version - Release 4.8.0


**API End Point:** 
`/api/user/v1/exists/email`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```


e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-existence user-existence_Run1 5 1 5 "ABCDEFabcdef012345" emailid01@yopmail.com ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/account-merge/userData.csv /api/user/v1/exists/email```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` with valid user's email Ids.
- `emailid01@yopmail.com` in run command should be updated with valid users email Id.


### Test Result:

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|User Existence     |200         |2000000 |0(0.00%) | 7727       | 25           |  48     |67     |

### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Learner Service (CPU-1 Core; Memory- 3 GB)  | 99%| 639 MiB |
| Cassandra (CPU- 16Core; Memory- 64GB)| 11.20%  | 13.81 GB|
