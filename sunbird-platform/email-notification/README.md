How to run ?

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```


e.g. 

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' email-notification email-notification-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/userEmails.csv /api/user/v1/notification/email```



**Test Scenario:**

Verify Email Notification api scalability

**Test Result**

| API                | Thread Count  | Samples  | Errors%   |Throughput/sec|Avg Resp Time| 95th pct| 99th pct |
| ------------------ | ------------- | -------- | --------- |--------------|-------------|---------|----------|
| Email Notification | 100           | 20000    | 0(0.00%)  | 100.7        | 779         | 3132.9  | 3677     |
