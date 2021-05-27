### Test Scenario:

Benchmarking Course Batch Enrol API.


### Test Environment Details:
1. No of AKS node - 24
2. No of learner service replicas - 8
3. No of LMS service replicas - 8
4. ES Cluster - 3 nodes; CPU- 16core ; Memory- 64GB
5. Cassandra Cluster- 5 Nodes; CPU- 8Core; Memory- 32GB
6. Release version - NA


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
| Course Batch Enrol  | 300           | 1500000  | 0 (0.00%) | 4248.8          |       69    |     110   |   130    |
