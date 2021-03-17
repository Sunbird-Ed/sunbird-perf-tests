How to run ?

```
./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix> 
```

e.g.

```
./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' group-create group-create_ID01 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/testdata/host.csv ~/sunbird-platform/testdata/groups_testdata/userToken.csv  /api/group/v1/create 
```

**Test Scenario:**

Verify Group Create api scalability

**Test Result**

| API             | Thread Count  | Samples  | Errors%   | Throughput/sec  | Avg Resp Time |   95th pct  |  99th pct   |
| ----------------| ------------- | -------- | --------- | --------------- | --------------|-------------|-------------|
| Group Create    | 200           | 1000000  | 0 (0.00%) | 3954.8          | 44            |    48       |   69.99     |
