The purpose of this document is to describe the steps required to perform a sunbird platform load test.

### Pre-requisites
#### Directory structure
```
▾ sunbird-platform/
  ▾ bin/
      run_scenario.sh*
      variables.sh*
  # Test scenarios
  ▾ content-search/
      content-search.jmx
      dialcodes.csv
  ▾ org-search/
      org-search.csv
      org-search.jmx
  ▸ page-assemble/
```
**run_scenario input file aka [variables.sh](bin/variables.sh)**
> `cd bin && ./run_scenario.sh $scenario_name $numThreads $rampupTime $ctrlLoops $pathPrefix` will invoke jmeter test
```sh
# Variable file for run_scenario.sh
# This file will be sourced to run_scenario.sh

# host against jmeter to run
# ip or domain name
host=
protocol=https
port=443

# (Optional)
# value to prefix the log
# By default it'll be date_month_day_hour_minute_second
# eg: 16th_May_Thursday_13h-25m-41s
custom_log_id=

# Comma seperated ips of jmeter slves
# eg: 
# JMETER_CLUSTER_IPS="28.0.0.34,28.0.0.35,28.0.0.36,28.0.0.37"
JMETER_CLUSTER_IPS=""

# Jwt token to authorize kong
apiKey="" # BEarer token

# ssh user to jmeter slaves
ssh_jmeter_slave_user="deployer"

# Username and password to generate x-authenticated-token
# for user related actions
username="ntp-loadtest-admin"
password="password"

# Jmeter location
JMETER_HOME="/mount/data/benchmark/apache-jmeter-4.0"

# Datafile path in slaves
data_file_path="/mount/data/benchmark/current_scenario/"

# Scenarios logs location
scenario_logs_path=~/logs/$scenario_name

```

##### Conventions for variable names to fill in [variables.sh](bin/variables.sh)

1. scenario_names:  
    `scenario_name=org-search`  
    ```sh
    sunbird-platform/
        org-search/
            org-search.csv
            org-search.jmx
    ```
   scenario_name and .jmx, .csv name should be identical. 

2. JMX file:
   
   below PLACEHOLDERS will get replaced by values in JMX file path  
   `sed -i "s/PLACEHOLDER_IN_JMX/${replacing value}/g" $JMX_FILE_PATH`
   ```sh
    sed -i "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH 
    sed -i "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH
    sed -i "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH
    sed -i "s/ACCESS_TOKEN/${accessToken}/g" $JMX_FILE_PATH
    sed -i "s/API_KEY/${apiKey}/g" $JMX_FILE_PATH
    sed -i "s#CSV_FILE#${csvFile}#g" $JMX_FILE_PATH
    sed -i "s#DOMAIN_FILE#${csvFileHost}#g" $JMX_FILE_PATH
    sed -i "s#PATH_PREFIX#${pathPrefix}#g" $JMX_FILE_PATH
    sed -i "s#HOST#${host}#g" $JMX_FILE_PATH
    sed -i "s#PORT#${port}#g" $JMX_FILE_PATH
    sed -i "s#PROTOCOL#${protocol}#g" $JMX_FILE_PATH
    ```

### How to run?

1. Run load test scenario script with necessary arguments:

```sh
rajeshr@jmeter-1:~/sunbird-perf-tests/knowledge-platform/bin$ ./run_scenario.sh collection-hierarchy 10 5 10 /api/course/v1/hierarchy/$\{identifier
\}
Executing 17th_May_Friday_14h-24m-14s
ip =  28.0.0.34,28.0.0.35,28.0.0.36,28.0.0.37
host =  28.0.0.12
pathPrefix =  /api/course/v1/hierarchy/${identifier}
scenario_name =  collection-hierarchy
scenario_id =  17th_May_Friday_14h-24m-14s
numThreads =  10
rampupTime =  5
ctrlLoops =  10
apiKey =
accessToken =
csvFile =  /mount/data/benchmark/current_scenario/collection-hierarchy.csv
csvFileHost= /mount/data/benchmark/current_scenario/hostFile.csv
hostFile.csv                                                                                                     100%   40     0.0KB/s   00:00
collection-hierarchy.csv                                                                                         100%   47KB  47.2KB/s   00:00
hostFile.csv                                                                                                     100%   40     0.0KB/s   00:00
collection-hierarchy.csv                                                                                         100%   47KB  47.2KB/s   00:00
hostFile.csv                                                                                                     100%   40     0.0KB/s   00:00
collection-hierarchy.csv                                                                                         100%   47KB  47.2KB/s   00:00
hostFile.csv                                                                                                     100%   40     0.0KB/s   00:00
collection-hierarchy.csv                                                                                         100%   47KB  47.2KB/s   00:00
Running ...
Creating summariser <summary>
Created the tree successfully using /home/rajeshr/current_scenario/collection-hierarchy.jmx
Configuring remote engine: 28.0.0.34
Configuring remote engine: 28.0.0.35
Configuring remote engine: 28.0.0.36
Configuring remote engine: 28.0.0.37
Starting remote engines
Starting the test @ Fri May 17 14:24:22 UTC 2019 (1558103062918)
Remote engines have been started
Waiting for possible Shutdown/StopTestNow/Heapdump message on port 4445
summary =    400 in 00:00:05 =   77.8/s Avg:    75 Min:    11 Max:  1446 Err:     0 (0.00%)
Tidying up remote @ Fri May 17 14:24:29 UTC 2019 (1558103069063)
... end of run
Log file ...
/home/rajeshr/logs/collection-hierarchy/17th_May_Friday_14h-24m-14s/logs/scenario.log
Execution of 17th_May_Friday_14h-24m-14s started.
```

Other Logs:
* /home/rajeshr/logs/collection-hierarchy/17th_May_Friday_14h-24m-14s/logs/jmeter.log
* /home/rajeshr/logs/collection-hierarchy/17th_May_Friday_14h-24m-14s/logs/output.xml


