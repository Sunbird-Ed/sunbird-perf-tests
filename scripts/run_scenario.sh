#!/bin/bash
scenario_id=$1
numThreads=$2
rampupTime=$3
ctrlLoops=$4
protocol=$5
port=$6
JMX_FILE=$7

JMETER_HOME=~/benchmark/
SCENARIO_LOGS=~/benchmark/logs
datadir=$JMETER_HOME/testdata

echo "Executing $scenario_id"
JMX_FILE_PATH=~/benchmark/scenarios/$7

mkdir -p /mount/data/benchmark/logs/$scenario_id
mkdir -p /mount/data/benchmark/logs/$scenario_id/logs
mkdir -p /mount/data/benchmark/logs/$scenario_id/server/
cp $JMX_FILE_PATH $JMETER_HOME/current_scenario/

JMX_FILE_PATH=$JMETER_HOME/current_scenario/$7

sed -i "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH
sed -i "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH
sed -i "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH
sed -i "s/SCENARIO_ID/${scenario_id}/g" $JMX_FILE_PATH
sed -i "s/PORT/${port}/g" $JMX_FILE_PATH
sed -i "s/DATADIR/${datadir}/g" $JMX_FILE_PATH
sed -i "s/PROTOCOL/${protocol}/g" $JMX_FILE_PATH

cp $JMX_FILE_PATH $SCENARIO_LOGS/$scenario_id/logs

echo "Check logs at /mount/data/benchmark/logs/$scenario_id/logs/scenario.log"

nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -RJMETER_CLUSTER_REPLACE -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

echo "Execution of $scenario_id Complete."
