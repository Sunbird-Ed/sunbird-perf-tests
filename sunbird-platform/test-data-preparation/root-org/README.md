The purpose of this document is to describe the steps required to run the scripts for automated creation of root orgs.

1. Run load test scenario script with necessary arguments:

```
sh create-root-org.sh <NUM_ROOT_ORGS> <OUTPUT_CQL_FILE_NAME>
sh register-channel.sh <NUM_ROOT_ORGS> <BASE_URL> <EXEC>
sh register-root-org.sh <NUM_ROOT_ORGS> <BASE_URL> <EXEC>
```

e.g.
```
sh create-root-org.sh 28 org.cql
sh register-channel.sh 28 http://28.0.3.14:9000 true
sh register-root-org.sh 28 http://28.0.3.5:8080 false
```
2. `org.cql` will be created in the path specified above.

```
$ cat org.cql
INSERT INTO sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid) VALUES ('root-org-1','root-org-name-1','channel1','2019-04-24.13:14:05+0000',true,'channel1',1,'root-
org-1');
INSERT INTO sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid) VALUES ('root-org-2','root-org-name-2','channel2','2019-04-24.13:14:05+0000',true,'channel2',1,'root-
org-2');
...
```

3. Run the CQL commands generated on the cassandra server.

```
cqlsh -f org.cql
```
