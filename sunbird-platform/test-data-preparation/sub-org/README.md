The purpose of this document is to describe the steps required to run the script to generate the sub org creation cql

# Pre-requisites

Clone this repo (sunbird-perf-tests) in home directory and go to test-data-preperation folder and move to sub-org folder

## How to run?

Run load test scenario script with necessary arguments:

    sh create-sub-org.sh <SIZE_OF_ROOT_ORG> <SIZE_OF_SUB_ORG> <FILE_NAME>
    sh register-sub-org-tag.sh <NUM_ROOT_ORGS> <NUM_SUB_ORGS> <BASE_URL> <EXEC>

# eg:

    sh create-sub-org.sh 28 50000 suborg.cql
    sh register-sub-org-tag.sh 28 50000 http://28.0.3.14:9000 false
    
2. `suborg.cql` will be created in the path specified above.

    ```
    $ cat suborg.cql
    INSERT INTO sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid,rootorgid) VALUES ('root-org-1','root-org-name-1','channel1','2019-04-24.13:14:05+0000',false,'channel1',1,'root-
    org-1','root-org-1');
    INSERT INTO sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid,rootorgid) VALUES ('root-org-2','root-org-name-2','channel2','2019-04-24.13:14:05+0000',true,'channel2',1,'root-
    org-2','root-org-1');
    ...
    ```
3. Run the CQL commands generated on the cassandra server.

```
cqlsh -f suborg.cql
```
