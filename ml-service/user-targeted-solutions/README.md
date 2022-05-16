### Test Scenario:
Benchmarking `getTargetedSolutions` API.

### Test Environment Details:
1. ml-core - 8 pods (1Core, 1GB)
2. ml-projects - 8 pods (1Core, 1GB)
3. ml-survey - 8 pods (1Core, 1GB)
4. Mongo DB (16core, 32GB)
5. Release version - Release 4.8.0

**API End Point:** `/api/solutions/mlcore/v1/targetedSolutions`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' user-targeted-solutions user-targeted-solutions-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/searchData.csv ~/sunbird-perf-tests/testdata/locationData.csv ~/sunbird-perf-tests/testdata/solutionTypes.csv /api/solutions/mlcore/v1/targetedSolutions ```


**Note**
- Update `host.csv` file with valid domain details
- Update `searchData.csv` file with search text data
- Update `locationData.csv` with valid location details
- Update `solutionTypes.csvv` with valid solution types


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| getTargetedSolutions  | 200        |  2000000 |5 (0.00%) | 2086.8       |     93    |   193   |	261|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 8 pods (1core and 1GB)|100%|9%|
|ml-projects - 8 pods (1core and 1GB)|21%|6%|
|ml-survey - 8 pods (1core and 1GB)|50%|7%|
|Mongo DB (16core, 32GB)| 29%| 1.829 GB |
