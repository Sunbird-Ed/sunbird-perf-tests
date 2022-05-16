### Test Scenario:
Benchmarking `Get file upload url for Sync, Observation submit` API.

### Test Environment Details:
1. ml-core - 16 pods (1Core, 1GB) 
2. Mongo DB (4core, 16GB)
3. Release version - Release 4.7.0

**API End Point:** `/api/cloud-services/mlcore/v1/files/preSignedUrls`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_NAME> <USER_EMAIL_ID> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh ~/apache-jmeter-5.3 '28.0.0.19' sync-observation-submit sync-observation-submit-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/testdata/host.csv ~/sunbird-perf-tests/testdata/ProjectSync.csv ~/sunbird-perf-tests/testdata/userdata.csv /api/cloud-services/mlcore/v1/files/preSignedUrls```

**Note**
- Update `host.csv` with valid domain details
- Update `userdata.csv` with valid user accesstoken data
- Update `ProjectSync.csv` with valid project sync preSignedUrl


### Test Result:
| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Get file upload url for Sync, Observation submit  | 50       |  2500000  |  11 (0.00%) | 2909.2       |    16    |   7   |	33.99|


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|ml-core - 8 pods (1core and 1GB)|100%|13%|
|Mongo DB (4core, 16GB)| 2%|453.1 MB |

