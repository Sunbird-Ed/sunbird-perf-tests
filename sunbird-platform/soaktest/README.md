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




2. ## Sokatest with HPA Enabled ##

AKS Node: Min -6 and AMx - 40 

| Service Name | CPU Limit| Memory Limit | Min Pods | Max Pods |
|--------------|----------|--------------|----------|----------|
|Analytics    |     |     |             |           |          |
|API Manager    |     |     |             |           |          |
|AdminUtils    |     |     |             |           |          |
|Content   |     |     |             |           |          |
|Learner   |     |     |             |           |          |
|LMS  |     |     |             |           |          |
|Player    |     |     |             |           |          |
|Nginx-private-ingress    |     |     |             |           |          |
|Telemetry    |     |     |             |           |          |


**Infra Configuration**
| Service Name | Configuration| CPU Usage | Load AVG |
|--------------|----------|--------------|----------|
|Cassandra    |          |              |          |
|ES-LMS       |          |              |          |
|COMP-LMS     |          |              |          |
|KAFKA        |          |              |          |
|Redis - LP   |          |              |          |
|Redis -DP    |          |              |          |
|KeyCloak|    |          |              |          |



