### Test Scenario:
Benchmarking `Sync Project` API.

### Test Environment Details:
1. ml-projects - 16 pods (1Core, 1GB) 
2. Mongo DB (16core, 32GB)
3. Release version - Release 4.8.0

**API End Point:** `/api/userProjects/mlprojects/v1/sync`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' sync-project sync-project-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/sync_project_testdata.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/userProjects/mlprojects/v1/sync ```

**Note**
- Update `host.csv` with valid domain details
- Update `userdata.csv` with valid user accesstoken data
- Update `sync_project_testdata.csv` with valid projectIds


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Sync Project  | 200        |  4000000  | 90 (0.00%) | 3222.7      |     57    |   204    |	254|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-projects - 16 pods (1core and 1GB)|100%|8%|
|Mongo DB (16core, 32GB)| 12%|2.1923 GB|
