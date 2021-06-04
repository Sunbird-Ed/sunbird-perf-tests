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

echo "Instance Id: 28.0.0.36"
#IP_ADDR=`echo "loadtest.ntp.net.in" | sed 's/\.//g'`

#JMX_FILE_PATH=/mount/data/benchmark/scenarios/CollectionEditor.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FullSoak_NoRatio_NoComposite.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FullSoak_For_Chaos.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_test.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_test_frameworkRead.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_test_telemetry.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_test_telemetry_final.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_test_old_parallel.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/telemetry.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/tenant-info.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/TestSoak.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/ContentReadNew.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/ContentReadNewDirect.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/LP_Content_Hier_Read.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/DummyTenantInfo.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FullSoak_WithRatios.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/LoadTestLP_CROnly.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/LoadTestLP_CROnly_Proxy.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/LoadTestLP_CHOnly_Proxy.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/ReadFrameworkLoadTest.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FullSoak_WithFramework.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FullSoak_For_Chaos_WithAnalyticsAPI.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/FullSoak_WithAA_WithPA.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/Kube.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/echo-service.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_cluster2.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_16may_cluster2.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_21may_cluster2.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_test_cluster2_new.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_test_cluster2_no_keepalive.jmx
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/program-portal/program-soak-test/program-soak-test_7.jmx
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/test-data-preparation/test_data_population_group.jmx
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata/groups_testdata/test_data_population_group.jmx
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/testdata-creation-aggregateAPI/add-user-group.jmx
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/content-play/content-play-blobStorage-nodeIPs-final.jmx
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/content-play/content-play-blobStorage-1-file.jmx
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/content-play/content-play-pdf-blobstorage.jmx 
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/content-play/content-play-multithread.jmx 
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/content-play/content-play-multithread-concurrencyThread.jmx
#JMX_FILE_PATH=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/content-play/content-play-parrallel.jmx 
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak_test_cluster1_size.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/soak-test-cluster1-prodlike-tps.jmx
#JMX_FILE_PATH=/mount/data/benchmark/scenarios/cached-apis.jmx
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
# 7 clients
#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.31,28.0.0.20,28.0.0.19,28.0.0.32,28.0.0.34,28.0.0.35,28.0.0.36 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

# 12 clients
#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.31,28.0.0.20,28.0.0.19,28.0.0.32,28.0.0.34,28.0.0.35,28.0.0.36,28.0.0.37,28.0.0.23,28.0.0.24,28.0.0.25,28.0.0.33 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

# 8 clients
#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.31,28.0.0.20,28.0.0.19,28.0.0.32,28.0.0.34,28.0.0.35,28.0.0.36,28.0.0.37 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &


# 8 clients
#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.54,28.0.0.51,28.0.0.62,28.0.0.63,28.0.0.69,28.0.0.70,28.0.0.71,28.0.0.72 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

# 7 clients
nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.37,28.0.0.43,28.0.0.44,28.0.0.45 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

# 12 clients
#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.19,28.0.0.20,28.0.0.31,28.0.0.32,28.0.0.24,28.0.0.25,28.0.0.27,28.0.0.37,28.0.0.43,28.0.0.44,28.0.0.45,28.0.0.71,28.0.0.72,28.0.0.29 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log | tee $SCENARIO_LOGS/$scenario_id/logs/scenario.log

#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.19,28.0.0.20,28.0.0.31,28.0.0.32,28.0.0.24,28.0.0.25,28.0.0.27,28.0.0.37,28.0.0.43,28.0.0.44 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log | tee $SCENARIO_LOGS/$scenario_id/logs/scenario.log



#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.37,28.0.0.43,28.0.0.44,28.0.0.45 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log | tee $SCENARIO_LOGS/$scenario_id/logs/scenario.log


#$JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.53,28.0.0.54,28.0.0.51,28.0.0.62,28.0.0.63 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log | tee $SCENARIO_LOGS/$scenario_id/logs/scenario.log

#echo  "Thread Count = " ${numThreads} >> $SCENARIO_LOGS/$scenario_id/logs/summary/index.html
#echo  "Loop Count = " ${ctrlLoops} >> $SCENARIO_LOGS/$scenario_id/logs/summary/index.html

#az storage blob upload-batch --account-name dikshaloadtest --sas-token "?sv=2019-10-10&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-06-25T16:54:20Z&st=2020-06-25T08:54:20Z&spr=https&sig=%2FUKHuzhyt5sPixIXkY1jtjabC7aqV8awEXmBtKTCIOY%3D" --destination jmeter-html-reports/$scenario_id --source $SCENARIO_LOGS/$scenario_id/logs/summary | grep index.html


#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.36 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

# 4 clients
#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.51,28.0.0.54,28.0.0.62,28.0.0.63 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

# 12 clients
#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R28.0.0.31,28.0.0.20,28.0.0.19,28.0.0.32,28.0.0.34,28.0.0.35,28.0.0.36,28.0.0.37,28.0.0.23,28.0.0.24,28.0.0.25,28.0.0.27 -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

#echo  "Thread Count = " ${numThreads} >> $SCENARIO_LOGS/$scenario_id/logs/summary/index.html
#echo  " Loop Count = " ${ctrlLoops} >> $SCENARIO_LOGS/$scenario_id/logs/summary/index.html

#az storage blob upload-batch --account-name dikshaloadtest --sas-token "?sv=2019-10-10&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-06-25T16:54:20Z&st=2020-06-25T08:54:20Z&spr=https&sig=%2FUKHuzhyt5sPixIXkY1jtjabC7aqV8awEXmBtKTCIOY%3D" --destination jmeter-html-reports/$scenario_id --source $SCENARIO_LOGS/$scenario_id/logs/summary | grep index.html

echo "Execution of $scenario_id Complete."

tail -f $SCENARIO_LOGS/$scenario_id/logs/scenario.log
