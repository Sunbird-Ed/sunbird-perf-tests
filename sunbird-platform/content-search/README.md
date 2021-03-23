### Test Scenario:

Benchmarking Search Content API with different search queries.


### Test Environment Details:
1. No of AKS node - 24
2. No of Search service replicas - 
3. No of Content search replicas -
4. Release version -


**API End Point:** 
`/api/content/v1/search`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE>  <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' search-request search-request_Run1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/searchQueryData.csv /api/content/v1/search```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `searchQueryData.csv` file with correct search queries

### Test Result

| API             | Thread Count  | Errors%   | Throughput/sec  |Avg Resp Time |   95th pct  |  99th pct   |
| --------------- | ------------- | --------- | --------------- |--------------|-------------|-------------|
| Search Content  | 200           | 0 (0.00%) | 5745.9          |67            |19           | 47          |
