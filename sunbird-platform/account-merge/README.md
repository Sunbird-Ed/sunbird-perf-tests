**Test Scenario:**

Benchmarking Merge Account API.

**API End Point:** `/api/user/v1/account/merge`


*Executing the test scenario using JMeter:*

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE_TO_ACCOUNT>  <CSV_FILE_FROM_ACCOUNT> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' account-merge account-merge-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/toAccounts.csv ~/sunbird-perf-tests/sunbird-platform/testdata/fromAccounts.csv /api/user/v1/account/merge```


**Note**
- toAccounts.csv : State tenant users account details. Custodian users accounts will be merged to these accounts.
- fromAccounts.csv : Custodian users account details. These are the accounts which are going to be megred with state tenant user accounts.



**Test Result**

| API           | Thread Count  | Samples  | Errors%   | Throughput/sec  | Avg Resp Time |   95th pct  |  99th pct   |
| ------------- | ------------- | -------- | --------- | --------------- |---------------|-------------|-------------|
| Account Merge | 200           | 100000   | 0 (0.00%) | 401.7           | 429           |    1040     |   1686.94   |
