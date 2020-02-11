##  Consumption APIs Benchmarking

#### Jmeter Cluster
For benchmarking the APIs, one Jmeter cluster (1 master + 8 slaves in) were setup to perform API testing and verifying improvements in parallel.

### APIs Invoked in this benchmarking

| API Name          | API path                   | Description | 
|-------------------|----------------------------|-------------| 
| Content Read      | /api/content/v1/read       |             | 
| Org Search        | /api/org/v1/search         |             | 
| Send Telemetry    | /api/org/v1/search         |             | 
| Content Hierarchy | /api/course/v1/hierarchy   |             | 
| Dial Search       | /api/content/v1/search     |             | 
| Form Read         | /api/data/v1/form/read     |             | 
| Tenant Info       | /v1/tenant/info            |             | 
| Page Assemble     | /api/data/v1/page/assemble |             | 
| Device Register   | /api/v3/device/register    |             | 


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

*Kubernetes*

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time| Throughput (req/sec) | 
|----------------|--------------|---------------|-------------|----------|----------|----------|----------------------| 
| Content Read   | 600          | 9000000       | 0           | 107      | 65       | 110      | 5419                 | 
| Org Search     | 400          | 2400000       | 0           | 344      | 328      | 454      | 1146.8               | 
| Send Telemetry | 400          | 1200000       | 0           | 618      | 994.95   | 1298.97  | 641.6                | 


*Docker*

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|----------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Content Read   | 600          | 9000000       | 0           | 131      | 46                          | 1023                        | 4447.2               | 
| Org Search     | 400          | 2400000       | 0           | 390      | 519                         | 843.97                      | 1015.9               | 
| Send Telemetry | 400          | 1200000       | 1           | 692      | 1067                        | 1337                        | 573.3                | 



**2. Individual API benchmarking via Proxy and API Manager**
* Proxy was setup to run as NodePort in kubernetes
* API manager was setup to run as ClusterIP
* Separate database was created with FQDN of internal service names for API Manager

*Kubernetes*

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|----------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Content Read   | 600          | 4500000       | 0           | 228      | 283                         | 378.99                      | 2582.1               | 
| Org Search     | 400          | 2400000       | 0           | 252      | 364                         | 458                         | 1571.7               | 
| Send Telemetry | 400          | 400000        | 0           | 602      | 859.95                      | 1023.97                     | 657.1                | 


*Docker*

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|----------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Content Read   | 600          | 4500000       | 0           | 280      | 248                         | 330                         | 2116.9               | 
| Org Search     | 400          | 1200000       | 0           | 559      | 842                         | 1098                        | 705.2                | 
| Send Telemetry | 400          | 1200000       | 0           | 676      | 1560                        | 1847                        | 581.9                | 


**3. Benchmarking 8 commonly used API's during consumption via Proxy and API Manager**

>* Note: The soak test scenario includes 8 API calls
>* Content Read
>* Org Search
>* Send Telemetry
>* Content Hierarchy
>* Dial Search
>* Form Read
>* Tenant Info
>* Device Register

* Number of threads - 600

*Kubernetes*


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



*Docker*

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

>* Note: The soak test scenario includes 9 API calls
>* Content Read
>* Org Search
>* Send Telemetry
>* Content Hierarchy
>* Dial Search
>* Form Read
>* Tenant Info
>* Device Register
>* Page Assemble 


*Kubernetes*

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


*Docker*

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

*Kubernetes*

| API                     | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Soak Test (8 API calls) | 600          | 24000000      | 1           | 191      | 240                         | 2311.88                     | 3071.9               | 



**6. API reponse times of the 9 commonly used API's during consumption**
* All response times are in milliseconds

*Kubernetes*
| TR1 | TR2 | TR3 |
|-----|-----|-----|

*Docker*
| TR1 | TR2 | TR3 |
|-----|-----|-----|
