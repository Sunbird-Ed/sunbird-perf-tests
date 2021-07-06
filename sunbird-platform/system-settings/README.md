### Test Scenario ```Cached API```

Benchmarking Get System Settings API.


### Test Environment Details
1. No of AKS node - 16
2. No of learner service replicas - 8 (1 Core and 3 GB)
3. Cassandra Cluster- 5 Nodes (CPU- 8Core; Memory- 32GB)
4. Release version - Release 3.9.0


**API End Point** 
`/api/data/v1/system/settings/get`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_SETTINGS> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' system-settings system-settings_RunId001 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/testdata/system-settings.csv ~/sunbird-platform/testdata/host.csv /api/data/v1/system/settings/get```


**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `system-settings.csv` file with settings name.

### Test Result:

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|Get System Settings|400         |4000000 |0(0.00%) | 20597.9       |0           |  1      |3      |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Learner Service (CPU-1 Core; Memory- 3 GB)  |NA |NA|
| Cassandra (CPU- 16Core; Memory- 64GB)| NA |NA |
