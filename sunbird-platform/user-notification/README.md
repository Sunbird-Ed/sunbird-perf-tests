How to run ?

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> ```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-notification user-notification_Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/account-merge/userData.csv /api/user/v2/notification```


**Test Scenario:**

Verify User Notification api scalability

**Test Result**

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |
|-------------------|------------|--------|---------| -------------|--------------|
|User Notification  |200         |1000000 |0(0.00%) | 1830.7       | 99           |
