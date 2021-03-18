How to run ?

```./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_ORG_DATA_FILE> <pathPrefix>```
e.g.

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' root-org-search root-org-search_RunId01 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/testdata/host.csv ~/sunbird-platform/testdata/orgs.csv /api/org/v1/search```

**Test Scenario:**

Verify Org Search api scalability

**Test Result**

|API       |Thread Count|Samples |Errors%  |Throughput/sec|Avg Resp Time |95th pct |99th pct|
|----------|------------|--------|---------| -------------|--------------|---------|--------|
|Org Search|400         |30000000|0(0.00%) | 6763.8       | 55           |  74     |105     |
