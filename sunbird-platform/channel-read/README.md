### Test Scenario: ```Cached API```

Benchmarking Channel Read API. 


### Test Environment Details:
1. No of AKS node -16
2. No of learner, LMS service replicas - 8 (1 core and 3 GB)
3. ES Cluster - 3 Nodes (CPU - 16core ; Memory - 32 GB)
4. Redis - 1 Node (CPU- 2core; Memory- 8GB)
5. Release version - Release 4.3.0


**API End Point:** `/api/channel/v1/read`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' channel-read channel-read-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/channel.csv /api/channel/v1/read```

**Notes**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `channel.csv` file with valid channel Ids.

### Test Result

| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |--------------|-------------|-------------|
| Channel Read  | 200           | 5000000  | 0 (0.00%) | 32613         |0            |2            |6           |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Redis (CPU- 2core; Memory- 8GB)  |7.27% |2.2 GB	|
