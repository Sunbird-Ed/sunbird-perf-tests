**Note:**

To run these soaktest APIs jmx scripts following jars needs to be placed into JMeter’s lib/ext directory. Download the JMeter Plugins Manager JAR files from the given link and then put it into JMeter's lib/ext directory.

1. jmeter-plugins-cmn-jmeter-0.6.jar 
  - Download from https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-cmn-jmeter/0.6/
2. jmeter-plugins-casutg-2.9.jar
  - Download from https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-casutg/2.9/


1. ## Sokatest with HPA Enabled - Test run with DNS Name

- **AKS Node:** Min no of nodes - 8 and Max no of nodes - 40 
- **HPA with 70% CPU Usage**
- **TPS: 19926 (with 27 AKS nodes)**
- **Release 4.1.0**

**Service Pods configuration & Usage:**
| Service Name | CPU Limit(Core)| Memory Limit | Min Pods | Max Pods | Pod Usage |CPU Utilization(Max) %|
|--------------|----------|--------------|----------|----------|----------|----------|
|Analytics     |  0.8     |    2.5G      |   2      |     6     |3|89|
|API Manager   |    2     |   2.5G        |   2      |     30    |11|87|
|AdminUtils    |    1     |     2G        |   1      |     6     |6|100|
|Content       |   1      |   3.5G        |   1     |     12     |1| 19|
|Knowledgemw   |   1      |   1.5G        |   2      |     10     |4|100|
|Learner       |   1      |     3G        |    2    |     40     | 40|100|
|LMS           |   1      |     3G        |    2    |     30     |17| 100|
|Player        |    1     |     1G        |    1     |    16     |3|75|
|Nginx-private-ingress    |    0.2 |   0.3G  |   2   |     6     |2|4|
|Search        |   1      |   3G          |    1     |    10     |2|90|
|Telemetry     |   0.8    |   1G          |     2    |    40     |27|100|


**Infra Configuration & Usage:**
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
- cluster1.jmx (1 JMeter Master, 4 JMeter Slaves)
  - ```sendTelemetry```
  - ```readContent```
  - ```searchContent```
  - ```readForm```
  - ```getCourseHierarchy```
  - ```dialAssemble``` 
- learner.jmx (1 JMeter Master, 4 JMeter Slaves)
  - ```getUserProfileV3```
  - ```getUserProfileV2``` 
  - ```getUserProfile```
  - ```searchManagedUser```
  - ```userFeed```
  - ```readUserConsent```
  - ```updateUserConsent```
  - ```updateUser```
  - ```searchUser```
- lms.jmx (1 JMeter Master, 4 JMeter Slaves)
  - ```readContentState```
  - ```updateContentState```
  - ```istCourseEnrollments```
  - ```getBatch```
  - ```searchCourseBatches```
- ananlytics.jmx (1 JMeter Master, 2 JMeter Slaves)
  - ```deviceRegister```
  - ```deviceProfile```
  - ```registerMobileDevicev2```
- login.jmx (1 JMeter Master)
  - ```login scenario```
