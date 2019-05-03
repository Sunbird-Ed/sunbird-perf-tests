The purpose of this document is to describe the steps required to run the script to generate the course and create reviewer user

# Pre-requisites

Clone this repo (sunbird-perf-tests) in home directory and go to test-data-preperation folder and move to sub-org folder

## How to run?

Run load test scenario script with necessary arguments:

    sh create-course.sh <SIZE_OF_ROOT_ORG> <NUMBER_OF_COURSE> <BASE_URL> <CREATOR_ID> <CREATOR_USERNAME> <REVIEWER_USERNAME> <FILEPATH_STORE_COURSEID>
    sh create-user-content-reviewer.sh <NUM_ROOT_ORGS> <NUMBER_OF_USER> <USER_FILE> <USER_ORG_FILE>
    sh user-password-update.sh <NUM_ROOT_ORGS> <NUM_USER_SUB_ORG> <BASE_AUTH_URL> <TOKEN> <FEDERATION_ID> 


# eg:

    sh create-sub-org.sh 1 1 https://loadtest.ntp.net.in/ https://loadtest.ntp.net.in//auth a02bce3d-8f1f-f-ab4d-b71b7e9c007a ft_org_ad.com ft_reviewrg.com file
    sh create-user-content-reviewer.sh 28 1 user.cql userorg.cql
    sh user-password-update.sh 28 1  https://loadtest.ntp.net.in/ Authtoken FedId 

    
2. `user.cql` will be created in the path specified above.

    ```
    $ cat user.cql
   INSERT INTO sunbird.user (id, channel, email, emailverified , firstName, rootorgid,status,username,roles,createddate) VALUES ('content-reviewer-1-1','channel1','content-reviewer-1@gmaol.com',true,'content-reviewer-1-1','root-org-1',1,'content-reviewer-1-1',['PUBLIC'],'2019-05-03.15:54:44+0530');

   $ cat userorg.cql
    INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-org-root-reviewer-1','root-org-1','content-reviewer-1-1','root-org-1','2019-05-03.15:54:44+0530',['PUBLIC','CONTENT_REVIEWER'],false);
    ...
    ```
3. Run the CQL commands generated on the cassandra server.

```
cqlsh -f user.cql
cqlsh -f userorg.cql
```
