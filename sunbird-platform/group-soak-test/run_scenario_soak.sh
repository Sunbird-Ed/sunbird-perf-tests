#!/bin/bash
#bash -x stop.sh
#/home/ops/start.sh & > /dev/null
#echo "sleeping 5 sec"
#sleep 7
scenario_id=$1
apiKey=$2
csvFileHost=$3
csvFileRequest=$4

JMETER_HOME=/mount/data/benchmark/apache-jmeter-5.3
SCENARIO_LOGS=/mount/data/benchmark/logs
echo "Executing $scenario_id"

if [ -f /mount/data/benchmark/logs/$scenario_id ]
then
	rm /mount/data/benchmark/logs/$scenario_id
fi


JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/group-soak-test/GroupServiceSoakTestSuite.jmx






mkdir -p /mount/data/benchmark/logs/$scenario_id
mkdir -p /mount/data/benchmark/logs/$scenario_id/logs
mkdir -p /mount/data/benchmark/logs/$scenario_id/server/

echo "apiKey = " ${apiKey}



sed "s/API_KEY/${apiKey}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH


cp $JMX_FILE_PATH $SCENARIO_LOGS/$scenario_id/logs

echo "Check logs at /mount/data/benchmark/logs/$scenario_id/logs/scenario.log"

nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R<Jmeter_Cluster_IP> -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &


echo "Execution of $scenario_id Complete."

tail -f $SCENARIO_LOGS/$scenario_id/logs/scenario.log
