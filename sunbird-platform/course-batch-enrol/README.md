How to run ?

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' course-batch-enrol course-batch-enrol-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /api/course/v1/enrol```


**Note**
- course-batch-enrol.jmx file request body needs to be updated with valid courseId and batchId data.

**Test Scenario:**

Verify the Course Batch Enroll api scalability

**Test Result**

| API                 | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time|  95th pct | 99th pct |
| ------------------- | ------------- | -------- | --------- | --------------- |-------------|-----------|----------|
| Course Batch Enroll | 300           | 1500000  | 0 (0.00%) | 4248.8          |       69    |     110   |   130    |
