## Prepare test data to load test user-create v2 API

### Pre-requisites
1. Root organisations should have been created with the organisationIds of the format root-org-`count`
> example range: ```root-org-1 to root-org-28```

2. Sub organisations should have been created with the organisationIds of the format school-`rootOrgCount`-`subOrgCount`
> example range: ```school-1-1 to school-28-50000```

### Command to generate test data

```generate-test-data.sh <ROOT_ORG_COUNT> <SUB_ORG_COUNT> <NON_CUSTODIAN_USERS_COUNT> <CUSTODIAN_USERS_COUNT>```

example : ```generate-test-data.sh 28 50000 8 2```

### Sample CSV Data

|firstName|userName|email|organisationId|
|---|---|---|---|
|1556528849-1|1556528849-1|1556528849-1@domain.com|school-21-8842|
|1556528849-2|1556528849-2|1556528849-2@domain.com|school-16-30713|
|1556528849-3|1556528849-3|1556528849-3@domain.com|school-16-20210|
|1556528849-4|1556528849-4|1556528849-4@domain.com|school-1-518|
|1556528849-5|1556528849-5|1556528849-5@domain.com|school-8-27766|
|1556528849-6|1556528849-6|1556528849-6@domain.com|school-6-8625|
|1556528849-7|1556528849-7|1556528849-7@domain.com|school-5-30188|
|1556528849-8|1556528849-8|1556528849-8@domain.com|school-15-7974|



### Test Scenario

Benchmarking User Create API.


### Test Environment Details
1. No of AKS node - 24
2. No of learner service replicas - 8 (1Core and 3 GB)
3. Cassandra Cluster- 5 Node (CPU- 16Core; Memory- 64GB)
4. ES Cluster - 3 Nodes (CPU- 16core; Memory- 64GB)
5. No of keyCloak server - 4 (CPU- 4core; Memory- 16GB)
6. Release version - Release 3.9.0


**API End Point:** 
`/api/user/v1/create`


**Executing the test scenario using JMeter**

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_USERDATA_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-create user-create_RunId001 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/testdata/host.csv ~/sunbird-platform/testdata/user-create-test-data.csv  /api/user/v1/create```

**Note**
- Update `host.csv` file data with correct host details before running the test. It can be domain details / Kubernetes Node IPs/ LB IPs/ Direct Service IPs with port details.
- Update `user-create-test-data.csv` file with user name and email Ids


### Test Result:

|API         |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|------------|------------|--------|---------| -------------|--------------|---------|--------|
|User Create |100         |50000  |0(0.00%) | 82.8         | 1177         |  2061   |2431 |


### Server Utilisation:
| Backend          | CPU Usage %(max) | Memory Utilization (max) |
| ------------- | ------------- |------------- |
| Learner Service (CPU-1 Core; Memory- 3 GB)  |40% |   514 MiB |
| Cassandra (CPU- 16Core; Memory- 64GB)| 19.97% |13.24 GB |
| KeyCloak (CPU- 4core ; Memory- 16GB)|99.09%| 2.013 GB|
