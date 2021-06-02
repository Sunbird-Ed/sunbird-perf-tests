### Test Scenario:

Benchmarking Content Hierarchy API.


### Test Environment Details:

1. No of AKS node - 16
2. No of content service replica - 6 (1 Core and 3 GB)
3. ES Cluster - 3 nodes (CPU- 8core ; Memory- 32GB)
4. Cassandra Cluster- 5 Nodes (CPU- 16Core; Memory- 64GB)
4. Release version - Release 3.9.0


**API End Point:**  `/api/course/v1/hierarchy`



**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' content-hierarchy content-hierarchy-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/collections.csv /api/course/v1/hierarchy```

**Notes**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `collections.csv` file data with valid collection Ids.



### Test Result

| API               | Thread Count  | Samples  |Throughput | Errors%   | Avg.            |95th pct         |99th pct       |
| ----------------- | ------------- | -------- | --------- | --------- | --------------- |--------------- |--------------- |
| Content Hierarchy | 200           | 2000000  | 20946.8  | 0 (0.00%)  |2                |     4           |10         |

*Note - This API is cached
