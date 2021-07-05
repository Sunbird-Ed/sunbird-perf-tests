### Test Scenario: ```Cached API```

Benchmarking Org Search API.


### Test Environment Details
1. No of AKS node - 16
2. No of learner service replicas - 8 (1 Core and 1 GB)
3. Cassandra Cluster- 5 Nodes; CPU- 8Core; Memory- 32GB
4. Release version - Release 3.9.0


**API End Point:** 
`/api/org/v1/search`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_ORG_DATA_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' root-org-search root-org-search_RunId01 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/testdata/host.csv ~/sunbird-platform/testdata/orgs.csv /api/org/v1/search```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `orgs.csv` file with valid org Ids

### Test Result:

|API       |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|----------|------------|--------|---------| -------------|--------------|---------|--------|
|Org Search|200         |10000000|0(0.00%) | 19608.1       | 2           | 4     |7    |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Cassandra (CPU- 16Core; Memory- 64GB)| 2.33% | 13.138 GB|
