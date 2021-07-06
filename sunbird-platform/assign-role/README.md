### Test Scenario:

Benchmarking Assign Role API.

### Test Environment Details:
1. No of AKS node - 16
2. No of learner service replica - 16 (1 Core and 3 GB)
4. ES Cluster - 3 nodes (CPU- 16core ; Memory- 64GB)
5. Cassandra Cluster- 5 Nodes (CPU- 16Core; Memory- 64GB)
6. Release version - Release 3.9.0

**API End Point:** 
`/api/user/v1/role/assign`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g. 

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP'  assign-role assign-role 5 1 5 "ABCDEFabcdef012345" yourdomain username@yopmail.com  ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /api/user/v1/role/assign```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- `yourdomain` provide Domain Name here 
- `username@yopmail.com` provide valid user account email. This is used to generate the user token.
- Update `userData.csv` with valid user details.

### Test Result:


| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Assign Role   | 200           | 2000000   | 0 (0.00%) | 2686.3         |   72         |      110    |  194       |

### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Learner Service (CPU-1 Core; Memory- 3 GB)  |100% |869 MiB|
| Cassandra (CPU- 16Core; Memory- 64GB)| 29.76% | 28.46 GB|
| ES (CPU- 16core ; Memory- 64GB)|19.04% | 28.46 GB|
