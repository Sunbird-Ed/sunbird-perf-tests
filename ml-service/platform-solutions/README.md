### Test Scenario:
Benchmarking `Platform Solutions` API.

### Test Environment Details:
1. ml-core - 8 pods (1core and 1GB)
2. Mongo DB (4core, 16GB)
3. Release version - Release 4.7.0

**API End Point:** `/api/user-extension/mlcore/v1/solutions`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' platform-solutions platform-solutions-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/programId_role.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/user-extension/mlcore/v1/solutions```

**Note**
- Update `userdata.csv` with valid user accesstoken data
- Update `programId_role.csv` with valid programIds with roles 
- Update `host.csv` with valid domain details

### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Platform Solutions  | 100           |  2000000  | 0 (0.00%) | 1888.5       |     49   |   167    |	246.99|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 8 pods (1core and 1GB)|100%|9%|
|Mongo DB (4core, 16GB)| 41%|  492.978 MB|

