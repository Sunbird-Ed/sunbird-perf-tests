### Test Scenario

Benchmarking Device Register  API.


### Test Environment Details
1. No of AKS node - 24
2. No of analytics service replicas - 
3. Release version - 


**API End Point:** 
`/api/v3/device/register`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <IP_CSV_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' device-register device-register_Run1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/ipaddress.csv ~/sunbird-perf-tests/sunbird-platform/testdata/deviceId.csv /api/v3/device/register```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `deviceId.csv` with already registered device Ids. These Ids should be unique. 
-  Update `ipaddress.csv` file data with IP Address


### Test Result

| API             | Thread Count| Samples  | Errors% |Throughput/sec|Avg Resp Time|95th pct| 99th pct |
| ----------------| ------------| -------- | --------| -------------|-------------|--------|----------|
| Device Register | 200         | 4000000  | 0(0.00%)| 5396.5       |    63       |  80    |     113  |
