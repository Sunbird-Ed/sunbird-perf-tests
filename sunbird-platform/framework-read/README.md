
**Test Scenario:**

Benchmarking Framework Read API with and without category.


### Test Environment Details
1. No of AKS node - 24
2. No of learner service replicas - 8 (CPU- 3Core & Memory- 5GB)
3. ES Cluster - 3 nodes; CPU- 16core ; Memory- 64GB
4. Cassandra Cluster- 5 Nodes; CPU- 16Core; Memory- 64GB
5. Release version - NA

**API End Point:** 
`/api/framework/v1/read`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' framework-read framework-read-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/framework.csv /api/framework/v1/read```


Note: 
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `framework.csv` file data with correct framework Ids before running the test.
- In place of `ABCDEFabcdef012345` provide api bearer key. 

**Test Result**

| API                              | Thread Count| Samples  | Errors% |Throughput/sec|Avg Resp Time| 95th pct|99th pct|API Endpoint|
| ---------------------------------| ------------| -------- | --------| -------------|-------------|---------|--------|------------|
| Framework Read-without category  | 200         | 400000   | 0(0.00%)| 1221.2       | 135         | 368.95  |855.99  |/api/framework/v1/read|
| Framework Read-with category     | 200         | 7200000  | 0(0.00%)| 6159         | 24          | 33      |235.98  |/api/framework/v1/read|
