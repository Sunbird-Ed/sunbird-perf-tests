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
  * In AKS, Azure CNI networking was used
  * A subnet with a CIDR /22 in the VNET was created for AKS cluster
  * In Azure CNI, every pod gets a IP directly from the subnet
  * There is no NAT between Kubernetes pods and nodes (Kubernetes nodes / External nodes)
  * You will be able to directly connect to the pod using the pod ip
  * If you inspect the traffic from / to pods, you will see the IP of the pod as source / destination and not the node in which it is running
  * For more information on Azure CNI, please visit - https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni
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
  * In docker we onboard API's by using the docker service names.
  * Kong can directly access the upstream services by using the docker service names. 
  * This is possible because in docker swarm, the service name itself is the FQDN.
  * In kubernetes, the service name is an alias for which a dns search must be performed in order to get the FQDN. 
  * Due to a limitation in Kong 10 which cannot do a DNS search using the resolv.conf and ndots, using the service names results in a host not found error.
  * Hence we have to onboard the API's using FQDN in kubernetes
  * A FQDN service name in kubernetes looks like - ***service-name.namespace.svc.cluster.local***

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



**4. Benchmarking 8 commonly used API's during consumption via Proxy and API Manager (Long Running Test)**
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
