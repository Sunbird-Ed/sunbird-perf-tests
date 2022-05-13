### Test Scenario:
Benchmarking Create observation for task API.

### Test Environment Details:
1. ml-projects - 8 pods (1core and 1GB)
2. Mongo DB (4core, 16GB)
3. Release version - Release 4.8.0

**API End Point:** `/api/userProjects/mlprojects/v1/solutionDetails`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

 ```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' create-observation-for-task create-observation-for-task-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/solutionDetails.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/userProjects/mlprojects/v1/solutionDetails```

**Note**
- Update `userdata.csv` with valid user accesstoken data
- Update `solutionDetails.csv` with valid solutions Ids

### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Create observation  | 100           |  2500000  | 0 (0.00%) | 2839.3       |     33     |   159     |	191|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-projects 8 pods (1core and 1GB)|100%|7%|
|Mongo DB (4core, 16GB)| 17%| 756.859 MB    |
