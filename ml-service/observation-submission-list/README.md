### Test Scenario:
Benchmarking `Observation Submission List` API.

### Test Environment Details:
1. ml-survey - 8 pods (1Core, 1GB) 
2. Mongo DB (4core, 16GB)
3. Release version - Release 4.7.0

**API End Point:** `/api/observationSubmissions/mlsurvey/v1/list`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' observation-submission-list observation-submission-list-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/observationId_entityId.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/observationSubmissions/mlsurvey/v1/list```

**Note**
- Update `userdata.csv` with valid user accesstoken data
- Update `observationId_entityId.csv` with valid observationIds
- Update `host.csv` with valid domain details

### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Create Project From Template  | 100           |  2000000 | 0 (0.00%) | 2224.8       |     43   |   199    |	231|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-survey - 8 pods (1core and 1GB)|96%|7%|
|Mongo DB (16core, 32GB)| 27%| 1.12 GB   |

