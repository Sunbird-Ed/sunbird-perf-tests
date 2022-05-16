### Test Scenario:
Benchmarking `mandatoryUserProfileFields` API.

### Test Environment Details:
1. ml-core - 8 pods (1Core, 1GB) 
2. Mongo DB (16core, 32GB)
3. Release version - Release 4.8.0

**API End Point:** `/api/entities/mlcore/v1/entityTypesByLocationAndRole/:entityId?role=:userSubrole`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' user-profile-fields user-profile-fields-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv /api/entities/mlcore/v1/entityTypesByLocationAndRole```

**Note**
- Update `host.csv` with valid domain details


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| mandatoryUserProfileFields  | 200        |  2000000 | 0 (0.00%) | 3169.8       |     61    |   174    |	226|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 8 pods (1core and 1GB)|100%|9%|
|Mongo DB (16core, 32GB)| 8%| 12.2045 GB |
