### Running the scenarios

* Clone this repository and in your `$HOME` directory. If you have cloned this into some other directory, then in all the sample execution commands which are shown below, change `~/sunbird-perf-tests/sunbird-platform/`  to the cloned directory

* In all the sample execution commands which are shown below, `/mount/data/benchmark/apache-jmeter-4.0/` is the Jmeter home directory. This needs to be changed according to your local setup. If you have used this [Installation Details](jmeter-installtion.md), then use `~/benchmark/apache-jmeter-4.0/` in your execution.

* All CSV files required for exection have dummy data in them. Remove the dummy data and update the CSV file with valid data. The format of data / contents required are explained within the CSV file.

* In all the sample execution commands shown below, `JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP` is a comma separated list of Jmeter slave IP's. If you are using only one Jmeter machine (master + slave), provide just one IP here.

* In all our tests, we did not use the master Jmeter server to run any actual tests (only orchestrate and generate reports). Our setup included four slaves and one master. You are free to customize this as per your need.


#### 1. user-create.jmx

This scenario file contains the following API's which will be invoked as part of the run

**User signup :** *api/user/v1/signup*

This scenario uses the following csv files:
- user-create-test-data.csv
- host.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/user-create

This script takes 11 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey 
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' user-create user-create-R1 THREAD_SIZE  RAMPUP LOOPCOUNT bearerAPIKey ~/sunbird-perf-tests/sunbird-platform/user-create/host.csv ~/sunbird-perf-tests/sunbird-platform/user-create/user-create-test-data.csv api/user/v1/signup```


Script to generate test data required to create user

```./generate-test-data.sh 60 60 60 0```

This will create test data with 60 users with file name user-create-test-data.csv
 

#### 2. login.jmx

This scenario file contains the following API's which will be invoked as part of the run

* */resources/*
* */auth/realms/sunbird/protocol/openid-connect/auth*
* */auth/realms/sunbird/login-actions/authenticate*
* */resources*

This scenario uses the following csv files:
- user-data.csv
- host.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/login

This script takes 9 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * Host file path
  * Test data file path

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' login login-Run1 THREAD_SIZE RAMPUP LOOPCOUNT  ~/sunbird-perf-tests/sunbird-platform/host.csv  ~/sunbird-perf-tests/sunbird-platform/login/user-data.csv```



#### 3. system-settings.jmx

This scenario file contains the following API's which will be invoked as part of the run

**System Settings Read:** */api/data/v1/system/settings/get*

This scenario uses the following csv files:
- system-settings.csv
- host.csv

Below is an example on how to run this scenario:

Change directory to:  ~/sunbird-perf-tests/sunbird-platform/system-settings

This script takes 11 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' system-settings system-settings-Run1 THREAD_SIZE RAMPUP LOOPCOUNT  bearerAPIKey ~/sunbird-perf-tests/sunbird-platform/system-settings/system-settings.csv ~/sunbird-perf-tests/sunbird-platform/host.csv /api/data/v1/system/settings/get```
 
 
#### 4. user-get.jmx

This scenario file contains the following API's which will be invoked as part of the run

**Get User by Email or Phone:** */api/user/v1/get/email*

This scenario uses the following csv files:
- user-get.csv
- host.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/user-get

This script takes 11 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP'  user-get user-get-Run1 THREAD_SIZE RAMPUP LOOPCOUNT bearerAPIKey ~/sunbird-perf-tests/sunbird-platform/host.csv ~/sunbird-perf-tests/sunbird-platform/user-get/user-get.csv /api/user/v1/get/email```
 
 
#### 5. user-read.jmx

This scenario file contains the following API's which will be invoked as part of the run

**User Profile Read:** */api/user/v2/read*

This scenario uses the following csv files:
- userId.csv
- host.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/user-read

This script takes 12 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey
  * User Name - used to generate authenticated-user-token
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

``` ./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' user-read user-read-Run1 THREAD_SIZE RAMPUP LOOPCOUNT  bearerAPIKey username ~/sunbird-perf-tests/sunbird-platform/host.csv ~/sunbird-perf-tests/sunbird-platform/user-read/userId.csv /api/user/v2/read```


#### 6. user-role-read.jmx

This scenario file contains the following API's which will be invoked as part of the run

**Role Read:** */api/data/v1/role/read*

This scenario uses the following csv files:
- host.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/user-role-read

This script takes 12 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey
  * Access Token Url  - example: loadtest.ntp.net.in
  * User Name - used to generate authenticated-user-token
  * Host file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' user-role-read user-role-read-run1 THREAD_SIZE RAMPUP LOOPCOUNT  bearerAPIKey  accessTokenUrl username ~/sunbird-perf-tests/sunbird-platform/host.csv /api/data/v1/role/read```


#### 7. generate-token.jmx

This scenario file contains the following API's which will be invoked as part of the run

**Generate Token:** */auth/realms/sunbird/protocol/openid-connect/token*

This scenario uses the following csv files:
- host.csv
- user-data.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/generate-token

This script takes 10 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' generate-token generate-token-Run1 THREAD_SIZE RAMPUP LOOPCOUNT ~/sunbird-perf-tests/sunbird-platform/host.csv ~/sunbird-perf-tests/sunbird-platform/generate-token/user-data.csv /auth/realms/sunbird/protocol/openid-connect/token```


 
#### 8. org-search.jmx

This scenario file contains the following API's which will be invoked as part of the run

**Org Search:** */api/org/v1/search*

This scenario uses the following csv files:
- host.csv
- org-search-request.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/org-search

This script takes 11 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' org-search org-search-Run1 THREAD_SIZE RAMPUP LOOPCOUNT bearerAPIKey ~/sunbird-perf-tests/sunbird-platform/host.csv /api/org/v1/search ~/sunbird-perf-tests/sunbird-platform/org-search/org-search-request.csv```


#### 9. generate-otp.jmx

This scenario file contains the following API's which will be invoked as part of the run

**OTP Generate:** */api/otp/v1/generate*

This scenario uses the following csv files:
- host.csv
- user-data.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/generate-otp

This script takes 11 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' generate-otp generate-otp-Run1 THREAD_SIZE RAMPUP LOOPCOUNT bearerAPIKey ~/sunbird-perf-tests/sunbird-platform/host.csv ~/sunbird-perf-tests/sunbird-platform/user-create/user-data.csv  /api/otp/v1/generate```


#### 10. verify-otp.jmx

This scenario file contains the following API's which will be invoked as part of the run

**Verify OTP:** */api/otp/v1/verify*

This scenario uses the following csv files:
- host.csv
- user-data.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/verify-otp

This script takes 11 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' verify-otp verify-otp-Run1 THREAD_SIZE RAMPUP LOOPCOUNT bearerAPIKey ~/sunbird-perf-tests/sunbird-platform/host.csv  ~/sunbird-perf-tests/sunbird-platform/verify-otp/user-data.csv  /api/otp/v1/verify```
 

#### 11. user-existence.jmx

This scenario file contains the following API's which will be invoked as part of the run

**User Exist:** */v1/user/exists/email*

This scenario uses the following csv files:
- host.csv
- user-data.csv

Below is an example on how to run this scenario:

Change directory to: ~/sunbird-perf-tests/sunbird-platform/user-existence

This script takes 11 arguments. The order and the list of parameters required for this script are as below:
  * Jmeter Home
  * Jmeter Slave ips
  * Scenario_name  - This will be directory name
  * Scenario ID - This will be directory name where the log files will be saved
  * Number of threads
  * Ramp up time
  * Number of loops
  * bearer apiKey
  * User Name - used to generate authenticated-user-token
  * Host file path
  * Test data file path
  * API url

**Execution command:-**

```./run_scenario.sh /mount/data/benchmark/apache-jmeter-4.0/ 'JmeterSlave1IP,JmeterSlave2IP,JmeterSlave3IP' user-existence user-existence-Run1 THREAD_SIZE RAMPUP LOOPCOUNT bearerAPIKey username ~/sunbird-perf-tests/sunbird-platform/host.csv ~/sunbird-perf-tests/sunbird-platform/user-existence/user-data.csv /v1/user/exists/email```
