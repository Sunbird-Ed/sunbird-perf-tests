### Test Scenario:

Benchmarking DialCode Read API.

### Test Environment Details:
1. No of AKS node - 16
2. Cassandra Cluster- 7 Nodes (CPU- 16Core; Memory- 64GB)
3. Release version - Release 4.8.0


**API End Point:** `/api/dialcode/v2/read`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh ~k/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' dialcode-read dialcode-read-12Apr2022-R8 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/sunbird-platform/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/dialcodes.csv /api/dialcode/v2/read ```

**Note:**

- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `dialcodes.csv` file with valid dialcodes


### Test Result 

| API           | Thread Count  | Samples  | Errors% | Throughput/sec|Avg Resp Time|   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------| ---------------|------------|-------------|-------------|
|Dialcode Read    | 200           | 8000000   | 0(0.00%)| 5381.1           |    36    | 57      |  78   |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max)|
| ------------- | ------------- |------------- |
|Dial Service (CPU-1 Core; Memory- 1 GB)  |65% | 30%   |
|Cassandra (CPU- 16Core; Memory- 64GB)|   6.80%   |  13.946 GB   |
