How to run ?

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' framework-read framework-read-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/framework.csv /api/framework/v1/read```


**Test Scenario:**

Verify Framework Read Create api scalability

**Test Result**

| API                               | Thread Count | Samples  | Errors%   | Throughput/sec | Avg Resp Time |   95th pct  |  99th pct   |
| ----------------------------------| ------------ | -------- | --------- | -------------- | --------------|-------------|-------------|
| Framework Read - without category | 200          | 400000   | 0 (0.00%) | 1221.2         | 135           |    368.95   |   855.99    |
| Framework Read - witho category   | 200          | 7200000  | 0 (0.00%) | 6159           | 24            |    33       |   235.98    |
