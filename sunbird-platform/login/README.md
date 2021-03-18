How to run ?
```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <DOMAIN_FILE> <CSV_USERDATA_FILE> <CSV_USERDATA_FILE> <pathPrefix>```

e.g.
```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' login login_RunID01 5 1 5 ~/sunbird-platform/testdata/host.csv ~/sunbird-platform/testdata/userData.csv```


**Test Scenario:**

Verify the login scenario scalability

**Test Result**

|API                |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|-------------------|------------|--------|---------| -------------|--------------|---------|--------|
|Login Scenario     |40          |2740475 |30(0.00%)| 255.88       | 104.81       | 110.00  |134.00  |
