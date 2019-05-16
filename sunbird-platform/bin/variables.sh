#!/bin/bash
# Variable file for run_scenario.sh
# This file will be sourced to run_scenario.sh

# Parameter for Jmeter
scenario_name=
numThreads=
rampupTime=
ctrlLoops=
# Name of API which loadtests
pathPrefix=

# host against jmeter to run
# ip or domain name
host=
protocol=https
port=443

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
