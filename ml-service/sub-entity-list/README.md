### Test Scenario:
Benchmarking `Get list of sub entity based on role and location` API.

### Test Environment Details:
1. ml-core - 8 pods (1Core, 1GB) 
2. Mongo DB (4core, 16GB)
3. Release version - Release 4.7.0

**API End Point:** `/api/entities/mlcore/v1/subEntityListBasedOnRoleAndLocation`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' sub-entity-list sub-entity-list-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/testdata/locationData.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/entities/mlcore/v1/subEntityListBasedOnRoleAndLocation ```


**Note**
- Update `host.csv` with valid domain details
- Update `userdata.csv` with valid user accesstoken data
- Update `locationData.csv` with locationIds


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Get list of sub entity based on role and location  | 100        |  3000000  | 0 (0.00%) | 2391.6      |     40    |   104    |	165.99|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 16 pods (1core and 1GB)|100%|9%|
|Mongo DB (4core, 16GB)| 36%|498.225 MB|
