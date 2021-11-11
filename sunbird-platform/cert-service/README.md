### Test Scenario:

Benchmarking certificate generate API.

### Test Environment Details:
1. No of AKS node - 16
2. No of Cert service replica - 16 (CPU- 1 Core; Memory- 1 GB)
3. No of Print service replica - 16 (CPU- 1 Core; Memory- 1 GB)
4. Release version - Release 4.3.0


**API End Point:** 
`/api/cert/v1/certs/generate`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' cert-service cert-service-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv /api/cert/v1/certs/generate```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.

### Test Result:


| API           | Thread Count  | Samples  | Throughput/sec  | Errors%   |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
|   certificate generate |   100        |  10000  |14.9 |     2 (0.02%)    |  5808          |  13457.65       |  19936.83       |

### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|Cert service- 16 (CPU- 1 Core; Memory- 1 GB)|48%|621 MiB|
|Print service- 16 (CPU- 1 Core; Memory- 1 GB)|100%|792 MiB  |
