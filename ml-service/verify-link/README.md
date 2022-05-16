### Test Scenario:
Benchmarking `Verify Link` API.

### Test Environment Details:
1. ml-core - 16 pods (1Core, 1GB) 
2. ml-projects - 16 pods (1Core, 1GB) 
3. Mongo DB (16core, 32GB)
4. Release version - Release 4.8.0

**API End Point:** `/api/solutions/mlcore/v1/verifyLink`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' verify-link verify-link-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/links.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/solutions/mlcore/v1/verifyLink ```

**Note**
- Update `host.csv` file with valid domain details
- Update `links.csv` file with valid links details
- Update `userdata.csv`. file with valid user details


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Verify Link  | 200        |  1000000 | 58 (0.01%) | 2682.2      |     65    |   51   |	95|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 16 pods (1core and 1GB)|100%|10%|
|ml-projects - 16 pods (1core and 1GB)|45%|7%|
|Mongo DB (16core, 32GB)| 15%| 1.0496 GB |
