1. ## Soatest Scripts Deatils - Cluster wise ##

Cluster 1 - sokatest-autoscale-cluster1.jmx
- telemetry 
- readContent 
- readForm
- readFramework


Cluster 2 - sokatest-autoscale-cluster2.jmx
- Content V1 Search
- OrgSearch
- ContentHierarchy
- TenantInfo 

Cluster 3 - sokatest-autoscale-cluster3.jmx
- Get User Profile V3
- Get User Profile V2
- Get User Profile V1
- Search Managed User 
- User Feed Read

Cluster 4 - lms-apis.jmx
- readContentState
- updateContentState
- listCourseEnrollments
- getBatch 
- searchCourseBatches 

Cluster 5 -analytics.jmx
- Device Register
- Device Profile
- Register Mobile Devicev2

**NOTE:**

To run these scripts following jars needs to be placed into JMeter’s lib/ext directory. Download the JMeter Plugins Manager JAR files from the given link and then put it into JMeter's lib/ext directory.

1. jmeter-plugins-cmn-jmeter-0.6.jar 
  - Download from https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-cmn-jmeter/0.6/
2. jmeter-plugins-casutg-2.9.jar
  - Download from https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-casutg/2.9/




2. ## Sokatest with HPA Enabled - 25K TPS ##

- **AKS Node:** Min no of nodes - 6 and Max no of nodes - 40 
- **HPA with 70% CPU Usage**
- **TPS: 25138 (with 27 AKS nodes)**	

| Service Name | CPU Limit| Memory Limit | Min Pods | Max Pods | Pod Usage |CPU Utilization(Max) %|
|--------------|----------|--------------|----------|----------|----------|----------|
|Analytics     |  0.8     |    2.5       |   2      |     6     |3|94|
|API Manager   |    2     |   2.5        |   2      |     30    |14|90|
|AdminUtils    |    1     |     2        |   1      |     6     |4|73|
|Content       |   1      |   3.5        |   1     |     12     |1| 15|
|Knowledgemw   |   1      |   1.5        |   2      |     10     |4|99|
|Learner       |   1      |     3        |    2    |     40     | 40|100|
|LMS           |   1      |     3        |    2    |     30     |17| 100|
|Player        |    1     |     1        |    1     |    16     |2|9|
|Nginx-private-ingress    |    0.2 |   0.3  |   2   |     6     |2|4|
|Search        |   1      |   3          |    1     |    10     |3|99|
|Telemetry     |   0.8    |   1          |     2    |    40     |40|100|


**Infra Configuration**
| Service Name | Configuration| CPU Usage (Max) | Load AVG(Max) |Memory Usage(Max) |
|--------------|----------|--------------|----------|----------|
|AKS Node      | 8 Core, 16GB |    80.72%  |     37.97     |6.500 GB|
|Cassandra    | 5 Node (16 Core , 64GB) |   75.23%   |  46.67   |13.505 GB|
|ES-LMS       | 3 nodes (16core , 64GB) |   35.59%   |  11.43   |28.5080 GB|
|COMP-LMS     | 3 nodes (16core, 32 GB) |   30.86%   |  7.11    |19.6606 GB|
|Kafka        | 3 nodes (4core , 16GB)  |   58.19%   |  5.17    |9.645 GB|
|Redis - LP   | 1 node (2core, 8GB)     |    2.64%   |  0.23    |2.3 GB|
|Redis -DP    | 1 node (32core, 128GB)  |    0.78%   |    0.3   |46.2 GB|
|KeyCloak     | 4 nodes (4core, 16GB)   |   98.49%   |  11.24   | 7.520 GB |

**JMX Details**
- cluster1.jmx
  - sendTelemetry
  - readContent 
  - searchContent
  - readForm
  - getCourseHierarchy
  - dialAssemble
- leraner.jmx
  - getUserProfileV3
  - getUserProfileV2 
  - getUserProfile
  - searchManagedUser
  - userFeed
  - readUserConsent
  - updateUserConsent
  - updateUser
  - searchUser
- lms.jmx
  - readContentState 
  - updateContentState
  - listCourseEnrollments
  - getBatch
  - searchCourseBatches
- ananlytics.jmx
  - deviceRegister
  - deviceProfile
  - registerMobileDevicev2
- login.jmx
  - login scenario

