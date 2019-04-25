The purpose of this document is to describe the steps required to run the scripts for automated creation of root orgs.

1. Run load test scenario script with necessary arguments:

```
sh create-user-sub-org.sh <NUM_ROOT_ORGS> <NUM_SUB_ORG> <NUM_USER_SUB_ORG> <OUTPUT_USER_CQL_FILE_NAME> <OUTPUT_USER_ORG_CQL_FILE_NAME>
```

e.g.
```
sh create-user-sub-org.sh 28 50000 1 user.cql userorg.cql
```
2. `user.cql` and `userorg.cql`  will be created in the path specified above.

```
$ cat user.cql
INSERT INTO sunbird.user (id, channel, email, emailverified , firstName, rootorgid,status,username,roles,createddate) VALUES ('user-i-j-k',channeli,'user-i-j-k@gmaol.com',true,'name-i-j-k','root-org-i',1,'username-i-j-k',['Public'],2019-04-25.12:48:22+0530);
...

$ cat userorg.cql

INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-org-sub-root-i','root-org-i','user-i-j-k','root-org-i',2019-04-25.12:48:22+0530,['Public'],false);
INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-sub-org-i','school-i-j','user-i-j-k','school-i-j',2019-04-25.12:48:22+0530,['Public'],false);

```

3. Run the CQL commands generated on the cassandra server.

```
cqlsh -f user.cql
cqlsh -f userorg.cql
```
