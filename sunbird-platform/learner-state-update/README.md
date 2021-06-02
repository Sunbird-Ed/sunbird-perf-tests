### Test Scenario:

Benchmarking Learner State Update API.


### Test Environment Details
1. No of AKS node - 16
2. No of lms service replicas - 16 (1 Core and 1 GB)
3. Cassandra Cluster- 5 Nodes (CPU- 8Core; Memory- 32GB)
4. ES Cluster - 3 nodes (CPU- 16core ; Memory- 64GB)
5. Release version - Release 3.9.0


**API End Point:** 
`/api/course/v1/content/state/update`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' learner-state-update learner-state-update-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~k/sunbird-perf-tests/sunbird-platform/testdata/userToken.csv /api/course/v1/content/state/update```


**Note**
- Before executing `learner-state-update.jmx` file need to update with correct courseId, bactchId and contentId
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userToken.csv` file with valid user Ids and user access tokens. These user should be already enrolled to the course/batch (courseId/Batch Id - which are provded in the jmx file)


### Test Result

|API                 |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|--------------------|------------|--------|---------| -------------|--------------|---------|--------|
|Learner State Update|200         |2000000 |0(0.00%) |6571.5        | 29          |  69    |80     |
