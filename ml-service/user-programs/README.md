### Test Scenario:
Benchmarking `userPrograms` API.

### Test Environment Details:
1. ml-core - 8 pods (1Core, 1GB) 
2. Mongo DB (16core, 32GB)
3. Release version - Release 4.8.0

**API End Point:** `/api/users/mlcore/v1/programs?isAPrivateProgram=false&page=1&limit=25&search=`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' user-programs user-programs-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/searchData.csv ~/sunbird-perf-tests/testdata/locationData.csv /api/users/mlcore/v1/programs```

**Note**
- Update `host.csv` with valid domain details
- Update `searchData.csv` file with search text
- Update `locationData.csv` file with valid location details

### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| userPrograms  | 200        |  5000000 | 37 (0.00%) | 3634.1      |     52    |   171    |	230|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 8 pods (1core and 1GB)|100%|8%|
|Mongo DB (16core, 32GB)| 5%|  4.2172 GB  |
