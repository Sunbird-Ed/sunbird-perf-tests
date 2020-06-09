How to run?

```
Run load test scenario script with necessary arguments:
sh run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY>  <DOMAIN_FILE> <CONTENT_FILE> <pathPrefix>

e.g.
./run_scenario.sh ~/apache-jmeter-5.2.1/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' content-read content-read_R1 5 1 5 "ABCDEFabcdef012345" /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/content-read/host.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/content-read/content.csv /api/content/v1/read
