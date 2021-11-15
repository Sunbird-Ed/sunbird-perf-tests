### Test Scenario

Benchmarking User Enrollment List API.


### Test Environment Details
1. No of AKS node - 16
2. No of learner service replicas - 8 (1 Core and 3 GB)
3. No of LMS service replicas - 16 (1 Core and 1 GB)
4. Cassandra Cluster- 5 Nodes (CPU- 8Core; Memory- 32GB)
5. Release version - Release 4.3.0


**API End Point:** 
`/api/course/v1/user/enrollment/list`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-enrollment-read user-enrollment-read_Run1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /api/course/v1/user/enrollment/list```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` with valid userIds and user access token.


### Test Result:

|API                 |Thread Count|Samples |Errors%  |Throughput/sec|Avg | 95th pct | 99th pct|
|--------------------|------------|--------|---------| -------------|-----------|-------------|---------|
|User Enrollment List|200         |1000000 |0 (0.00%)| 902.6      |    217       |       299     |  378       |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| LMS Service (CPU-1 Core; Memory- 3 GB)  |60% | 520 MiB     |
| Cassandra (CPU- 16Core; Memory- 64GB)| 5.43% |13.14 GB |
