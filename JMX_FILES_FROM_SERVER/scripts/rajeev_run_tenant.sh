#!/bin/bash

scenario_id=$1
numThreads=$2
rampupTime=$3
ctrlLoops=$4
JMETER_HOME=/mount/data/benchmark/apache-jmeter-4.0
SCENARIO_LOGS=/mount/data/benchmark/logs
echo "Executing $scenario_id"

if [ -f /mount/data/benchmark/logs/$scenario_id ]
then
	rm /mount/data/benchmark/logs/$scenario_id
fi

echo "Instance Id: 28.0.0.18"
IP_ADDR=`echo "28.0.0.18" | sed 's/\.//g'`

JMX_FILE_PATH=/mount/data/benchmark/current_scenario/tenant_api_request.jmx

mkdir /mount/data/benchmark/logs/$scenario_id
mkdir /mount/data/benchmark/logs/$scenario_id/logs
mkdir /mount/data/benchmark/logs/$scenario_id/server/
echo $JMX_FILE_PATH $1 $2 $3 $4 > /mount/data/benchmark/logs/$scenario_id/logs/summary  
rm /mount/data/benchmark/current_scenario/*.jmx
cp /mount/data/benchmark/scenarios/tenant_api_request.jmx $JMX_FILE_PATH
#cp /mount/data/benchmarkscenarios/telemetry_events.json.gz /mount/data/benchmarkcurrent_scenario/telemetry_events.json.gz
sed -i "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH
sed -i "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH
sed -i "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH
sed -i "s/AUTH_KEY/AUTH_KEY/g" $JMX_FILE_PATH
sed -i "s/SCENARIO_ID/${scenario_id}/g" $JMX_FILE_PATH
sed -i "s/IP_ADDR/${IP_ADDR}/g" $JMX_FILE_PATH


nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.32,28.0.0.31,28.0.0.20,28.0.0.19 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

echo "Execution of $scenario_id Complete."
