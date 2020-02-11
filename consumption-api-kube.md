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

| API                     | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Soak Test (8 API calls) | 600          | 2400000       | 0           | 159.12   | 395                         | 718.97                      | 3543.49              | 
| Soak Test (8 API calls) | 600          | 4800000       | 0           | 168      | 373                         | 960                         | 3409.2               | 


>**Docker**

| API                     | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Soak Test (8 API calls) | 600          | 2400000       | 0           | 264.39   | 671                         | 1725.98                     | 2148.98              | 
| Soak Test (8 API calls) | 600          | 4800000       | 1           | 264      | 445                         | 784                         | 2200.7               | 


**4. Benchmarking 9 commonly used API's during consumption via Proxy and API Manager**

>**Kubernetes**

| API                     | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Soak Test (9 API calls) | 600          | 5400000       | 0           | 186      | 413                         | 1052                        | 3119.4               | 


>**Docker**

| API                     | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Soak Test (9 API calls) | 600          | 5400000       | 499         | 274      | 397                         | 631                         | 2125.6               | 



**5. Benchmarking 8 commonly used API's during consumption via Proxy and API Manager (Long Running Test)**
* Duration of run - 2h 10m

>**Kubernetes**

| API                     | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-------------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Soak Test (8 API calls) | 600          | 24000000      | 1           | 191      | 240                         | 2311.88                     | 3071.9               | 



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
