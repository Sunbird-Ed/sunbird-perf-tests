# sunbird-perf-tests
Data preparation scripts, JMX files, JMeter scripts for performance testing


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
| device/v3/register | 920.6 @ 413 | 2051.1 @ 362 |   |
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


