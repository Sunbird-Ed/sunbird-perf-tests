### Test Scenario:

Benchmarking certificate search API.

### Test Environment Details:
1. No of AKS node - 16
2. No of CertRegistry service replica - 16 (CPU- 1 Core; Memory- 1 GB)
3. ES Usage (3 Nodes; CPU - 16core ; Memory - 64GB)
4. Release version - Release 4.3.0


**API End Point:** 
`/api/certreg/v1/certs/search`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' cert-service cert-service-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv /api/cert/v1/certs/generate```

```./run_scenario.sh ~/apache-jmeter-5.3/ '28.0.0.19' certreg-certificate-search rcertreg-certificate-search-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/sunbird-platform/host.csv ~/sunbird-perf-tests/sunbird-platform/user-create/user-data-new/UserData.csv /api/certreg/v1/certs/search ```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- - Update `UserData.csv` file data with correct userData .

### Test Result:

| API           | Thread Count  | Samples  | Throughput/sec  | Errors%   |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
|   Certificate Search |   200        |  1000000  |990.4 |      0 (0.00%)   |  199         |  275.95      |  368.99 |

### Server Utilisation: 
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|CertRegistry- 16 (CPU- 1 Core; Memory- 1 GB)|60%|40%|
|ES Usage (3 Nodes; CPU - 16core ; Memory - 64GB)|17%|28.47 GB  |

