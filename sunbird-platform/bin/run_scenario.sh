#!/bin/bash

ips=$1
host=$2
scenario_name=$3
scenario_id=$4
numThreads=$5
rampupTime=$6
ctrlLoops=$7
accessToken=$8

JMETER_HOME=~/apache-jmeter-5.1.1
SCENARIO_LOGS=~/logs
JMETER_CLUSTER_IPS=$ips

echo "Executing $scenario_id"

if [ -f ~/logs/$scenario_id ]
then
	rm ~/logs/$scenario_id
fi

JMX_FILE_PATH=~/current_scenario/$scenario_name.jmx

mkdir ~/logs/$scenario_id
mkdir ~/logs/$scenario_id/logs
mkdir ~/logs/$scenario_id/server/

rm ~/current_scenario/*.jmx
cp ~/sunbird-perf-tests/sunbird-platform/$scenario_name/$scenario_name.jmx $JMX_FILE_PATH

sed -i tmp "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH
sed -i tmp "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH
sed -i tmp "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH
sed -i tmp "s/ACCESS_TOKEN/${accessToken}/g" $JMX_FILE_PATH
sed -i tmp "s/HOST/${host}/g" $JMX_FILE_PATH

nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R$JMETER_CLUSTER_IPS -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

echo "Execution of $scenario_id Complete."

