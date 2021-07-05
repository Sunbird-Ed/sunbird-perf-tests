### Test Scenario:

Benchmarking Course Batch Enrol API.


### Test Environment Details:
1.  No of AKS node - 16
2.  No of LMS service replicas - 16 (1Core and  1 GB)
3.  ES Cluster - 3 nodes (CPU- 16core ; Memory- 64GB)
4.  Cassandra Cluster- 5 Nodes (CPU- 8Core; Memory- 32GB)
5.  Release version - Release 3.9.0


**API End Point:** 
`/api/course/v1/enrol`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' course-batch-enrol course-batch-enrol-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /api/course/v1/enrol```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- course-batch-enrol.jmx file request body needs to be updated with valid courseId and batchId details.
- Update `userData.csv` file with valid user details. 


### Test Result

| API                 | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time|  95th pct | 99th pct |
| ------------------- | ------------- | -------- | --------- | --------------- |-------------|-----------|----------|
| Course Batch Enrol  | 200           | 1000000  | 0 (0.00%) | 4921          |       39    |    75   |   83   |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|LMS Service (CPU-1 Core; Memory- 1 GB)  |82% |538 MiB  |
|Cassandra (CPU- 16Core; Memory- 64GB)| 19.28% |13.75 GB |
