# sunbird-perf-tests
Data preparation scripts, JMX files, JMeter scripts for performance testing


Please refer this section on [Installation Details](#installation-details). This will give you details on how to setup jmeter on your machines and run the benchmarking scenarios against your infrastructure.

# Perf testing summary

### **Environment Details**

A new environment was created for this test. Here are the VMs and their configurations from the test.

![Infra View](https://github.com/Sunbird-Ed/sunbird-perf-tests/blob/master/images/LoadTestInfra.jpg)

3 Jmeter clusters (1 master + 4 slaves in each cluster) were setup to perform API testing and verifying improvements in parallel.

### **Test Results**

**1. Individual API benchmarks**

* These were captured after optimizations were applied to the individual APIs.
  * Introduced redis caching for read APIs. The API would fetch from the system of record for a cache miss
  * Configured different AKKA dispatchers for key APIs
  * Configured the dispatcher configuration to optimize for throughput  
* The tests were done with different server counts to establish that the API can scale horizontally. 
* Empty values for various server counts imply that the data capture was abandoned if the objective of the test was achieved from a single test.
* Each API was invoked directly without going through the proxy &amp; API manager.
* Each API test was run for atleast 15 mins

| **API** | **1 Server (Throughput/sec @ avg resp time )** | **2 Servers (Throughput/sec @ avg resp time)** | **3 Servers (Throughput/sec @ avg resp time )** |
| --- | --- | --- | --- |
| content/v1/read | 2459.7 @ 92 | 4560.4 @ 45 |   | 
| course/v1/hierarchy | 959.5 @ 241 | 1642.2 @ 119 |    |
| framework/v1/read | 2153 @ 38 | 3604 @ 20 |   |
| channel/v1/read | 1247.3 @ 182 | 1681.7 @ 123 |   |
| content/v1/search | 899.6 @ 261 | 1592.1 @ 125 |
| data/v1/telemetry | 285.3 @ 389 | 497 @ 211 |
| device/v3/register | 536.1 @ 426 | 923.9 @ 228 |   |
| org/v1/search | 553.6 @ 398 | 874.4 @ 238 |   |
| data/v1/form/read | 386.9 @ 582  | 764.1 @ 281 |   |
| /v1/tenant/info | 779.2 @ 275  | 1460.1 @ 133 |   |
| /data/v1/page/assemble | 443.8 @ 506 | 449.1 @ 500 |   |

**2. APIs being invoked in sequence via Proxy &amp; API Manager**

* All times are in millisecond
* Test duration was 36 minutes
* The proxy was invoked via the intranet with Jmeter servers running in the same network
* Number of threads - 600
* Number of replicas for the test - 8 Proxy, 4 Kong, 6 Content Service, 6 Learner Service, 6 Telemetry Service, 2 Knowledge Platform servers, 2 Search servers


| **API** | **Samples** | **Error Count** | **Avg Response Time** | **95 percentile response time** | **99 percentile response time** | **Throughput (req/sec)** |
| --- | --- | --- | --- | --- | --- | --- |
| ContentRead | 180000 | 0 | 981.77 | 2171.95 | 3161.00 | 82.59 |
| PageAssemble | 180000 | 0 | 963.76 | 2158.00 | 3156.00 | 82.59 |
| DialSearch | 180000 | 0 | 912.69 | 2136.00 | 3157.00 | 82.56 |
| FormRead | 180000 | 0 | 622.08 | 2048.00 | 3063.99 | 82.55 |
| OrgSearch | 180000 | 2 | 869.24 | 2111.00 | 3131.99 | 82.48 |
| SendTelemetry | 180000 | 0 | 607.84 | 2064.00 | 3075.00 | 82.47 |
| TenantInfo | 180000 | 0 | 55.21 | 95.00 | 1048.00 | 82.48 |
| ContentHierarchy | 180000 | 0 | 1082.27 | 2242.00 | 3219.98 | 82.59 |

> **Result Analysis &amp; findings**
>
> The above results were not very encouraging and we analyzed further to discover the following issues
>
> * Proxy was using http 1.0 instead of http 1.1 to connect to upstream systems. Http 1.0 does not support keep alive connections
> * All the sub systems (content service, api manager, learner service, proxy) were creating a new>  connection for every service call.
> * Options calls were not handled by the proxy and would go all the way to the actual service
> * Some of the services were logging too much information which was useless and this was causing performance issues

**3 APIs being invoked in sequence via Proxy &amp; API Manager (after optimization)**

* All times are in millisecond
* Test duration was 22 minutes
* The proxy was invoked via the intranet with Jmeter servers running in the same network
* Number of threads - 600
* Number of replicas for the test - 8 Proxy, 4 Kong, 6 Content Service, 6 Learner Service, 6 Telemetry Service, 2 Knowledge Platform servers, 2 Search servers
 
| **API** | **Samples** | **Error Count** | **Avg Response Time** | **95 percentile response time** | **99 percentile response time** | **Throughput (req/sec)** |
| --- | --- | --- | --- | --- | --- | --- |
| ContentRead | 360000 | 0 | 421.29 | 1263.00 | 1810.97 | 279.30 |
| PageAssemble | 360000 | 0 | 283.20 | 794.00 | 1270.97 | 279.30 |
| DialSearch | 360000 | 0 | 301.07 | 956.00 | 1364.99 | 279.31 |
| FormRead | 360000 | 0 | 92.02 | 212.00 | 444.99 | 279.32 |
| OrgSearch | 360000 | 1 | 86.14 | 181.00 | 337.99 | 279.32 |
| SendTelemetry | 360000 | 0 | 142.74 | 310.00 | 639.00 | 279.32 |
| TenantInfo | 360000 | 0 | 35.24 | 113.00 | 205.99 | 279.32 |
| ContentHierarchy | 360000 | 0 | 632.79 | 1789.95 | 2420.99 | 279.28 |

> Optimizations done
>
>* Content service was closing client connections explicitly and not using keep alive to invoke knowledge platform. These issues were fixed with 3-4 lines of code changes
>* The proxy was not using keep alive connections to upstreams - portal &amp; api manager. This was fixed in the portal through a configuration change to also move from http 1.0 to http 1.1
>* We were using Kong 0.9 as our API manager and this version did not support keep alive connections. We had to upgrade to Kong 0.10 to enable keep alive connections from Kong to content-service, portal, telemetry and learner service.
>* Proxy rules were updated to respond to OPTIONS call without forwarding the request to the upstream service
>* We increased the configured memory from 750 MB to 1 GB for content service as this improved the throughput
>* On upgrading to Kong 0.10, we started getting occasional timeouts for upstream services  and this was resolved by doing the following
>   * We figured out that Play framework (Learner service, Play 2.4.x) does not close connections for close to an hour and Kong connections to play framework timeout after 15 mins because of IPVS default timeout of 15 mins. There was no way in docker swarm to change this timeout and so we ended up using the tasks.service endpoint for play applications. While using this endpoint, it skips the IPVS layer and thus the timeout is avoided.
>   * The NodeJS applications kill the idle socket by default every 5 seconds. This was leading to race conditions where Kong would send a new request while the socket was being closed by NodeJS. This was resolved by increasing the idle timeout to 5 mins for all inter swarm communication.

 **4 Benchmarking the APIs after increasing the replicas of proxy, content service &amp; api manager (Long running test)**

 * All times are in millisecond
 * Test duration was 9 hours &amp; 20 mins
 * The proxy was invoked via the intranet with Jmeter servers running in the same network
 * Number of threads - 600
 * Number of replicas for the test - 10 Proxy, 6 Kong, 8 Content Service, 6 Learner Service, 6 Telemetry Service, 2 Knowledge Platform servers, 2 Search servers

| **API** | **Samples** | **Error Count** | **Avg Response Time** | **95 percentile response time** | **99 percentile response time** | **Throughput (req/sec)** |
| --- | --- | --- | --- | --- | --- | --- |
| ContentHierarchy | 12000000 | 2 | 370.13 | 251.00 | 407.00 | 353.94 |
| ContentRead | 12000000 | 0 | 182.96 | 116.00 | 198.00 | 353.94 |
| DialAssemble | 12000000 | 10 | 279.11 | 169.00 | 251.00 | 353.94 |
| DialSearch | 12000000 | 1 | 207.79 | 124.95 | 202.00 | 353.94 |
| FormRead | 12000000 | 269 | 272.33 | 663.95 | 1185.99 | 353.94 |
| OrgSearch | 12000000 | 9 | 84.38 | 75.00 | 133.99 | 353.94 |
| SendTelemetry | 12000000 | 72 | 200.59 | 273.00 | 415.99 | 353.94 |
| TenantInfo | 12000000 | 12 | 89.97 | 408.00 | 639.99 | 353.94 |


**5 Benchmarking the APIs in the ratio that is seen in a Sunbird production environment**

 * All times are in millisecond
 * Test duration was 58 minutes
 * The proxy was invoked via the intranet with Jmeter servers running in the same network
 * Number of threads - 600
 * Number of replicas for the test - 10 Proxy, 6 Kong, 8 Content Service, 6 Learner Service, 6 Telemetry Service, 2 Knowledge Platform, 2 Search

| **API** | **Samples** | **Error Count** | **Avg Response Time** | **95 percentile response time** | **99 percentile response time** | **Throughput (req/sec)** |
| --- | --- | --- | --- | --- | --- | --- |
| CompositeSearch | 840000 | 0 | 260.81 | 1277.90 | 2940.99 | 244.13 |
| ContentHierarchy | 420000 | 0 | 370.66 | 1822.80 | 3285.99 | 122.07 |
| ContentRead | 1680000 | 0 | 545.15 | 1668.00 | 2956.97 | 488.23 |
| DialAssemble | 420000 | 1 | 253.57 | 639.00 | 946.99 | 122.09 |
| DialSearch | 420000 | 0 | 186.57 | 414.00 | 643.99 | 122.09 |
| FormRead | 420000 | 0 | 92.92 | 346.95 | 1596.98 | 122.09 |
| OrgSearch | 420000 | 1 | 292.84 | 1096.95 | 2590.97 | 122.09 |
| SendTelemetry | 1260000 | 0 | 278.62 | 346.00 | 605.99 | 366.25 |
| TenantInfo | 420000 | 0 | 34.06 | 83.00 | 212.00 | 122.09 |


**6 Benchmarking the APIs via Internet**

 * All times are in millisecond
 * Test duration was 29 mins on AWS and 33 mins on Azure
 * Number of threads - 600
 * The APIs were invoked using 15 jmeter slaves (7 from AWS + 8 from Azure) via the domain name - loadtest.ntp.net.in
 * Number of replicas for the test - 10 Proxy, 6 Kong, 8 Content Service, 6 Learner Service, 6 Telemetry Service, 2 Knowledge Platform, 2 Search

**AWS Load generator summary (8 VMs)**

| **API** | **Samples** | **Error Count** | **Avg Response Time** | **95 percentile response time** | **99 percentile response time** | **Throughput (req/sec)** |
| --- | --- | --- | --- | --- | --- | --- |
| ContentHierarchy | 320000 | 0 | 280.80 | 514.00 | 906.95 | 191.24 |
| ContentRead | 320000 | 0 | 197.82 | 347.00 | 565.99 | 191.33 |
| DialAssemble | 320000 | 0 | 254.36 | 361.00 | 489.00 | 191.32 |
| DialSearch | 320000 | 0 | 208.91 | 294.00 | 426.98 | 191.33 |
| FormRead | 320000 | 21 | 253.41 | 2663.95 | 3123.00 | 191.33 |
| OrgSearch | 320000 | 0 | 89.36 | 244.00 | 332.00 | 191.33 |
| SendTelemetry | 320000 | 0 | 282.24 | 475.95 | 912.94 | 191.33 |
| TenantInfo | 320000 | 2 | 69.31 | 166.00 | 229.00 | 191.33 |

**Azure Load Generator summary (8 VM)**

| **API** | **Samples** | **Error Count** | **Avg Response Time** | **95 percentile response time** | **99 percentile response time** | **Throughput (req/sec)** |
| --- | --- | --- | --- | --- | --- | --- |
| ContentHierarchy | 320000 | 0 | 236.78 | 200.00 | 1071.99 | 161.80 |
| ContentRead | 320000 | 0 | 232.05 | 1069.00 | 1122.00 | 161.80 |
| DialAssemble | 320000 | 2 | 254.78 | 178.00 | 1131.00 | 161.80 |
| DialSearch | 320000 | 0 | 231.48 | 1074.00 | 1134.00 | 161.80 |
| FormRead | 320000 | 7 | 250.82 | 760.00 | 1113.99 | 161.81 |
| OrgSearch | 320000 | 1 | 113.96 | 1074.95 | 1130.00 | 161.81 |
| SendTelemetry | 320000 | 0 | 241.08 | 245.00 | 1116.99 | 161.81 |
| TenantInfo | 320000 | 0 | 117.49 | 1075.00 | 1099.00 | 161.81 |

> **Overall we got a throughput close to the test run via intranet**

**7 Benchmarking the difference with invoking the knowledge platform APIs directly vs via proxy, api manager and content service**

 * Number of threads - 600
 * All times are in millisecond
 * The proxy was invoked via the intranet with Jmeter servers running in the same network
 * Number of replicas for the test - 10 Proxy, 6 Kong, 8 Content Service, 6 Learner Service, 6 Telemetry Service, 2 Knowledge Platform servers, 2 Search servers

| **API** | **Samples** | **Error Count** | **95 percentile response time** | **99 percentile response time** | **Throughput (req/sec)** |
| --- | --- | --- | --- | --- | --- |
| ContentRead (Direct KP) | 3000000 | 0 | 73 | 135 | 4600 |
| ContentRead (2 swarm, via Proxy) | 540000 | 46 | 261 | 1098 | 2100 |
| ContentHierarchy (Direct KP) | 900000 | 0 | 565 | 1184 | 1698 |
| ContentHierarchy (2 swarm, via Proxy) | 900000 | 0 | 1195 | 1869 | 1043 |

**8 Benchmarking the proxy calls to blob storage for plugins &amp; assets**

**(NOT Yet Production Ready)**

| **Static Content Calls** **(Proxied via our Nginx)** | **Samples** | **Error Count** | **Avg Response Time** | **95 percentile response time** | **99 percentile response time** | **Throughput (req/sec)** |
| --- | --- | --- | --- | --- | --- | --- |
| Without Upstream + HTTPS  (Current Production) | 600000 | 212 | 494 | 190 | 1030 | 1046 |
| With Upstream + HTTP  (Proposed) | 1200000 | 62 | 138 | 66 | 95 | 2300 |


## Installation Details

#### Jmeter machine requirements
* At least 2 core, 4GB RAM, Ubuntu 16.04
* Port 1099 to be open between master and slaves for jmeter to communicate if two machines are used.

#### Jmeter setup on master
_Note: Same user must be present on both master and slave since we will be copying the files folder under ~ directory. The script can be changd to install the files and folder under a common location like /mount which will be availble on both systems. In this case the user name will not matter._

1. Clone this repo on your jmeter master machine by running 
2. **git clone https://github.com/Sunbird-Ed/sunbird-perf-tests**
3. **cd sunbird-perf-tests/initial-setup**
4. **./setup_jmeter.sh**
5. Follow the onscreen instructions and provide input for the script.

The scenarios and jmeter binary will be installed in the current user's home directory.

#### Details on csv input data for jmeter scenarios

**bearer.csv**

In this file, enter the jwt bearer key of your sunbird installation.

**channel.csv**

In this file, enter the channel id's from your sunbird installation.

**collections.csv**

In this file, enter the do_id's of collections from your sunbird installation.

**content.csv**

In this file, enter the do_id's (content id's) from your sunbird installation.

**dialcodes.csv**

In this file, enter the dial codes (QR codes) of contents from your sunbird installation.

**frameworks.csv**

In this file, enter the framework id's from your sunbird installation.

**orgs.csv**

In this file, enter the org id's from your sunbird installation. 

**tenants.csv**

In this file, enter the tenant id's from your sunbird installation. 

**urls.csv**

In this file, enter the IP's of your machines or your sunbird domain.




#### Details on variables used in jmeter scenario files

**THREADS_COUNT**

This defines the number of threads for the scenario under execution

**RAMPUP_TIME**

This defines the ramp up time for the scenario under exectuion

**CTRL_LOOPS**

This defines the number of loops that the scenario should run

**PROTOCOL**

This is the protocol used to connect to your sunbird installation (http / https). If your domain has SSL certificate, use https. If not use http.

**PORT**

This defines the port which should be used for connecting to your sunbird installtion. It can be 443, 8080, 9000 etc. Please see examples below to understand this better.

**DATADIR**

This defines the path where your data directory resides. By default this is ~/benchmark/testdata



#### Jmeter setup on slaves (If using more than one jmeter machine)
1. Copy the ~/benchmark/apache-jmeter-4.0 and ~/benchmark/testdata directory from your jmeter master to jmeter slaves
2. **`mkdir ~/benchmark && scp -r username@jmeter_master:~/benchmark/\{apache-jmeter-4.0,testdata\} ~/benchmark/`**


#### Starting jmeter server on master and slaves
1. Start the jmeter server by using below command on the master and all slaves.
2. **nohup ~/benchmark/apache-jmeter-4.0/bin/jmeter-server &**


#### Few points to be noted
1. The **jmeter-server** must be running on master and slaves before starting the tests.
2. The testdata directory must be present under ~/benchmark/ in master and all slaves.
3. If there is a change in the csv files, this should be copied to all servers in the jmeter cluster.
4. The scenario files can reside only in master and it need not be present in slaves.
5. If there are connection issues while starting the run, kill and restart the **jmeter-server** process on the machines where the issue exists.
6. If there are connection issues or you want to stop a scenario test which is currently running, use the command **~/benchmark/apache-jmeter-4.0/bin/stoptest.sh** on the master. This will notifiy the slaves and stop the current running test.
7. All the CSV files needs to be updated with contents before starting the test.
8. All scenarios can be run using a single jmeter server.


#### Running the scenarios

**1. SoakTest.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * ContentHierarchy
  * ContentRead
  * ContentSearch
  * FormRead
  * OrgSearch
  * DeviceRegister
  * Telemetry
  * PageAssemble
  * TenantInfo

Ensure you have updated the csv files with contents and also copied on all the jmeter machines under **jmeter_installation_path/testdata**. This scenario uses the following csv files:
  * content.csv
  * collections.csv
  * dialcodes.csv
  * orgs.csv
  * tenants.csv
  * urls.csv
  * bearer.csv
  
For this scenario, we need to enter the domain name (without http:// or https://) in the urls.csv. The port to enter is 443 in case of https and 80 in case of http.

To run the scenario, switch to **jmeter_installation_path/scripts**. In this directory a file name **run_scenario.sh** will be present. This script takes 7 arguments. The order and the list of parameters required for this script are as below:
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * Protocol - http / https
  * Port number
  * JMX file name you would like to run. Provide only file name. Check scenarios directory for file names.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh SoakTest 10 5 30 https 443 SoakTest.jmx`

**2. ChannelRead.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * ChannelRead

This scenario uses the following csv files:
  * channels.csv
  * urls.csv
  
For this scenario, we need to enter the IP or load balancer IP of the KnowledgePlatform **learning** machine in the urls.csv. Here we are directly invoking the learning machine / learning LB which is running on port 8080. The protocal is http here since we are making an internal call.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh ChannelRead 10 5 30 http 8080 ChannelRead.jmx`

**3. ContentRead.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * ContentRead

This scenario uses the following csv files:
  * content.csv
  * urls.csv
  
Here we will be directly invoking the learning machine / learning LB.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh ContentRead 10 5 30 http 8080 ContentRead.jmx`


**4. ContentHierarchy.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * ContentHierarchy

This scenario uses the following csv files:
  * collections.csv
  * urls.csv
  
Here we will be directly invoking the learning machine / learning LB.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh ContentHierarchy 10 5 30 http 8080 ContentHierarchy.jmx`


**5. FrameWorkRead.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * FrameWorkRead

This scenario uses the following csv files:
  * frameworks.csv
  * urls.csv
  
Here we will be directly invoking the learning machine / learning LB.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh FrameWorkRead 10 5 30 http 8080 FrameWorkRead.jmx`


**6. ContentSearch.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * ContentSearch

This scenario uses the following csv files:
  * dialcodes.csv
  * urls.csv
  
For this scenario, we need to enter the IP or load balancer IP of the KnowledgePlatform **search** machine in the urls.csv. Here we are directly invoking the search machine / search LB which is running on port 9000. The protocal is http here since we are making an internal call.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh ContentSearch 10 5 30 http 9000 ContentSearch.jmx`


**7. FormRead.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * FormRead

This scenario uses the following csv files:
  * urls.csv
  
For this scenario, we need to enter the IP of the docker agents or swarm load balancer IP in the urls.csv. Here we are directly invoking the player service on port 3000. The protocal is http here since we are making an internal call.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh FormRead 10 5 30 http 3000 FormRead.jmx`


**8. TenantInfo.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * TenantInfo

This scenario uses the following csv files:
  * urls.csv
  * tenants.csv
  
Here we will be directly invoking the player service.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh TenantInfo 10 5 30 http 3000 TenantInfo.jmx`

**9. PageAssemble.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * PageAssemble

This scenario uses the following csv files:
  * urls.csv
  * dialcodes.csv
  
For this scenario, we need to enter the IP of the docker agents or swarm load balancer IP in the urls.csv. Here we are directly invoking the learner service on port 9000. The protocal is http here since we are making an internal call.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh PageAssemble 10 5 30 http 9000 PageAssemble.jmx`


**10. OrgSearch.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * OrgSearch

This scenario uses the following csv files:
  * urls.csv
  * orgs.csv
  
Here we will be directly invoking the learner service.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh OrgSearch 10 5 30 http 9000 OrgSearch.jmx`


**11. Telemetry.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * Telemetry

This scenario uses the following csv files:
  * urls.csv

This file also uses **telemetry_events.json.gz**. This contains the telemetry payload in json format. We have compressed it in gzip format to reduce the transfer size. You need not modify this file.
  
For this scenario, we need to enter the IP of the docker agents or swarm load balancer IP in the urls.csv. Here we are directly invoking the telemetry service on port 9001. The protocal is http here since we are making an internal call.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh Telemetry 10 5 30 http 9001 Telemetry.jmx`


**12. DeviceRegister.jmx**

This scenario file contains the following API's which will be invoked as part of the run
  * DeviceRegister

This scenario uses the following csv files:
  * urls.csv
  * bearer.csv
  
For this scenario, we need to enter the IP of the docker agents or swarm load balancer IP in the urls.csv. Here we are invoking the device register api through proxy on port 443 in case of https or port 80 in case of http.

Below is an example on how to run this scenario from your **jmeter_installation_path/scripts**

`./run_scenario.sh DeviceRegister 10 5 30 http 443 DeviceRegister.jmx`

** User Service, Org Test Results **
1. User signup API benchmark


| API         | URL used in Test   | Thread Count | Ramp-up Period(in Seconds) | Loop Count | Throughput/sec | Avg (ms) | 95th pct | 99th pct | 
|-------------|--------------------|--------------|----------------------------|------------|----------------|----------|----------|----------| 
|             |                    |              |                            |            |                |          |          |          | 
| Create User | api/user/v1/signup | 80           | 30                         | 100        | 111.1          | 636      | 1216.95  | 2777.98  | 
| Create User | api/user/v1/signup | 120          | 30                         | 100        | 107.2          | 1039     | 2220     | 4846     | 
| Create User | api/user/v1/signup | 160          | 30                         | 100        | 114.8          | 1318     | 3030     | 5251.84  | 
| Create User | api/user/v1/signup | 160          | 30                         | 300        | 102.2          | 1499     | 4150     | 5981.91  | 


2. Login APIs benchmark

| API            | URL used in Test | Thread Count | Ramp-up Period(in Seconds) | Loop Count | Throughput/sec | Avg (ms) | 95th pct | 99th pct | 
|----------------|------------------|--------------|----------------------------|------------|----------------|----------|----------|----------| 
| Login Scenerio | All 4 APIs       | 100          | 30                         | 100        | 363.7          | 101      | 356      | 599      | 
| Login Scenerio | All 4 APIs       | 100          | 30                         | 500        | 363.9          | 261      | 586      | 984.97   | 
| Login Scenerio | All 4 APIs       | 160          | 30                         | 100        | 474.6          | 315      | 1159     | 3082     | 
| Login Scenerio | All 4 APIs       | 160          | 30                         | 500        | 451.6          | 324      | 411      | 2413.83  | 


3. Learner service APIs being invoked with 2 keycloak nodes

| API                               | URL used in Test                                   | Thread Count | Ramp-up Period(in Seconds) | Loop Count | Throughput/sec | Avg (ms) | 
|-----------------------------------|----------------------------------------------------|--------------|----------------------------|------------|----------------|----------| 
| Create User (Password Enabled)    | /api/user/v3/create                                | 100          | 30                         | 500        | 94.3           | 1008     | 
| User Profile Read                 | /api/user/v2/read                                  | 100          | 30                         | 1500       | 241.9          | 403      | 
| System Settings Read              | /api/data/v1/system/settings/get                   | 100          | 30                         | 2000       | 709.2          | 120      | 
| Get User by Email or Phone number | /api/user/v1/get/email                             | 100          | 30                         | 1000       | 1424.5         | 65       | 
| Role Read                         | /api/data/v1/role/read                             | 100          | 30                         | 1000       | 674.4          | 142      | 
| Generate Token                    | /auth/realms/sunbird/protocol/openid-connect/token | 100          | 30                         | 3000       | 386.9          | 254      | 
| Org Search                        | /api/org/v1/search                                 | 100          | 30                         | 5000       | 660.7          | 148      | 
| OTP Generate                      | /api/otp/v1/generate                               | 100          | 30                         | 1000       | 675.9          | 141      | 
| User-existence                    | /v1/user/exists/email                              | 100          | 30                         | 10000      | 1445.1         | 66       | 
| Login Scenerio                    | 4 APIs                                             | 100          | 30                         | 750        | 358.8          | 213      | 


4. Learner service APIs being invoked with 4 keycloak nodes:

| API                               | URL used in Test                                   | Thread Count | Ramp-up Period(in Seconds) | Loop Count | Throughput/sec | Avg | 
|-----------------------------------|----------------------------------------------------|--------------|----------------------------|------------|----------------|-----| 
| Create User (Password Enabled)    | /api/user/v3/create                                | 100          | 30                         | 500        | 99.6           | 963 | 
| User Profile Read                 | /api/user/v2/read                                  | 100          | 30                         | 1500       | 219.4          | 444 | 
| System Settings Read              | /api/data/v1/system/settings/get                   | 100          | 30                         | 2000       | 708.6          | 122 | 
| Get User by Email or Phone number | /api/user/v1/get/email                             | 100          | 30                         | 1000       | 555.8          | 173 | 
| Role Read                         | /api/data/v1/role/read                             | 100          | 30                         | 5000       | 667.2          | 145 | 
| Generate Token                    | /auth/realms/sunbird/protocol/openid-connect/token | 100          | 30                         | 3000       | 678.4          | 144 | 
| Org Search                        | /api/org/v1/search                                 | 100          | 30                         | 5000       | 665.2          | 146 | 
| OTP Generate                      | /api/otp/v1/generate                               | 100          | 30                         | 200        | 750.1          | 122 | 
| User-existence                    | /v1/user/exists/email                              | 100          | 30                         | 10000      | 1395.1         | 69  | 
| Verify OTP                        | /api/otp/v1/verify                                 | 100          | 30                         | 200        | 923.2          | 100 | 
| Login Scenerio                    | All 4 APIs                                         | 100          | 30                         | 750        | 491.2          | 183 | 


5. Tests with kong 9

| _                                                            | 2+2 containers  | _          | _              | _        | 3+3 containers  | _        |  4+4 containers  | _        | 
|--------------------------------------------------------------|-----------------|------------|----------------|----------|-----------------|----------|------------------|----------| 
| URL                                                          | Thread Count    | Loop Count | Throughput/sec | Avg (ms) | Throughput/sec  | Avg (ms) | Throughput/sec   | Avg (ms) | 
| /api/data/v1/system/settings/get                             | 400             | 100        | 702.8          | 286      | 666.7           | 325      | 750.4            | 249      | 
| /user/v1/get/email/email                                     | 400             | 20         | 295.8          | 1221     | 267.2           | 1149     | 267.8            | 1369     | 
| /data/v1/role/read                                           | 400             | 20         | 476.1          | 476      | 294.8           | 1055     | 574.5            | 514      | 
| /auth/realms/sunbird/protocol/openid-connect/token           | 400             | 20         | 348.3          | 983      | 343.4           | 1051     | 360.2            | 991      | 
| (user/v2/read/{userId}?fields=organisations,roles,locations) | 400             | 60         | 178.9          | 1979     | 120.9           | 2787     | 150.8            | 2188     | 


6. Before/After optimizations

| _                          | _                                                            | Before optimizations | _                          | _          | _              | After optimizations | _                          | _          | _              | _        | 
|----------------------------|--------------------------------------------------------------|----------------------|----------------------------|------------|----------------|---------------------|----------------------------|------------|----------------|----------| 
| API                        | URL used in test                                             | Thread Count         | Ramp-up Period(in Seconds) | Loop Count | Throughput/sec | Thread Count        | Ramp-up Period(in Seconds) | Loop Count | Throughput/sec | Avg (ms) | 
| system settings read       | /api/data/v1/system/settings/get                             | 100                  | 30                         | 100        | 1122           | 400                 | 30                         | 300        | 2175.5         | 106      | 
| get user by email or phone | /user/v1/get/email/email                                     | 100                  | 30                         | 20         | 66             | 100                 | 30                         | 1000       | 1424.5         | 65       | 
| role read                  | /data/v1/role/read                                           | 250                  | 10                         | 120        | Prev:40        | 400                 | 30                         | 300        | 1219.9         | 305      | 
| generate token             | /auth/realms/sunbird/protocol/openid-connect/token           | 150                  | 10                         | 100        | 211            | 100                 | 30                         | 3000       | 678.4          | 144      | 
| user Profile read          | (user/v2/read/{userId}?fields=organisations,roles,locations) | 100                  | 10                         | 40         | 142            | 400                 | 30                         | 300        | 286.6          | 1267     | 
| org search                 | org/v1/search                                                | 100                  | 30                         | 20         | 455            | 400                 | 30                         | 300        | 1130.8         | 333      | 
| otp generate               | /v1/otp/generate                                             | 200                  | 10                         | 60         | 563            | 400                 | 30                         | 100        | 1314           | 265      | 
| Create user                | api/user/v1/signup                                           | 100                  | 30                         | 20         | 24             | 80                  | 30                         | 100        | 111.1          | 636      | 
| Login                      | Login scenerio (4 Apis)                                      | _                    | _                          | _          | _              | 160                 | 30                         | 100        | 474.6          | 315      | 



7. With out kong

| _                          | 4 (2+2) containers  | _          | _              | _    |  6 (3+3) containers  | _          | _              | _    | 8(4+4) containers  | _          | _              | _    | 
|----------------------------|---------------------|------------|----------------|------|----------------------|------------|----------------|------|--------------------|------------|----------------|------| 
| API                        | Thread Count        | Loop Count | Throughput/sec | Avg  | Thread Count         | Loop Count | Throughput/sec | Avg  | Thread Count       | Loop Count | Throughput/sec | Avg  | 
| system settings read       | 100                 | 300        | 1584.8         | 145  | 100                  | 300        | 1591.2         | 160  | 100                | 300        | 2175.5         | 106  | 
| get user by email or phone | 100                 | 100        | 237.6          | 1518 | 100                  | 300        | 581            | 620  | 100                | 300        | 820.6          | 461  | 
| user Profile read          | 100                 | 100        | 114.6          | 2926 | 100                  | 100        | 193.4          | 1666 | 100                | 100        | 278.7          | 1196 | 
| role read                  | 100                 | 200        | 218.9          | 1754 | 100                  | 200        | 839.2          | 416  | 100                | 300        | 1219.9         | 305  | 
| org search                 | 100                 | 100        | 253.7          | 1188 | 100                  | 300        | 925.1          | 406  | 100                | 300        | 1130.8         | 333  | 
| otp generate               | 100                 | 100        | 1314           | 265  | 100                  | 100        | 1298.3         | 269  | 100                | 100        | 1268.1         | 271  | 
| User-existence             | 100                 | 100        | 224.4          | 1682 | 100                  | 200        | 940.7          | 367  | 100                | 300        | 1176           | 285  | 
| Verify OTP                 | 100                 | 60         | 582.6          | 547  | 100                  | 50         | 998.3          | 374  | 100                | 60         | 1402           | 230  | 
