## The jmx file in this folder will be used to run the full flow i.e user create-> Generate Token -> Enroll to course Batch.
## generate-test-data.sh this file is used to generate the test data for the above flow.
    - we can run it like this ./generate-test-data.sh 1 1 10 0
    - after running this file it will generate another file user-create-test-data.csv whose path we need to provide while running script. 
## host.csv , this file is used to provide input(protocol,host,port) to the script, we need to give this host file path as input to script.
## run_scenerio.sh , this is the script which we used to run the jmx script on multiple ips.

## Required Params:
           - courseId
           - batchId
           - hostFile
           - requestFile
           - jmeter home path
           - ips
           - number of threads
           - ctrlLoops
           - rampupTime
           - API key 
           - accessToken 
## How To Run:
             - GOTO ~/sunbird-perf-tests/sunbird-platform/user-create-with-course-batch-enrol/
             - sh run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <ACCESS_TOKEN> <CSV_FILE_PATH><HOST_FILE_PATH><COURSE_ID><BATCH_ID>



#Example : /run_scenario.sh ~/apache-jmeter-5.1.1 '127.0.0.1,127.0.0.2' user-create-with-course-batch-enro user-create-with-course-batch-enrol_test1 100 1 1 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJlMDRkNzJkMWNiZDg0MTEyOTBkNGFiZWM3NDU5YTFlYiJ9.bThu42m1nPTMikbYGywqBqQYUihm_l1HsmKMREMuSdM token ~/sunbird-perf-tests/sunbird-platform/user-create-with-course-batch-enro/user-create-test-data.csv ~/sunbird-perf-tests/sunbird-platform/user-create-test-data.csv/host.csv KP_FT_1564394114456 0128155669117419523
