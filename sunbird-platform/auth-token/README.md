### Test Scenario:

Benchmarking Auth Tokene API.

### Test Environment Details:
1. No of AKS node - 16
2. No of learner service replicas - 8 (1Core and 3GB)
3. KeyCloak - 4 KeyCloak servers (CPU- 4core ; Memory- 16GB)
4. ES Cluster - 3 nodes (CPU- 8core ; Memory- 32GB)
5. Cassandra Cluster- 7 Nodes (CPU- 16Core; Memory- 64GB)
6. Release version - Release 4.8.0


**API End Point:** `/auth/realms/sunbird/protocol/openid-connect/token`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' auth-token auth-token 5 1 5 "ABCDEFabcdef012345" /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /auth/realms/sunbird/protocol/openid-connect/token ```

**Note:**

- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` file with valid user details (FirstName, userName, Email,	userId)


### Test Result 

| API           | Thread Count  | Samples  | Errors% | Throughput/sec|Avg Resp Time|   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------| ---------------|------------|-------------|-------------|
| Auth Token    | 200           | 1000000   | 0(0.00%)| 526.7           |    295     | 351.95      |  566.98   |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max)|
| ------------- | ------------- |------------- |
|Learner Service (CPU-1 Core; Memory- 3 GB)  |98% | 888 MiB   |
|Cassandra (CPU- 16Core; Memory- 64GB)|  9.47%  |  13.85 GB |
|KeyCloak (CPU- 4core ; Memory- 16GB)|47.59%| 6.623 GB|
