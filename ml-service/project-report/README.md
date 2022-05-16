### Test Scenario:
Benchmarking `Project Full Report` API.

### Test Environment Details:
1. ml-projects - 8 pods (1Core, 1GB) 
2. Mongo DB (4core, 16GB)
3. Release version - Release 4.7.0

**API End Point:** `/api/reports/mlprojects/v1/detailView`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' project-report project-report-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/ml-services/testdata/entityIds.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/reports/mlprojects/v1/detailView ```

**Note**
- Update `host.csv` with valid domain details
- Update `userdata.csv` with valid user accesstoken data
- Update `entityIds.csv` with valid entityIds


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Project Full Report  | 100        |  1500000  | 0 (0.00%) | 1643.5       |     59    |   103    |	150|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-projects - 16 pods (1core and 1GB)|70%|7%|
|Mongo DB (4core, 16GB)| 100%|555.56 MB|
