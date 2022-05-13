### Test Scenario:
Benchmarking `Get Question Template Details` API.

### Test Environment Details:
1. ml-core - 8 pods (1core, 1GB)
2. ml-survey - 8 pods (1Core, 1GB) 
3. Mongo DB (16core, 32GB)
4. Release version - Release 4.7.0

**API End Point:** `/api/solutions/mlcore/v1/details `

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 'Jmeter_Slave1_IP,Jmeter_Slave2_IP' get-question-template-details get-question-template-details-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/solutionId.csv ~/sunbird-perf-tests/testdata/-data-new/userdata.csv /api/solutions/mlcore/v1/details```

**Note**
- Update `userdata.csv` with valid user accesstoken data
- Update `solutionId.csv` with valid templateIds 
- Update `host.csv` with valid domain details

### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Question Template Details  | 100           |  500000  | 0 (0.00%) | 1063.2      |     92   |   254    |	416.99|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 8 pods (1core and 1GB)|70%|10%|
|ml-survey - 8 pods (1core and 1GB)|99%|12%|
|Mongo DB (16core, 32GB)| 6%|  1.67 GB  |

