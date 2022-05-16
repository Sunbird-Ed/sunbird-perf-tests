### Test Scenario:
Benchmarking `Create Project from Template` API.

### Test Environment Details:
1. ml-core - 8 pods (1core and 1GB)
2. ml-projects - 8 pods (1Core, 1GB) 
3. Mongo DB (16core, 32GB)
4. Release version - Release 4.8.0

**API End Point:** `/api/userProjects/mlprojects/v1/importFromLibrary`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' create-project-from-template create-project-from-templates-R1 5 15 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/templateIds.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/userProjects/mlprojects/v1/importFromLibrary```

**Note**
- Update `userdata.csv` with valid user accesstoken data
- Update `templateIds.csv` with valid templateIds 
- Update `host.csv` with valid domain details

### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Create Project From Template  | 200           |  2000000  | 10 (0.00%) | 2763.8       |     69    |   264    |	327|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 8 pods (1core and 1GB)|1%|7%|
|ml-projects -8 pods (1core and 1GB)|100%|8%|
|Mongo DB (16core, 32GB)| 14%| 17.373 GB   |

