The purpose of this document is to describe the steps required to run the script to generate the root org creation cql

Pre-requisites
Clone this repo (sunbird-perf-tests) in home directory
Create necessary folders for running scenario script in home directory

How to run?
Run load test scenario script with necessary arguments:
sh root-org.sh <SIZE_OF_ROOT_ORG> <FILENAME>
e.g.
sh root-org.sh 28 org.cql

How to verify?
org.cql will be created in the path specified above

Scenario data :

Insert into sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid) values ('root-org-1','root-org-name-1','channel1','2019-04-24.17:28:29+0530',true,'channel1',1,'channel1');
Insert into sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid,rootorgid) values ('school-1-1','school-name-1-1','channel1','2019-04-24.17:28:29+0530',false,'channel1',1,'channel1','root-org-1');