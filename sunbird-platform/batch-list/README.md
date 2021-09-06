### Test Scenario:

Benchmarking Batch List API.

### Test Environment Details:
1. No of AKS node - 16
2. No of lms service replica - 8 (1 Core and 3 GB)
4. ES Cluster - 3 nodes (CPU- 16core ; Memory- 64GB)
5. Cassandra Cluster- 5 Nodes (CPU- 16Core; Memory- 64GB)
6. Release version - Release 4.0.0

**API End Point:** 
`/api/course/v1/batch/list`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g. 

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP'  batch-list batch-list-R1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/courses.csv /api/course/v1/batch/list```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `courses.csv` with valid courses list.

### Test Result:


| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
|  Batch List  |       200    |  1000000  | 0 (0.00%) |    3448.8      |     52      |    81     |   89    |

### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| LMS Service (CPU-1 Core; Memory- 3 GB)  |100% |545 MiB |
| ES (CPU- 16core ; Memory- 64GB)|26.89% |  28.38 GB|
