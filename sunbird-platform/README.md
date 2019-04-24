Pre-requisites:
* Clone this repo (i.e. sunbird-perf-tests) in home directory
* Setup Apache JMeter 5.1.1 (apache-jmeter-5.1.1) in home directory
* Update Apache JMeter configuration properties (jmeter.properties)

```
jmeter.save.saveservice.output_format=xml
server.rmi.ssl.disable=true
jmeter.save.saveservice.requestHeaders=true
```
* Run Apache JMeter
```
nohup ~/apache-jmeter-5.1.1/bin/jmeter-server &
```
* Create necessary folders for running scenario script in home directory
```
mkdir ~/logs ~/current_scenario
```

Steps to run a scenario:

1. Run load test scenario script with necessary arguments:

```
sh run_scenario.sh <JMETER_IP_LIST> <HOST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <ACCESS_TOKEN>
```

e.g.

```
sh run_scenario.sh "28.0.0.18,28.0.0.19,28.0.0.20" "dev.sunbirded.org" user-enrollment-list r1_user_enrollment_list_t15 5 1 1 "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
```
