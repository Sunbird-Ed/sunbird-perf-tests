##  Consumption APIs Benchmarking

#### Jmeter Cluster
For benchmarking the APIs, one Jmeter cluster (1 master + 8 slaves in) were setup to perform API testing and verifying improvements in parallel.

### APIs Invoked in this benchmarking

| API Name          | API path                   | Description | 
|-------------------|----------------------------|-------------| 
| Content Read      | /api/content/v1/read       | GET API call used to read a content based on do id's| 
| Org Search        | /api/org/v1/search         | POST API call used to read a organisation based on channel id| 
| Send Telemetry    | /api/org/v1/search         | POST API call which sends telemetry data with compressed payload| 
| Content Hierarchy | /api/course/v1/hierarchy   | GET API call used to read course hierarchy based on do id's| 
| Dial Search       | /api/content/v1/search     | POST API call used to search dial codes based on QR code| 
| Form Read         | /api/data/v1/form/read     | POST API call used to read forms| 
| Tenant Info       | /v1/tenant/info            | GET API call used to read tenants based on tenant id| 
| Page Assemble     | /api/data/v1/page/assemble | POST API call used to dispaly relavent contents on explore page or post login page| 
| Device Register   | /api/v3/device/register    | POST API call used to send the device id|


### Infrastructure and Container details
* Exact same infrastructre, container replicas, container cpu and memory limits were setup for Kubernetes and Docker
* Docker and Kubernetes were setup with 12 Nodes - Standard D4s v3 (4 vcpus, 16 GiB memory) on Azure
* Kubernetes was setup in AKS
* All the 12 nodes were used to invoke the service from Jmeter in round robin
* Container repilcas -
  * Proxy - 12 (cpu limit - 1 core, memory limit - 1GB)
  * Kong - 6 (cpu limit - 1 core, memory limit - 1GB)
  * Player - 8 (cpu limit - 1.5 core, memory limit - 1GB)
  * KnowledgeMW - 8 (cpu limit - 2 core, memory limit - 4GB)
  * Content - 6 (cpu limit - 2 core, memory limit - 4GB)
  * LMS - 6 (cpu limit - 2 core, memory limit - 4GB)
  * Learner - 6 (cpu limit - 3 core, memory limit - 4GB)
  * Telemetry 6 (cpu limit - 1.5 core, memory limit - 1GB)


**1. Individual API benchmarking**
* The API's were invoked by directly accessing the service
* The services were setup to run as NodePort in kubernetes

>**Kubernetes**

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time| Throughput (req/sec) | 
|----------------|--------------|---------------|-------------|----------|----------|----------|----------------------| 
| Content Read   | 600          | 9000000       | 0           | 107      | 65       | 110      | 5419                 | 
| Org Search     | 400          | 2400000       | 0           | 344      | 328      | 454      | 1146.8               | 
| Send Telemetry | 400          | 1200000       | 0           | 618      | 994.95   | 1298.97  | 641.6                | 


>**Docker**

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|----------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Content Read   | 600          | 9000000       | 0           | 131      | 46                          | 1023                        | 4447.2               | 
| Org Search     | 400          | 2400000       | 0           | 390      | 519                         | 843.97                      | 1015.9               | 
| Send Telemetry | 400          | 1200000       | 1           | 692      | 1067                        | 1337                        | 573.3                | 



**2. Individual API benchmarking via Proxy and API Manager**
* Proxy was setup to run as NodePort in kubernetes
* API manager was setup to run as ClusterIP
* Separate database was created with FQDN of internal service names for API Manager

>**Kubernetes**

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|----------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Content Read   | 600          | 4500000       | 0           | 228      | 283                         | 378.99                      | 2582.1               | 
| Org Search     | 400          | 2400000       | 0           | 252      | 364                         | 458                         | 1571.7               | 
| Send Telemetry | 400          | 400000        | 0           | 602      | 859.95                      | 1023.97                     | 657.1                | 


>**Docker**

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|----------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Content Read   | 600          | 4500000       | 0           | 280      | 248                         | 330                         | 2116.9               | 
| Org Search     | 400          | 1200000       | 0           | 559      | 842                         | 1098                        | 705.2                | 
| Send Telemetry | 400          | 1200000       | 0           | 676      | 1560                        | 1847                        | 581.9                | 


**3. Benchmarking 8 commonly used API's during consumption via Proxy and API Manager**

>**Kubernetes**


| API               | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Total             |              | 2400000       | 0           | 159.12   | 395                         | 718.97                      | 3543.49              | 
| Content Hierarchy | 600          | 300000        | 0           | 262.74   | 896.85                      | 1433.98                     | 443                  | 
| Content Read      | 600          | 300000        | 0           | 165.05   | 626                         | 1083.99                     | 443.05               | 
| Device Register   | 600          | 300000        | 0           | 63.06    | 104                         | 144                         | 443.05               | 
| Dial Search       | 600          | 300000        | 0           | 129.51   | 508                         | 833.98                      | 443.05               | 
| Form Read         | 600          | 300000        | 0           | 79.39    | 297                         | 458                         | 443.05               | 
| Org Search        | 600          | 300000        | 0           | 231.01   | 859                         | 1276.99                     | 443.05               | 
| Send Telemetry    | 600          | 300000        | 0           | 270.63   | 716                         | 1287.99                     | 443.03               | 
| Tenant Info       | 600          | 300000        | 0           | 71.61    | 261                         | 393.99                      | 443.04               | 



>**Docker**

| API               | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Total             |              | 4800000       | 0           | 264.93   | 445                         | 784                         | 2200.91              | 
| Content Hierarchy | 600          | 600000        | 0           | 388.31   | 1238                        | 1977                        | 275.12               | 
| Content Read      | 600          | 600000        | 0           | 252.06   | 850                         | 1433.98                     | 275.14               | 
| Device Register   | 600          | 600000        | 0           | 35.2     | 73                          | 110                         | 275.14               | 
| Dial Search       | 600          | 600000        | 0           | 201.14   | 671                         | 1114.99                     | 275.14               | 
| Form Read         | 600          | 600000        | 0           | 89.11    | 183                         | 330.99                      | 275.14               | 
| Org Search        | 600          | 600000        | 0           | 312.9    | 1388.9                      | 2102.98                     | 275.13               | 
| Send Telemetry    | 600          | 600000        | 0           | 750.22   | 2098.95                     | 2598                        | 275.14               | 
| Tenant Info       | 600          | 600000        | 0           | 90.54    | 170                         | 294                         | 275.14               | 



**4. Benchmarking 9 commonly used API's during consumption via Proxy and API Manager**

>**Kubernetes**

| API               | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Total             |              | 5400000       | 0           | 186.34   | 413                         | 1052                        | 3119.74              | 
| Content Hierarchy | 600          | 600000        | 0           | 214.76   | 556.95                      | 901.99                      | 346.66               | 
| Content Read      | 600          | 600000        | 0           | 124.38   | 368                         | 711.99                      | 346.68               | 
| Device Register   | 600          | 600000        | 0           | 49.26    | 78                          | 150.99                      | 346.68               | 
| Dial Search       | 600          | 600000        | 0           | 144.91   | 341                         | 591                         | 346.68               | 
| Form Read         | 600          | 600000        | 0           | 45.25    | 180                         | 344.99                      | 346.69               | 
| Org Search        | 600          | 600000        | 0           | 93.89    | 184                         | 363.99                      | 346.68               | 
| Page Assemble     | 600          | 600000        | 0           | 469.44   | 1236                        | 1971.98                     | 346.68               | 
| Send Telemetry    | 600          | 600000        | 0           | 486.49   | 2585                        | 3119                        | 346.68               | 
| Tenant Info       | 600          | 600000        | 0           | 48.65    | 163                         | 309.99                      | 346.69               | 


>**Docker**

| API               | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Total             |              | 5400000       | 1           | 274.96   | 397                         | 631                         | 2125.75              | 
| Content Hierarchy | 600          | 600000        | 0           | 422.3    | 1235.95                     | 1931                        | 236.2                | 
| Content Read      | 600          | 600000        | 0           | 274.5    | 821.95                      | 1318.99                     | 236.26               | 
| Device Register   | 600          | 600000        | 0           | 32.24    | 77                          | 135                         | 236.45               | 
| Dial Search       | 600          | 600000        | 0           | 232.83   | 717.95                      | 1188.98                     | 236.37               | 
| Form Read         | 600          | 600000        | 0           | 67.72    | 207                         | 393.99                      | 236.38               | 
| Org Search        | 600          | 600000        | 0           | 190.72   | 1669.95                     | 2300.98                     | 236.44               | 
| Page Assemble     | 600          | 600000        | 1           | 379.03   | 766.95                      | 1247.99                     | 236.48               | 
| Send Telemetry    | 600          | 600000        | 0           | 812.44   | 1553.95                     | 2087.99                     | 236.45               | 
| Tenant Info       | 600          | 600000        | 0           | 62.87    | 180                         | 349                         | 236.55               | 



**5. Benchmarking 8 commonly used API's during consumption via Proxy and API Manager (Long Running Test)**
* Duration of run - 2h 10m

>**Kubernetes**

| API               | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Total             |              | 24000000      | 0           | 191.72   | 240                         | 2311.88                     | 3071.93              | 
| Content Hierarchy | 600          | 3000000       | 0           | 264.07   | 794                         | 1205.98                     | 383.99               | 
| Content Read      | 600          | 3000000       | 0           | 174.72   | 542.95                      | 879                         | 384                  | 
| Device Register   | 600          | 3000000       | 0           | 128.24   | 71                          | 92                          | 384                  | 
| Dial Search       | 600          | 3000000       | 0           | 127.43   | 466                         | 667                         | 384                  | 
| Form Read         | 600          | 3000000       | 0           | 24.28    | 33                          | 121.97                      | 384                  | 
| Org Search        | 600          | 3000000       | 0           | 461.01   | 3526                        | 4223                        | 384                  | 
| Send Telemetry    | 600          | 3000000       | 0           | 333.29   | 204.95                      | 508.97                      | 384                  | 
| Tenant Info       | 600          | 3000000       | 0           | 20.74    | 18                          | 84.99                       | 384                  | 


**6. API reponse times of the 9 commonly used API's during consumption**
* All API calls were via Proxy and Kong
* All response times are in milliseconds
* This data is captured from Kong using statsd plugin
* This table tells us the max response time that the particular API has taken

>**Kubernetes**

| API Name          | API Name in Kong   | max (milliseconds) |
|-------------------|--------------------|--------------------|
| Content Hierarchy | getCourseHierarchy | 94                 |
| Content Read      | readContent        | 93                 |
| Device Register   | deviceRegister     | 93                 |
| Dial Search       | searchContent      | 93                 |
| Form Read         | readForm           | 92                 |
| Org Search        | searchOrg          | 92                 |
| Page Assemble     | assemblePage       | 81                 |
| Send Telemetry    | telemetry          | 93                 |
| Tenant Info       | getTenantInfo      | 90                 |

>**Docker**

| API Name          | API Name in Kong   | max (milliseconds) |
|-------------------|--------------------|--------------------|
| Content Hierarchy | getCourseHierarchy | 297                |
| Content Read      | readContent        | 297                |
| Device Register   | deviceRegister     | 298                |
| Dial Search       | searchContent      | 297                |
| Form Read         | readForm           | 297                |
| Org Search        | searchOrg          | 298                |
| Page Assemble     | assemblePage       | 257                |
| Send Telemetry    | telemetry          | 296                |
| Tenant Info       | getTenantInfo      | 296                |
