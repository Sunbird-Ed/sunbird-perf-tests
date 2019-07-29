## The jmx file in this folder will be used to run the full flow i.e user create-> Generate Token -> Enroll to course Batch.
## generate-test-data.sh this file is used to generate the test data for the above flow.
    - we can run it like this ./generate-test-data.sh 1 1 10 0
    - after running this file it will generate another file user-create-test-data.csv whose path we need to provide while running script. 
## host.csv , this file is used to provide input(protocol,host,port) to the script, we need to give this host file path as input to script.
## run_scenerio.sh , this is the script which we used to run the jmx script on multiple ips.


### Required Params:
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
