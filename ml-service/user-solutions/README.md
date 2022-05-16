### Test Scenario:
Benchmarking `userSolutions` API.

### Test Environment Details:
1. ml-core - 8 pods (1Core, 1GB) 
2. ml-projects - 8 pods (1Core, 1GB) 
3. Mongo DB (16core, 32GB)
4. Release version - Release 4.8.0

**API End Point:** `/api/users/mlcore/v1/solutions`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' user-solutions user-solution-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/searchData.csv ~/sunbird-perf-tests/testdata/locationData.csv ~/sunbird-perf-tests/testdata/solutionData.csv /api/users/mlcore/v1/solutions```

**Note**
- Update `host.csv` with valid domain details
- Update `searchData.csv` with correct search text
- Update `locationData.csv` with valid location details
- Update `solutionData.csv` with valid SolutionIds


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| userSolutions  | 200        |  4000000 | 14 (0.00%) | 2018.3       |     96    |   185    |224|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 8 pods (1core and 1GB)|100%|11%|
|ml-projects - 8 pods (1core and 1GB)|65%|9%|
|Mongo DB (16core, 32GB)| 36%|  23.857 GB |

