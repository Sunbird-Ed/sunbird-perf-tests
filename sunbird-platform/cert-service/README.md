How to run ?

./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <pathPrefix>

e.g.

./run_scenario.sh /mount/data/benchmark/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' cert-service ert-service-Id1 5 1 5 "ABCDEFabcdef012345" ~/sunbird-perf-tests/sunbird-platform/testdata/host.csv /api/cert/v1/certs/generate
