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



How to run ?

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_USERDATA_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-create user-create_RunId001 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/testdata/host.csv ~/sunbird-platform/testdata/user-create-test-data.csv  /api/user/v1/create```

**Test Scenario:**

Verify User Create api scalability

**Test Result**

|API         |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|------------|------------|--------|---------| -------------|--------------|---------|--------|
|User Create |100         |100000  |0(0.00%) | 77.3         | 1273         |  2672   |4228.99 |
