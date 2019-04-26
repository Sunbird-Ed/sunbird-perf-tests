The purpose of this document is to describe the steps required to run the scripts for automated creation of user to sub orgs.

1. Run load test scenario script with necessary arguments:

```
sh create-user-sub-org.sh <NUM_ROOT_ORGS> <NUM_SUB_ORG> <NUM_USER_SUB_ORG> <EXEC>
```

e.g.
```
sh create-user-sub-org.sh 28 50000 1 true
```
2. User creation command will be logged in the terminal
