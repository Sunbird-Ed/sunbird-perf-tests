### Test Scenario:
Benchmarking `Report Program Filters` API.

### Test Environment Details:
1. ml-projects - 8 pods (1Core, 1GB) 
2. Mongo DB (4core, 16GB)
3. Release version - Release 4.7.0

**API End Point:** `/api/reports/mlprojects/v1/getProgramsByEntity`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' reports-program-filter reports-program-filter-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/entityId.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/reports/mlprojects/v1/getProgramsByEntity ```

**Note**
- Update `host.csv` with valid domain details
- Update `userdata.csv` with valid user accesstoken data
- Update `entityId.csv` with valid entityIds


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Report Program Filters  | 100        |  4000000  | 5 (0.00%) | 3906.8      |     24    |  91    |	136|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-projects - 8 pods (1core and 1GB)|100%|7%|
|Mongo DB (4core, 16GB)| 84%| 454.07 MB |
