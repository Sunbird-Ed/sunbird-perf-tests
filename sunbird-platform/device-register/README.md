
How to run?

```
Run load test scenario script with necessary arguments:
sh run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS>  <DOMAIN_FILE> <IP_ADDRESS_FILE> <DEVICE_ID_FILE> <pathPrefix>

e.g.
./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' device-register device-register_RunID001 5 1 5 /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/host.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/device-register/ipaddress.csv /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/devide_ids.csv /api/v3/device/register
