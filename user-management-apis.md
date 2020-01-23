##  User Management APIs Benchmarking

#### Jmeter Cluster
For benchmarking the APIs, a Jmeter cluster (1 master + 4 slaves in cluster) was setup to perform API testing and verifying improvements in parallel.

#### APIs Invoked in this benchmarking
| API Name                          | API path                                           | Description                                                                                                                                                                                        |
|-----------------------------------|----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| User signup                       | /api/user/v1/signup                                 | POST API to create user with very signup attributes (firstName, email/phone, password, emailVerified/phoneVerified). All users created by this end point will be linked with custodian org. This API invokes the updatePassword keycloak API to register the credentials in Keycloak |
| System settings read              | /api/data/v1/system/settings/get                   | GET API is used to read the system setting specific value. will get the value from in-memory cache with a ttl of 4 hours.                                                       |
| Get user by email or phone number | /api/user/v1/get/email                             | GET API for searching a specific user, the user search is based on the email/phone of the user.                                                                                     |
| Role Read                         | /api/data/v1/role/read                             | GET API is used to read all the user availaible roles in the system, read from db for the first time and caches the data with a ttl of 4 hours.                |
| Generate Token                    | /auth/realms/sunbird/protocol/openid-connect/token | POST API (Keycloak) is used to generate Keycloak token                                                                                                                                                        |
| User profile read                 | /api/user/v2/read                                  | GET API is used to read user on the basis of unique identifier.                                                                                                                                    |
| Org Search                        | /api/org/v1/search                                 | POST API is used to search the Organisations based on provided filters.                                                                                                                     |
| OTP Generate                      | /api/otp/v1/generate                               | POST API is associated with sending OTP to user. with expiry time of 30 mins.                                                                                                                      |
| User-existence                    | /v1/user/exists/email                              | GET API is used for check whether user exists.                                                                         |
| Login Scenerio - 1st API          | /resources/                                        | GET API call of Portal which will take user to login page                                                                                                                                                 |
| Login Scenerio - 2nd API          | /auth/realms/sunbird/protocol/openid-connect/auth  | GET call to Keycloak to fetch the login page                                                                                                                                                                    |
| Login Scenerio - 3rd API          | /auth/realms/sunbird/login-actions/authenticate    | POST API call of Keycloak during authentication. This API accepts credentials in the post body.                                                                                                                                                                  |
| Login Scenerio - 4th API          | /resources                                         | GET API call of Portal which will redirect the user to resources page post authentication. This calls internally invokes the GenerateToken API of keycloak.                                                                                                                         |

### 1. Invoking APIs by directly calling the service
#### APIs being invoked before optimizations
* These APIs were invoked directly against the service without going through proxy/api manager
* The table shows the TPS of each API before the optimizations
* Each API is tested with 20,000 password hashing iterations in Keycloak. 
[More details on password hashing](https://www.keycloak.org/docs/6.0/server_admin/#password-policy-types)

| Api                        | Thread Count | Samples | Error % | Throughput/sec | 
|----------------------------|--------------|---------|---------|----------------| 
| User signup                | 400          | 8000    | 11.39   | 24             | 
| System settings read       | 400          | 40000   | 0       | 1122           | 
| Get user by email or phone | 400          | 8000    | 0       | 66             | 
| Role read                  | 1000         | 120000  | 0       | 40             | 
| Generate token             | 600          | 60000   | 5       | 211            | 
| User Profile read          | 400          | 16000   | 6       | 142            | 
| Org search                 | 400          | 8000    | 0       | 455            | 
| Otp generate               | 800          | 48000   | 46      | 563            | 

>#### Result Analysis & findings
>
>* Create user API was performing multiple verification checks and it was not an async call which would block the requests
>* Postgresql queries were taking a long time
>* Cassandra was timing out during replication across nodes
>* Heap sizes in Keycloak, Cassandra and Elasticsearch were too low in comparison to the amount of physical memory available.
>* Keycloak CPU was reaching max during password hashing (due to the number of iterations)
>* User role and Get system setting APIs were fetching static data always from database
>* Get user by email / phone API was returning too much data back to the client


#### APIs being invoked after optimizations
Note: The login scenario includes 4 API calls
   - /resources/
   - /auth/realms/sunbird/protocol/openid-connect/auth
   - /auth/realms/sunbird/login-actions/authenticate
   - /resources

| API                        | Thread Count | Samples | Error Count | Avg (ms) | Throughput/sec | 
|----------------------------|--------------|---------|-------------|----------|----------------| 
| User signup                | 80           | 8000    | 0           | 636      | 111.1          | 
| System settings read       | 400          | 120000  | 0           | 106      | 2175.5         | 
| Get user by email or phone | 100          | 100000  | 0           | 65       | 1424.5         | 
| Role read                  | 400          | 120000  | 0           | 305      | 1219.9         | 
| Generate token             | 100          | 300000  | 0           | 144      | 678.4          | 
| User profile read          | 400          | 120000  | 71          | 1267     | 286.6          | 
| Org search                 | 400          | 120000  | 0           | 333      | 1130.8         | 
| OTP generate               | 400          | 40000   | 0           | 265      | 1314           | 
| Login Workflow (4 API calls)        | 160          | 64000   | 58          | 315      | 474.6          | 

***To view the benchmarking details of the above APIs via Proxy and API manager, click [here](#rerun-of-individual-apis-via-proxy-and-api-manager)***

>#### Optimizations / Infra changes done to achive this result
>
>* Created a new API end point (Sign Up API, non blocking code) which will create users in the custodian org
>* Changed Get user by email / phone API to use non blocking code
>* Changed Get system settings API to use non blocking code
>* Changed Role read and Get system settings API to store static data in memory with a TTL for 4 hours instead of fetching data from database always
>* Created a new API end point (User exists) which returns a boolean value to the client
>* Keycloak node increased from 2 vcpus, 8GB to 4 vcpus, 8GB. The increase in CPU is to support 20000 hashing iterations which is the best practice.
>* Keycloak Heap size increased from default 512MB to 6GB
>* Elasticsearch node increased from 2 vcpus, 14GB to 8 vcpus, 32GB
>* Increased Elasticsearch heap size from 2GB to 16GB
>* Updated Cassandra write time out from default 2 seconds to 5 seconds
>* Updated Cassandra heap size to 4GB
>* Updated learner service env value to use 3 Elasticsearch IP instead of 1
>* Created a new optimised API endpoint for user signup - *api/user/v1/signup*
>* Created a new optimized API endpoint for checking if user exists using email id – *api/user/v1/exists/email*
>* Created the following new indexes in Keycloak database:
>     - Index on column "type" on table fed_user_credential
>     - Index on column "user_id" on table fed_user_credential
>     - Index on column "user_id" on table FED_USER_ATTRIBUTE
>     - Index on column "realm_id" on table FED_USER_ATTRIBUTE
  
  
### 2. APIs being invoked via Proxy & API Manager 

 **Benchmarking Details:**
###### The below tests were done after creating 5 million users.
* These were captured after optimizations were applied to the individual APIs.
* Each API is tested with 20000 password hashing iterations – This is a feature in Keycloak for "Password Policy" where keycloak hashes the password 20,000 times before saving in the database
* Each API was invoked directly on domain url (loadtest.ntp.net.in)
* Infrastructure used in this run:
  - 3 Cassandra Nodes (4 vcpus, 16 GiB memory) 
  - 3 Application Elasticsearch Nodes (8 vcpus, 32 GiB memory)
  - 4 Keycloak Nodes (4 vcpus, 8 GiB memory)
  - 1 Postgres instance (4 vcps )
  - 6 Learner Service Replicas (Running in the swarm)
  - 12 Proxy Replicas (Running in the swarm)
  - 6 Kong Replicas (Running in the swarm)
  - 8 Player Service Replicas (Running in the swarm)
  
#### User Signup API invoked with 4 keycloak nodes
  
| API         | Thread Count | No of Samples | Error Count | Avg (ms) | 95th pct | 99th pct | Throughput/sec | 
|-------------|--------------|---------------|-------------|----------|----------|----------|----------------| 
| User signup | 80           | 8000          | 0           | 636      | 1216.95  | 2777.98  | 111.1          | 
| User signup | 120          | 12000         | 0           | 1039     | 2220     | 4846     | 107.2          | 
| User signup | 160          | 16000         | 0           | 1318     | 3030     | 5251.84  | 114.8          | 
| User signup | 160          | 48000         | 0           | 1499     | 4150     | 5981.91  | 102.2          | 


#### Login Workflows invoked with 4 keycloak nodes

| API            | Thread Count | No of Samples | Error Count  | Avg (ms) | 95th pct | 99th pct | Throughput/sec | 
|----------------|--------------|---------------|--------------|----------|----------|----------|----------------| 
| Login Workflow (4 API calls)| 100          | 40000         | 58           | 101      | 356      | 599      | 363.7          | 
| Login Workflow (4 API calls)| 100          | 200000        | 179          | 261      | 586      | 984.97   | 363.9          | 
| Login Workflow (4 API calls)| 160          | 64000         | 58           | 315      | 1159     | 3082     | 474.6          | 
| Login Workflow (4 API calls)| 160          | 320000        | 275          | 324      | 411      | 2413.83  | 451.6          | 

>**Takeaway**
>
>100+ users can signup & login every second with the above infrastructure post optimizations. The throughput for Login workflow of 400 implies 100 logins as each login has 4 network calls.


#### Long Running Test for User Signup API and Login Workflows
*The user sign up was run for a duration of 3 hours and 40 minutes. The test created 1 million users.*

*The login scenario was run for a duration of 3 hours and 55 minutes. The database had 5 million+ users.*

| API                 | Thread Count | No of Samples | Error Count | Avg  | Throughput/sec | Duration of run (HH:MM:SS)| Comments                                     |
|---------------------|--------------|---------------|-------------|------|----------------|---------------------------|----------------------------------------------|
| User signup         | 100          | 1000000       | 103         | 1317 | 75.5           | 3:40:52                   | This implies that 1 million users signed up  |
| Login Workflow (4 API calls) | 160          | 6400000       | 2957        | 352  | 453            | 3:55:51                   | This implies that 1.6 million users logged in|
  
#### User Signup API invoked with 2 keycloak nodes

* Infrastructure changes done in this run:
  - 2 Keyclaok Nodes (4 vcpus, 8 GiB memory)  
  
| API         | Thread Count | No of Samples | Error Count  | Avg  | 95th pct | 99th pct | Throughput/sec | 
|-------------|--------------|---------------|--------------|------|----------|----------|----------------| 
| User signup | 80           | 8000          | 0            | 1278 | 3403.8   | 5101.92  | 55.2           | 
| User signup | 120          | 12000         | 0            | 1736 | 4000     | 6143.65  | 61.4           | 
| User signup | 160          | 16000         | 0            | 2118 | 5195.95  | 7436.96  | 67.4           | 


#### Login Workflow invoked with 2 Keycloak nodes


| API            | Thread Count | No of Samples | Error Count | Avg | 95th pct | 99th pct | Throughput/sec | 
|----------------|--------------|---------------|-------------|-----|----------|----------|----------------| 
| Login Workflow (4 API calls)| 100          | 40000         | 58          | 389 | 2109.85  | 4164.9   | 234.4          | 
| Login Workflow (4 API calls)| 100          | 200000        | 177         | 400 | 1553.95  | 3035.93  | 243.2          | 
| Login Workflow (4 API calls)| 160          | 64000         | 137         | 763 | 1891.95  | 3593     | 196.1          | 
| Login Workflow (4 API calls)| 160          | 320000        | 291         | 598 | 1627     | 1971     | 261.6          | 

>**Takeaway**
>
>50+ users can signup / login every second with 2 Keycloak nodes. A 50% drop as compared to 4 Keyclaok nodes.

#### Rerun of individual APIs via Proxy and API Manager

| API                               | Thread Count | No of Samples | Error Count | Avg | Throughput/sec |
|-----------------------------------|--------------|---------------|-------------|-----|----------------| 
| System settings read              | 100          | 200000        | 0           | 120 | 709.2          | 
| Get User by email or phone number | 100          | 100000        | 0           | 65  | 1424.5         | 
| Role read                         | 100          | 100000        | 0           | 142 | 674.4          | 
| Generate token                    | 100          | 300000        | 0           | 144 | 678.4          | 
| User profile read                 | 100          | 150000        | 73          | 40  | 241.9          | 
| Org search                        | 100          | 500000        | 0           | 146 | 665.2          | 
| OTP generate                      | 100          | 20000         | 0           | 122 | 750.1          | 
| User-existence                    | 100          | 1000000       | 0           | 66  | 1445.1         |
| Verify OTP                        | 100          | 20000         | 0           | 100 | 923.2          | 


***To view the benchmarking details of the above APIs by invoking the service directly, click [here](#apis-being-invoked-after-optimizations)***


### 3. APIs being invoked via proxy and API Manager using 1 hashing iteration
The below tests indicate that we can get much higher throughput on lesser keycloak cores by reducing the number of iterations.

#### APIs invoked with 4 Keycloak nodes
* Each API is tested with 1 hashing iteration
* Each API was invoked directly on domain url
* Infrastructure changes done in this run:
  - 4 Keycloak Nodes (2 vcpus, 8 GiB memory)
  
| API                               | Thread Count | No of Samples | Error Count | Avg | Throughput/sec | 
|-----------------------------------|--------------|---------------|-------------|-----|----------------| 
| User signup                       | 100          | 50000         | 0           | 963 | 99.6           | 
| Login (4 API calls)               | 100          | 173346        | 100         | 183 | 491.2          | 


#### APIs invoked with 2 Keycloak nodes

* Infrastructure changes done in this run:
  - 2 Keycloak Nodes (2 vcpus, 8 GiB memory)

| API                               | Thread Count | No of Samples | Error Count | Avg (ms) | Throughput/sec | 
|-----------------------------------|--------------|---------------|-------------|----------|----------------| 
| User signup                       | 100          | 50000         | 0           | 1008     | 94.3           | 
| Login (4 API calls)               | 100          | 234994        | 27          | 213      | 358.8          | 
