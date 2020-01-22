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
