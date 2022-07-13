### Test Scenario:

Benchmarking Certificate Search API.

### Test Environment Details:
1. No of AKS node - 16
2. No of Registry replica - 8 (CPU- 1.5 Core; Memory- 2 GB)
3. No of Certificateapi replica - 4 (CPU- 1.5 Core; Memory- 1 GB)
4. No of Certificatesign  replica - 8 (CPU- 1 Core; Memory- 1 GB)
5. ES Usage (3 Nodes; CPU - 16core ; Memory -  64GB)
6. Release version - Release 4.8.0


**API End Point:** 
`/api/rc/certificate/v1/search`

**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE>   <CSV_FILE> <pathPrefix>```

e.g.

``` ./run_scenario.sh ~/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' rc-certificate-search rc-certificate-search-R1 5 1 5 ABCDEFabcdef012345 ~/sunbird-perf-tests/sunbird-platform/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/userdata.csv /api/rc/certificate/v1/search ```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userdata.csv ` file with valid user details

### Test Result:


| API           | Thread Count  | Samples  | Throughput/sec  | Errors%   |Avg Resp Time  |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
|   Certificate Search |   100        |  2000000  |2149.3|     0 (0.00%)    |  43         |  28     |  83      |

### Server Utilisation: 
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
|Registry Service- 16 (CPU- 1 Core; Memory- 1 GB)|80%|50%|
|ES Usage (3 Nodes; CPU - 16core ; Memory -  64GB)|30%| 28.48 GB |
