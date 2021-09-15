### Data setup

### Step 1:Inorder to Create User follow the below steps

1.CreateUser.jmx using this newlyCreatedUserList.csv gets generated.

2.Needed any one bearerToken for CreateUser.jmx

3.Provide the appropriate Department name and make password as static in request body

### Step 2:After Creating Users follow below steps

1.AssignDepartmentAndRole.jmx using this assigning roles to created users.

2.Have to set the cookie in header for that department mdo admin in header

3.Request body expect userId and organisationId, userId you can get from newlyCreatedUserList.csv, organisationId should be the departmentId from backend.

### Step 3:After Assigning Roles to that users follow below steps to generate Cookie which is required for Proxy Apis.

1.Login.jmx using this Cookie.csv gets generated which is required for Proxy Apis.

2.This expects emailId and password to login, email will be fetched from newlyCreatedUserList.csv, since password is set static during user creation can use the same.

3.This also expects hosts.csv file which contains protocol,host,port.

4.Generated Cookie.csv has three values email,userId,cookie.

5.Cookie.csv generated with blank row in between every cookie row, remove those blank row by using this unix command  sed -i '/^$/d' Cookie.csv

### Step 4:Please follow the steps to create Bearer Token which is required for Kong Apis.
 
1.LoginUsersToGenerateBearer.jmx using this Bearerone.csv gets generated for Kong Apis.

2.This expects emailId and Password to login,email will be fetched from newlyCreatedUserList.csv, since password is set static during user creation can use the same

3.Generate Bearerone.csv should have bearer tokens and userIds

all the above 4 steps can be executed one by one slave.

### Precondtions in order to Run ContentStateUpdate and ContentStateRead Apis.

1.User should auto enroll to respective courses using autoEnrollment.jmx.

2.This expects Collection.csv which contains list of live courses and Cookie.csv which contains email,userId and cookie.

3.userId and Cookie is passed in header where as course is passed as path params for request.



### Precondtions in order to Run Discussion Apis.

1.Before Running any Discussion apis, CreateUserNodeBB.jmx this should be run first, one time in a day.

2.This expects Cookie.csv which has email,userId and Cookie. Cookie is passed in header where as userId is passed in request body

### Precondtions in order to Run Network Apis.

1.Few Network hub apis requires two csvs one is AddConnectionFrom.csv and other is AddConnectionTo.csv

2.Both the files can be achived by spliting the Cookie.csv file into two and save one with AddConnectionFrom.csv and other with AddConnectionTo.csv

3.AddConnectionFrom.csv and AddConnectionTo.csv both files contains userIds which is required for network Apis.
