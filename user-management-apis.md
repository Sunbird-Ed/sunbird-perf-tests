##  User Management APIs Benchmarking
### 1. Invoking APIs by directly calling the service
#### APIs being invoked before optimizations
* These APIs were invoked directly against the service
* The table shows the TPS of each API before the optimizations
* Each API is tested with 20,000 hashing

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
>* Heap sizes in Keycloak, Cassandra and Elasticsearch were incorrect
>* Keycloak CPU was reaching max during password hashing
>* User role and Get system setting APIs were fetching data always from database
>* Get user by email / phone API was returning too much data back to the client


#### APIs being invoked after optimizations
> Note: The login scenario includes 4 API calls

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
| Login                      | 160          | 64000   | 58          | 315      | 474.6          | 


>#### Optimizations / Infra changes done to achive this result
>
>* Created a new async API end point (Sign Up API) which will create users in the custodian org
>* Changed Get user by email / phone API as an async call
>* Changed Get system settings API as an async call
>* Changed Role read and Get system settings to store data in memory with a TTL for 4 hours instead of fetching data from database always
>* Created a new API end point (User exists) which returns a boolean value to the client
>* Few APIs were made as async calls to not block the request
>* Few APIs were changed to store data in memory cache for a certain TTL instead of fetching data from database always
>* Keycloak node increased from 2 vcpus, 8GB to 4 vcpus, 8GB
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
###### The number of users in the database is 5 million for all the below tests.
* These were captured after optimizations were applied to the individual APIs.
* Each API is tested with 20000 hashing – This is a feature in Keycloak for "Password Policy" where keycloak hashes the password 20,000 times before saving in the database
* Each API was invoked directly on domain url
* Infrastructure used in this run:
  - 3 Cassandra Nodes (4 vcpus, 16 GiB memory) 
  - 3 Application Elasticsearch Nodes (8 vcpus, 32 GiB memory)
  - 4 Keycloak Nodes (4 vcpus, 8 GiB memory)
  - Postgres (4 vcps )
  - 6 Learner Service Replicas
  - 12 Proxy Replicas
  - 6 Kong Replicas
  - 8 Player Service Replicas 
  
#### User Signup API invoked with 4 keycloak nodes
  
| API         | Thread Count | No of Samples | Error Count | Avg (ms) | 95th pct | 99th pct | Throughput/sec | 
|-------------|--------------|---------------|-------------|----------|----------|----------|----------------| 
| User signup | 80           | 8000          | 0           | 636      | 1216.95  | 2777.98  | 111.1          | 
| User signup | 120          | 12000         | 0           | 1039     | 2220     | 4846     | 107.2          | 
| User signup | 160          | 16000         | 0           | 1318     | 3030     | 5251.84  | 114.8          | 
| User signup | 160          | 48000         | 0           | 1499     | 4150     | 5981.91  | 102.2          | 


#### Login API invoked with 4 keycloak nodes
  
| API            | Thread Count | No of Samples | Error Count  | Avg (ms) | 95th pct | 99th pct | Throughput/sec | 
|----------------|--------------|---------------|--------------|----------|----------|----------|----------------| 
| Login          | 100          | 40000         | 58           | 101      | 356      | 599      | 363.7          | 
| Login          | 100          | 200000        | 179          | 261      | 586      | 984.97   | 363.9          | 
| Login          | 160          | 64000         | 58           | 315      | 1159     | 3082     | 474.6          | 
| Login          | 160          | 320000        | 275          | 324      | 411      | 2413.83  | 451.6          | 

>**Takeaway**
>
>100+ users can signup / login every second with the above infrastructure post optimizations.  
  
#### User Signup API invoked with 2 keycloak nodes

* Infrastructure changes done in this run:
  - 2 Keyclaok Nodes (4 vcpus, 8 GiB memory)  
  
| API         | Thread Count | No of Samples | Error Count  | Avg  | 95th pct | 99th pct | Throughput/sec | 
|-------------|--------------|---------------|--------------|------|----------|----------|----------------| 
| User signup | 80           | 8000          | 0            | 1278 | 3403.8   | 5101.92  | 55.2           | 
| User signup | 120          | 12000         | 0            | 1736 | 4000     | 6143.65  | 61.4           | 
| User signup | 160          | 16000         | 0            | 2118 | 5195.95  | 7436.96  | 67.4           | 


#### Login API invoked with 2 Keycloak nodes


| API            | Thread Count | No of Samples | Error Count | Avg | 95th pct | 99th pct | Throughput/sec | 
|----------------|--------------|---------------|-------------|-----|----------|----------|----------------| 
| Login          | 100          | 40000         | 58          | 389 | 2109.85  | 4164.9   | 234.4          | 
| Login          | 100          | 200000        | 177         | 400 | 1553.95  | 3035.93  | 243.2          | 
| Login          | 160          | 64000         | 137         | 763 | 1891.95  | 3593     | 196.1          | 
| Login          | 160          | 320000        | 291         | 598 | 1627     | 1971     | 261.6          | 

>**Takeaway**
>
>50+ users can signup / login every second with 2 Keycloak nodes. A 50% drop as compared to 4 Keyclaok nodes.

#### Other APIs
* Infrastructure changes done in this run:
  - 4 Keycloak Nodes (2 vcpus, 8 GiB memory)

| API                               | Thread Count | No of Samples | Error Count | Avg | Throughput/sec | 
|-----------------------------------|--------------|---------------|-------------|-----|----------------| 
| System Settings Read              | 100          | 200000        | 0           | 122 | 708.6          | 
| Get user by email or phone number | 100          | 100000        | 0           | 173 | 555.8          | 
| Role read                         | 100          | 500000        | 2           | 145 | 667.2          | 
| Generate token                    | 100          | 300000        | 0           | 144 | 678.4          | 
| User profile read                 | 100          | 150000        | 66          | 444 | 219.4          | 
| Org search                        | 100          | 500000        | 0           | 146 | 665.2          | 
| OTP generate                      | 100          | 20000         | 0           | 122 | 750.1          | 
| User- existence                   | 100          | 1000000       | 0           | 69  | 1395.1         | 
| Verify OTP                        | 100          | 20000         | 0           | 100 | 923.2          | 

* Infrastructure changes done in this run:
  - 2 Keycloak Nodes (2 vcpus, 8 GiB memory)

| API                               | Thread Count | No of Samples | Error Count | Avg | Throughput/sec |
|-----------------------------------|--------------|---------------|-------------|-----|----------------| 
| System settings read              | 100          | 200000        | 0           | 120      | 709.2          | 
| Get User by email or phone number | 100          | 100000        | 0           | 65       | 1424.5         | 
| Role read                         | 100          | 100000        | 0           | 142      | 674.4          | 
| Generate token                    | 100          | 300000        | 0           | 254      | 386.9          | 
| User profile read                 | 100          | 150000        | 73          | 403      | 241.9          | 
| Org search                        | 100          | 500000        | 0           | 148      | 660.7          | 
| OTP generate                      | 100          | 100000        | 0           | 141      | 675.9          | 
| User-existence                    | 100          | 1000000       | 0           | 66       | 1445.1         | 


### 3. APIs being invoked via proxy and API Manager using 1 hashing
#### APIs invoked with 4 Keycloak nodes
* Each API is tested with 1 hashing 
* Each API was invoked directly on domain url
* Infrastructure changes done in this run:
  - 4 Keycloak Nodes (2 vcpus, 8 GiB memory)
  
| API                               | Thread Count | No of Samples | Error Count | Avg | Throughput/sec | 
|-----------------------------------|--------------|---------------|-------------|-----|----------------| 
| User signup                       | 100          | 50000         | 0           | 963 | 99.6           | 
| Login                             | 100          | 173346        | 100         | 183 | 491.2          | 


#### APIs invoked with 2 Keycloak nodes

* Infrastructure changes done in this run:
  - 2 Keycloak Nodes (2 vcpus, 8 GiB memory)

| API                               | Thread Count | No of Samples | Error Count | Avg (ms) | Throughput/sec | 
|-----------------------------------|--------------|---------------|-------------|----------|----------------| 
| User signup                       | 100          | 50000         | 0           | 1008     | 94.3           | 
| Login                             | 100          | 234994        | 27          | 213      | 358.8          | 
