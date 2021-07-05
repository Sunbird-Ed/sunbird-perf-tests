### Test Scenario

Benchmarking Login scenario (with 4 api calls).


### Test Environment Details
1. No of AKS node - 16
2. No of learner service replicas - 8 (1 Core and 1 GB)
3. KeyCloak Server - 4 servers (CPU- 4Core; Memory- 16GB)
4. Release version - Release 3.9.0


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <DOMAIN_FILE> <CSV_USERDATA_FILE> <CSV_USERDATA_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' login login_RunID01 5 1 5 ~/sunbird-platform/testdata/host.csv ~/sunbird-platform/testdata/userData.csv```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` with valid user email Ids.

### Test Result:

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|Login (4 API Calls)|40          |228601 |30(0.00%)| 304.8       | 115       | 546  |777  |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| KeyCloak (CPU- 4Core; Memory- 16GB)|99%  | 2.180 GB|
