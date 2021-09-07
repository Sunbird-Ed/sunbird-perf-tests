**Note:**

To run these soaktest APIs jmx scripts following jars needs to be placed into JMeter’s lib/ext directory. Download the JMeter Plugins Manager JAR files from the given link and then put it into JMeter's lib/ext directory.

1. jmeter-plugins-cmn-jmeter-0.6.jar 
  - Download from https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-cmn-jmeter/0.6/
2. jmeter-plugins-casutg-2.9.jar
  - Download from https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-casutg/2.9/
----------

1. ## Sokatest with HPA Enabled - Test run with DNS Name

- **AKS Cluster Autoscaler configuration:** Min no of nodes - 8 and Max no of nodes - 40 
- **HPA threshold: 70% CPU**
- **Transactions per second: 19926**
- **Max no of AKS node used: 27**
- **Release version: Release-4.1.0**

**Service Pods configuration & Usage:**
| Service Name | CPU Limit(Core)| Memory Limit |HPA Min Pods | HPA Max Pods | Max Pods Used |CPU Utilization(Max) %|
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
|AKS Node      | 8 Core, 16GB |    85.18%  |     40.85     |7.44 GB|
|Cassandra    | 5 Node (16 Core , 64GB) |    76.77%    |  40.80    |13.136 GB |
|ES-LMS       | 3 nodes (16core , 64GB) |   33.22%   |  8.66  |28.5714 GB |
|COMP-LMS     | 3 nodes (16core, 32 GB) |   22.01%   |   5.95    |19.6741 GB |
|Kafka        | 3 nodes (4core , 16GB)  |    52.43%   |  3.85     |9.397 GB  |
|Redis - LP   | 1 node (2core, 8GB)     |    0.57%  |   0.25   |2.52581 GB |
|Redis -DP    | 1 node (32core, 128GB)  |    2.91%   |     0.75  |39.47 GB|
|KeyCloak     | 4 nodes (4core, 16GB)   |  99.85%  |  21.71    | 3.760 GB  |

**API wise TPS:**

| API Name | Throughput| Error % | Avg. Response Time |95th pct| 99th pct |
|--------------|----------|--------------|----------|----------|-------|
|deviceProfile|	327.86|	0.00%|	5.58	|6|	14|
|deviceRegister|	163.41|	0.00%|	6.81|	7	|16|
|dialAssemble| 96.8| 0.00%| 55.89|70 |91 |
|getCourseHierarchy|125.22 |0.00% | 2.6|3 |12 |
|getUserProfile|	156.85|	0.00%|	80.11|	85|	110|
|getUserProfileV2|	156.84|	0.00%|	80.16|	85|	108.99|
|getUserProfileV3|	2440.53|	0.00%|	71.61|	21|	30|
|getBatch|	133.77|	0.00%|	1.33|	2|	11|
|listCourseEnrollments|	265.92|	0.00%|	744.91|	104|	146|
|readContentState|1103.79|	0.00%	|96.43|	10|	16|
|readContent|	213.23|	0.00%|	5.97|	2|	11|
|readForm	|88.43|	0.02%|	203.97|	100	|4946|
|registerMobileDevicev2|	161.53|	0.00%|	20.83|	7	|17|
|searchContent|	211.25|	0.03%|	12.61|	22|	58|
|sendTelemetry|	5409.17|0.00%|	44.16	|8|	19|
|searchManagedUser|	214.48|	0.00%|	615.92|	360|	503.99|
|searchUser|	161.19|	0.00%	|45.55|	72|	96|
|searchCourseBatches|	158.95|	0.00%|	63.31|	68|	97|
|updateUser|	158.93|	0.00%|	63.35|	82|	107|
|updateUserConsent|	159.56|	0.00%|	58.31|	83|	108|
|userFeed|	524.68|	0.00%|	32.12|	46|	73|
|updateContentState|	1020.72|	0.00%|	116.24|	20|	37|
|login| 278.94| 0.00%| 	95.49|120.00 |	155.00 |

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
