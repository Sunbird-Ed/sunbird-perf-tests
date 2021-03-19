The purpose of this document is to describe the steps required to perform a sunbird platform load test.
This folder consists of following APIs:


|         Folder Name        |             API End Point                    | 
|----------------------------|----------------------------------------------|
|     account-merge          |  /api/user/v1/account/merge                  |  
|     assign-role            |  /api/user/v1/role/assign                    |
|     auth-token             | /auth/realms/sunbird/protocol/openid-connect/token|
|  cert-service-pdf-download | /api/certreg/v1/certs/download               |
|  cert-service-svg          | /api/cert/v2/certs/generate                  |
|  cert-service              | /api/cert/v1/certs/generate                  |
| channel-read               | /api/channel/v1/read                         |
|composite-search            | /api/composite/v1/search                       |
|  content-hierarchy                          |   /api/course/v1/hierarchy                                           |
| content-read                           | /api/content/v1/read                                             |
|content-search                            |  /api/content/v1/search                                            |
|course-batch-enrol                            | /api/course/v1/enrol                                            |
| device-profile                           |/api/v3/device/profile                                              |
| device-register                           |/api/v3/device/register                                             |
| dial-assemble                           |/api/data/v1/dial/assemble                                             |
|email-notification                            |/api/user/v1/notification/email                                              |
|ext-user-create                            | /api/user/v3/create                                             |
| ext-user-read                           |/private/user/v1/read                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |
|                            |                                              |





### Pre-requisites
* Clone this repo (`sunbird-perf-tests`) in home directory
* Setup Apache JMeter 5.3 (`apache-jmeter-5.3`) in home directory
* Update Apache JMeter configuration properties (`jmeter.properties`)

```
jmeter.save.saveservice.output_format=xml
server.rmi.ssl.disable=true
jmeter.save.saveservice.requestHeaders=true
```
* Run Apache JMeter
```
nohup ~/apache-jmeter-5.3/bin/jmeter-server &
```
* Create necessary folders for running scenario script in home directory
```
mkdir ~/current_scenario
```

### How to run?

1. Run load test scenario script with necessary arguments:

```
sh run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <HOST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <ACCESS_TOKEN> <CSV_FILE><DOMAIN_FILE><pathPrefix>
```

e.g.

```
sh run_scenario.sh ~/apache-jmeter-5.3 "28.0.0.18,28.0.0.19,28.0.0.20" "dev.sunbirded.org" system-settings r1_system-settings_t5 5 1 1 "ABCDEFabcdef012345" "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" "/tmp/data.csv /tmp/sunbird-perf-tests/sunbird-platform/common/config/domain-end-point.csv" "/api"
```

### How to verify?

Logs are organised per scenario (`~/logs/<SCENARIO_ID>/logs/*.log`). Sample logs are mentioned below.

Scenario Log:
```
cat ~/sunbird-perf-tests/sunbird-platform/logs/user-enrollment/r1_user-enrollment_t5/logs/scenario.log 
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
* ~/sunbird-perf-tests/sunbird-platform/logs/user-enrollment/r1_user-enrollment_t5/logs/jmeter.log
* ~/sunbird-perf-tests/sunbird-platform/logs/user-enrollment/r1_user-enrollment_t5/logs/output.xml


