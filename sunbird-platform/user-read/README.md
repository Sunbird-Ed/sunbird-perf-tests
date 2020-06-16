How to run?

```
Run load test scenario script with necessary arguments:
sh run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY>  <DOMAIN_URL> <USER_NAME>  <DOMAIN_FILE> <USER_ID_FILE> <pathPrefix>

e.g.
./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' user-read user-read_RUNID01 10 5 10 "ABCDEFabcdef012345" abc.com  useremailid@gmail.com /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/user-read/host.csv  /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/user-read/userIds.csv /api/user/v2/read
