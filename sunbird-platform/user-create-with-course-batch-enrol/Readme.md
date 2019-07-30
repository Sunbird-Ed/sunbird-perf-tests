<b>Ticket Ref: </b> [SB-13838](https://github.com/Sunbird-Ed/sunbird-perf-tests/pull/new/SB-13838)
- The jmx file in this folder will be used to run the full flow i.e user create-> Generate Token ->  Enroll to course Batch.
 - generate-test-data.sh this file is used to generate the test data for the above flow.
    - we can run it like this ./generate-test-data.sh 1 1 10 0
    - after running this file it will generate another file user-create-test-data.csv whose path we need to provide while running script. 
- host.csv , this file is used to provide input(protocol,host,port) to the script, we need to give this host file path as input to script.
- run_scenerio.sh , this is the script which we used to run the jmx script on multiple ips.

 ## Required Params:
           - jmeterHome=$1
           - ips=$2
           - scenario_name=$3
           - scenario_id=$4
           - numThreads=$5
           - rampupTime=$6
           - ctrlLoops=$7
           -  apiKey=$8
           - accessToken=${9}
           - csvFile=${10}
           - csvFileHost=${11}
           - courseId=${12}
           - batchId=${13}
           - userCreateApi=${14}
           - batchEnrolApi=${15}
- How To Run:
             - GOTO ~/sunbird-perf-tests/sunbird-platform/user-create-with-course-batch-enrol/
             - sh run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <ACCESS_TOKEN> <CSV_FILE_PATH><HOST_FILE_PATH><COURSE_ID><BATCH_ID><userCreateApi><batchEnrolApi>



 - Example:

> ./run_scenario.sh ~/apache-jmeter-5.1.1 '127.0.0.1' user-create-with-course-batch-enrol modifieds_t_1 50 1 1 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJlMDRkNzJkMWNiZDg0MTEyOTBkNGFiZWM3NDU5YTFlYiJ9.bThu42m1nPTMikbYGywqBqQYUihm_l1HsmKMREMuSdM token ~/sunbird-perf-tests/sunbird-platform/user-create-with-course-batch-enrol/user-create-test-data.csv ~/sunbird-perf-tests/sunbird-platform/user-create-with-course-batch-enrol/host.csv KP_FT_1564394114456 0128155669117419523 '/api/user/v1/create' '/api/course/v1/enrol'

- API used Info:
           - for token creation: /auth/realms/sunbird/protocol/openid-connect/token
           
 `````
### How to verify?

Logs are organised per scenario (`~/logs/<SCENARIO_ID>/logs/*.log`). Sample logs are mentioned below.

Scenario Log:
```
cat ~/sunbird-perf-tests/sunbird-platform/logs/user-enrollment/r1_user-enrollment_t5/logs/scenario.log 
Creating summariser <summary>
Created the tree successfully using /Users/anmolgupta/current_scenario/user-create-with-course-batch-enrol.jmx
Configuring remote engine: 127.0.0.1
Starting remote engines
Starting the test @ Tue Jul 30 11:17:05 IST 2019 (1564465625509)
Remote engines have been started
Waiting for possible Shutdown/StopTestNow/HeapDump/ThreadDump message on port 4445
summary =    150 in 00:00:34 =    4.4/s Avg:  6483 Min:    49 Max: 30540 Err:    81 (54.00%)
```

Other Logs:
* ~/sunbird-perf-tests/sunbird-platform/logs/user-create-with-course-batch-enrol/modifieds_t_1/logs/output.xml 
* ~/sunbird-perf-tests/sunbird-platform/logs/user-create-with-course-batch-enrol/modifieds_t_1/logs/jmeter.log
