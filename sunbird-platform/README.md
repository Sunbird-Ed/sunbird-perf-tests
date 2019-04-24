The purpose of this document is to describe the steps required to perform a sunbird platform (learner service) load test.

### Pre-requisites
* Clone this repo (`sunbird-perf-tests`) in home directory
* Setup Apache JMeter 5.1.1 (`apache-jmeter-5.1.1`) in home directory
* Update Apache JMeter configuration properties (`jmeter.properties`)

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

### How to run?

1. Run load test scenario script with necessary arguments:

```
sh run_scenario.sh <JMETER_IP_LIST> <HOST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <ACCESS_TOKEN>
```

e.g.

```
sh run_scenario.sh "28.0.0.18,28.0.0.19,28.0.0.20" "dev.sunbirded.org" user-enrollment-list r1_user_enrollment_list_t15 5 1 1 "ABCDEFabcdef012345" "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
```

### How to verify?

Logs are organised per scenario (`~/logs/<SCENARIO_ID>/logs/*.log`). Sample logs are mentioned below.

Scenario Log:
```
cat ~/logs/r1_user_enrollment_list_t15/logs/scenario.log 
Creating summariser <summary>
Created the tree successfully using /Users/vinaya/current_scenario/user-enrollment-list.jmx
Configuring remote engine: 127.0.0.1
Starting remote engines
Starting the test @ Wed Apr 24 16:45:03 IST 2019 (1556104503284)
Remote engines have been started
Waiting for possible Shutdown/StopTestNow/HeapDump/ThreadDump message on port 4445
summary +      1 in 00:00:00 =    2.7/s Avg:   311 Min:   311 Max:   311 Err:     0 (0.00%) Active: 5 Started: 5 Finished: 0
summary +      4 in 00:00:00 =   19.8/s Avg:   437 Min:   367 Max:   520 Err:     0 (0.00%) Active: 0 Started: 5 Finished: 5
summary =      5 in 00:00:01 =    8.7/s Avg:   411 Min:   311 Max:   520 Err:     0 (0.00%)
Tidying up remote @ Wed Apr 24 16:45:04 IST 2019 (1556104504507)
... end of run
```

Other Logs:
* ~/logs/r1_user_enrollment_list_t15/logs/jmeter.log
* ~/logs/r1_user_enrollment_list_t15/logs/output.xml


