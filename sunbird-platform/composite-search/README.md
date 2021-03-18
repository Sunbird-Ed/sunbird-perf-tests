How to run ?

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' composite-search composite-search-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/dialcodes.csv /api/composite/v1/search```


**Test Scenario:**

Verify the Comoposite Search api scalability.


**Test Result**

| API               | Thread Count  | Samples  | Errors%   | Throughput/sec  |Avg Resp Time |   95th pct |  99th pct   |
| ------------------| ------------- | -------- | --------- | --------------- |--------------|------------|-------------|
| Comoposite Search | 200           | 3000000  | 0 (0.00%) | 1185.1          |165           | 198        |213          |
