How to run?

```
Run load test scenario script with necessary arguments:
./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <pathPrefix>


e.g.

./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' location-search location-search_RunID 5 1 5 "ABCDEFabcdef012345" /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host.csv /learner/data/v1/location/search
