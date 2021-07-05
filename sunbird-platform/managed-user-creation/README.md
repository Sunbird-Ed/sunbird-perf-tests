### Test Scenario:

Benchmarking Auth Tokene API.

### Test Environment Details:
1. No of AKS node - 16
2. No of Learner service replicas - 16 (1 Core and 3 GB)
3. No of replicas - 3 KeyCloak servers
4. ES Cluster - 3 nodes (CPU- 8core ; Memory- 32GB)
5. Cassandra Cluster- 5 Nodes (CPU- 16Core; Memory- 64GB)
6. Release version - Release 3.9.0


**API End Point:** `/api/user/v4/create`


**Executing the test scenario using JMeter:**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' managed-user-creation
 managed-user-creation 5 1 5 "ABCDEFabcdef012345" /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/userData.csv /api/user/v4/create
 ```

**Note:**

- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `userData.csv` file with valid emailIds (FirstName, Email)


### Test Result

| API           | Thread Count  | Samples  | Errors% | Throughput/sec|Avg Resp Time|   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------| ---------------|------------|-------------|-------------|
| Managed User Creation | 200           | 1000000   | 0(0.00%)| 804.4           |    241    | 397  |  528   |
