#!/bin/bash
#bash -x stop.sh
#/home/ops/start.sh & > /dev/null
#echo "sleeping 5 sec"
#sleep 7
scenario_id=$1
apiKey=$2
csvFileHost=$3
csvFileRequest=$4
#numThreads=$2
#rampupTime=$3
#ctrlLoops=$4
JMETER_HOME=/mount/data/benchmark/apache-jmeter-5.3
SCENARIO_LOGS=/mount/data/benchmark/logs
echo "Executing $scenario_id"

if [ -f /mount/data/benchmark/logs/$scenario_id ]
then
	rm /mount/data/benchmark/logs/$scenario_id
fi


JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/group-soak-test/GroupServiceSoakTestSuite.jmx





#Individual APIs
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/ContentRead.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/ContentHierarchy.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FrameWorkRead.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FrameWorkReadFilters.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/ChannelRead.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/ContentSearch.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/DeviceRegister.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/device_register.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FormRead.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/TenantInfo.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/PageAssemble.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/OrgSearch.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/Telemetry.jmx

mkdir -p /mount/data/benchmark/logs/$scenario_id
mkdir -p /mount/data/benchmark/logs/$scenario_id/logs
mkdir -p /mount/data/benchmark/logs/$scenario_id/server/
#rm /mount/data/benchmark/current_scenario/*.jmx
#cp /mount/data/benchmark/scenarios/proxy_base_device_register.jmx $JMX_FILE_PATH
#cp /mount/data/benchmark/scenarios/content_get_data /mount/data/benchmark/current_scenario/content_get_data
echo "apiKey = " ${apiKey}
#echo "csvFileHost = " ${csvFileHost}
#echo "csvFileRequest = " ${csvFileRequest}


sed "s/API_KEY/${apiKey}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

#sed "s#DOMAIN_FILE#${csvFileHost}#g" $JMX_FILE_PATH > jmx.tmp
#mv jmx.tmp $JMX_FILE_PATH

#sed "s#CSV_FILE#${csvFileRequest}#g" $JMX_FILE_PATH > jmx.tmp
#mv jmx.tmp $JMX_FILE_PATH

cp $JMX_FILE_PATH $SCENARIO_LOGS/$scenario_id/logs

echo "Check logs at /mount/data/benchmark/logs/$scenario_id/logs/scenario.log"

nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R<Jmeter_Cluster_IP> -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &


echo "Execution of $scenario_id Complete."

tail -f $SCENARIO_LOGS/$scenario_id/logs/scenario.log
