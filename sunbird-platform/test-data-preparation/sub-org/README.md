The purpose of this document is to describe the steps required to run the script to generate the sub org creation cql

# Pre-requisites

Clone this repo (sunbird-perf-tests) in home directory and go to test-data-preperation folder and move to sub-org folder

## How to run?

Run load test scenario script with necessary arguments:

    sh create-root-org.sh <SIZE_OF_ROOT_ORG> <SIZE_OF_SUB_ORG> <FILE_NAME>

# eg:

    sh create-root-org.sh 28 50000 org.cql
    
## How to verify?

    suborg.cql will be created in the path specified above

## Scenario data :

    INSERT INTO sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid,rootorgid) VALUES ('school-2-3','school-name-2-3','channel2','2019-04-24.18:32:51+0530',false,'channel2',1,'channel2','root-org-2');
