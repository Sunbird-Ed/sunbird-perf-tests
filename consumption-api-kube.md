##  Consumption APIs Benchmarking

#### Jmeter Cluster
For benchmarking the APIs, one Jmeter cluster (1 master + 8 slaves in) were setup to perform API testing and verifying improvements in parallel.

### APIs Invoked in this benchmarking

| TR1 | TR2 | TR3 |
|-----|-----|-----|

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

#### Kubernetes
| TR1 | TR2 | TR3 |
|-----|-----|-----|

#### Docker
| TR1 | TR2 | TR3 |
|-----|-----|-----|

**2. Individual API benchmarking via Proxy and API Manager**
* Proxy was setup to run as NodePort in kubernetes
* API manager was setup to run as ClusterIP
* Separate database was created with FQDN of internal service names for API Manager

#### Kubernetes
| TR1 | TR2 | TR3 |
|-----|-----|-----|

#### Docker
| TR1 | TR2 | TR3 |
|-----|-----|-----|

**3. Benchmarking 8 commonly used API's during consumption via Proxy and API Manager**
* Number of threads - 600

#### Kubernetes
| TR1 | TR2 | TR3 |
|-----|-----|-----|

#### Docker
| TR1 | TR2 | TR3 |
|-----|-----|-----|


**4. Benchmarking 9 commonly used API's during consumption via Proxy and API Manager**

#### Kubernetes
| TR1 | TR2 | TR3 |
|-----|-----|-----|

#### Docker
| TR1 | TR2 | TR3 |
|-----|-----|-----|


**5. Benchmarking 9 commonly used API's during consumption via Proxy and API Manager (Long Running Test)**
* Duration of run - 2h 10m

#### Kubernetes
| TR1 | TR2 | TR3 |
|-----|-----|-----|


**6. API reponse times of the 9 commonly used API's during consumption**
* All response times are in milliseconds

#### Kubernetes
| TR1 | TR2 | TR3 |
|-----|-----|-----|

#### Docker
| TR1 | TR2 | TR3 |
|-----|-----|-----|
