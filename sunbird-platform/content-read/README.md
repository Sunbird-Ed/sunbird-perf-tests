How to run ?

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>```

e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' content-read content-read-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv ~/sunbird-perf-tests/sunbird-platform/testdata/contents.csv /api/content/v1/read```


**Test Scenario:**

Verify the content read api scalability

**Test Result**

| API           | Thread Count  | Samples  | Errors %     | Throughput/sec |Avg Resp Time|95th pct| 99th pct |
| ------------- | ------------- | -------- | -------------| ---------------|-------------|--------|----------|
| Content Read  | 400           | 8000000  | 3681 (0.05%) | 10906          |    34       |    16  |    28    |
