##  Consumption APIs Benchmarking

#### Jmeter Cluster
For benchmarking the APIs, one Jmeter cluster (1 master + 5 slaves in) were setup to perform API testing and verifying improvements in parallel.

### APIs Invoked in this benchmarking

| API Name             | API path                                         | Description                                                                         | 
|----------------------|--------------------------------------------------|-------------------------------------------------------------------------------------| 
| Content Read         | /api/content/v1/read/contentDoId                 | GET API call used to read a content based on do id's                                | 
| Content Search       | /apis/proxies/v8/sunbirdigot/read                | POST API call used to search content based on the course                            | 
| Send Telemetry       | /apis/protected/v8/user/telemetry                | POST API call which sends telemetry data with compressed payload                    | 
| Content Hierarchy    | /api/course/v1/hierarchy/courseDoId              | GET API call used to read course hierarchy based on do id's                         | 
| UserRead             | /api/user/v1/read/userId                         | GET API call used to User details based on userIds                                  | 
| Enrollement List     | /v8/learner/course/v1/user/enrollment/list/userId| GET API call used to get course Enrollment based on userIds                         | 
| Content State Update | /api/course/v1/content/state/update              | PATCH API call used to update the content sataus based on content do ids and userIds| 
| Content State Read   | /api/course/v1/content/state/read                | POST API call used to get the content progress based on course do ids and userIds   | 


### Infrastructure and Container details
* Exact same infrastructre, container replicas, container cpu and memory limits were setup for Kubernetes and Docker
* Docker and Kubernetes were setup with 7 Nodes - Standard f8s v3 (8 vcpus, 16 GiB memory) on Azure
* Kubernetes was setup in AKS
  * In AKS, Azure CNI networking was used
  * A subnet with a CIDR /22 in the VNET was created for AKS cluster
  * In Azure CNI, every pod gets a IP directly from the subnet
  * There is no NAT between Kubernetes pods and nodes (Kubernetes nodes / External nodes)
  * You will be able to directly connect to the pod using the pod ip
  * If you inspect the traffic to / from pods, you will see the IP of the pod as source / destination and not the node in which it is running (there is no NAT between pod and node)
  * For more information on Azure CNI, please visit - https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni
* All the 7 nodes were used to invoke the service from Jmeter in round robin
* Container repilcas -
  * Proxy - 7 (cpu limit - 1 core, memory limit - 1GB)
  * Kong - 6 (cpu limit - 1 core, memory limit - 1GB)
  * Player - 8 (cpu limit - 1.5 core, memory limit - 1GB)
  * KnowledgeMW - 8 (cpu limit - 2 core, memory limit - 4GB)
  * Content - 6 (cpu limit - 2 core, memory limit - 4GB)
  * LMS - 6 (cpu limit - 2 core, memory limit - 4GB)
  * Learner - 6 (cpu limit - 3 core, memory limit - 4GB)
  * Telemetry 6 (cpu limit - 1.5 core, memory limit - 1GB)


**1. Individual API benchmarking via Proxy and API Manager**
* Proxy was setup to run as NodePort in kubernetes
* API manager was setup to run as ClusterIP

>**Kubernetes**

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time| Throughput (req/sec) | 
|----------------------|--------------|---------------|-------------|----------|----------|----------|----------------------| 
| Content Read         | 100          | 150000        | 0           | 72.45    | 88       | 337.69   | 1759.49              | 
| Content Search       | 100          | 525000        | 0           | 182.4    | 533      | 1347.98  | 564.18               | 
| Send Telemetry       | 100          | 525000        | 0           | 98.53    | 301      | 553.99   | 1039.04              | 
| Content Hireachy     | 100          | 1500000       | 0           | 96.73    | 284      | 542      | 1407.97              | 
| User Read            | 100          | 525000        | 0           | 141.03   | 206.95   | 2390.97  | 727.03               | 
| Enrollement List     | 100          | 525000        | 0           | 241.25   | 287      | 2361.99  | 431                  | 
| Content State Update | 100          | 263014        | 300         | 252.49   | 114      | 474      | 309.97               | 
| Content State Read   | 100          | 525000        | 0           | 114.61   | 110      | 552.67   | 894.97               | 




**2. Benchmarking 8 commonly used API's during consumption via Proxy and API Manager**

>**Kubernetes**


| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time| Throughput (req/sec) | 
|----------------------|--------------|---------------|-------------|----------|----------|----------|----------------------| 
| Content Read         | 100          | 150000        | 0           | 72.45    | 88       | 337.69   | 1759.49              | 
| Content Search       | 100          | 525000        | 0           | 182.4    | 533      | 1347.98  | 564.18               | 
| Send Telemetry       | 100          | 525000        | 0           | 98.53    | 301      | 553.99   | 1039.04              | 
| Content Hireachy     | 100          | 1500000       | 0           | 96.73    | 284      | 542      | 1407.97              | 
| User Read            | 100          | 525000        | 0           | 141.03   | 206.95   | 2390.97  | 727.03               | 
| Enrollement List     | 100          | 525000        | 0           | 241.25   | 287      | 2361.99  | 431                  | 
| Content State Update | 100          | 263014        | 300         | 252.49   | 114      | 474      | 309.97               | 
| Content State Read   | 100          | 525000        | 0           | 114.61   | 110      | 552.67   | 894.97               | 





**3. Benchmarking 11 commonly used API's during consumption via Proxy and API Manager (Long Running Test)**
* Duration of run - 8h 5m

>**Kubernetes**

| API               | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time | Throughput (req/sec) | 
|-----------------------|--------------|---------------|-------------|----------|-----------------------------|-----------------------------|----------------------| 
| Total                 |              | 158160477     | 5092        | 245.68   | 75                          | 117                         | 5474.88              | 
| Career Listing        | 100          | 6718894       | 1           | 527.93   | 187                         | 331.99                      | 232.58               | 
| Content Hireachy      | 100          | 26317964      | 0           | 133.26   | 55                          | 75                          | 911.03               | 
| Content Read          | 100          | 31116313      | 0           | 112.52   | 30                          | 56                          | 1077.13              | 
| Content Search        | 100          | 18103793      | 1           | 194.72   | 124                         | 185                         | 626.68               | 
| Content State Read    | 100          | 9281923       | 20          | 381.40   | 335                         | 1447.88                     | 321.30               | 
| Content State Update  | 100          | 8645899       | 4872        | 409.69   | 408                         | 1586.97                     | 299.29               | 
| Create User NodeBB    | 100          | 8166771       | 4           | 434.42   | 146                         | 258                         | 282.70               | 
| Enrollement List      | 100          | 5432206       | 187         | 653.22   | 1096.90                     | 2907                        | 188.04               | 
| LatestDiscussion      | 100          | 5497186       | 3           | 645.59   | 267                         | 484                         | 190.29               | 
| Recommended Connection| 100          | 3939967       | 3           | 901.54   | 271                         | 785.96                      | 136.39               |
| Send Telemetry        | 100          | 34939561      | 1           | 100.09   | 26                          | 37                          | 1209.47              |

**4. Discussion Hub Individual API benchmarking** 

>**Kubernetes**

* Ran internally with in azure with Redis implementation.

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time| Throughput (req/sec) | 
|----------------------|--------------|---------------|-------------|----------|----------|----------|----------------------| 
| Create Discussion    | 100          | 100000        | 9           | 67.02    | 241      | 445.99   | 1306.57              | 
| Reply to Topic       | 100          | 100000        | 413         | 93.25    | 315      | 1627.99  | 964.83               | 
| Topic Read           | 100          | 1000          | 0           | 1251.66  | 3144.95  | 4249.75  | 67.89                | 
| up Vote              | 100          | 10000         | 0           | 28.47    | 46       | 199      | 828.43               | 
| Down Vote            | 100          | 10000         | 0           | 32.33    | 52.95    | 280.99   | 759.47               | 



* Ran Externally from AWS to Azure with Redis implementation.

| API            | Thread Count | No of Samples | Error Count | Avg (ms) | 95 percentile response time | 99 percentile response time| Throughput (req/sec) | 
|----------------------|--------------|---------------|-------------|----------|----------|----------|----------------------| 
| Create Discussion    | 100          | 100000        | 0           | 107.99   | 186      | 328      | 705.51               | 
| Reply to Topic       | 100          | 100000        | 0           | 108.62   | 206      | 428.98   | 820.62               | 
| up Vote              | 100          | 100000        | 0           | 86.27    | 176      | 368.9    | 1011.39              | 
| Down Vote            | 100          | 100000        | 3236        | 84.45    | 126      | 355.99   | 938.89               | 
