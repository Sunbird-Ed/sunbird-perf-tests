#!/bin/bash

jmeterHome=$1
ips=$2
scenario_name=$3
scenario_id=$4
numThreads=$5
rampupTime=$6
ctrlLoops=$7
apiKey=$8
accessTokenUrl=$9
userName=${10}
csvFileHost=${11}
csvFileRequest=${12}
userReadApi=${13}

# Generating x-authenticated-token
accessToken=$(curl -s -X POST https://${accessTokenUrl}/auth/realms/sunbird/protocol/openid-connect/token  -H 'content-type: application/x-www-form-urlencoded'  --data "client_id=admin-cli&username=${userName}&password=password&grant_type=password" | jq -r '.access_token') # X-AUTHENTICATED-TOKEN

echo "accessTokenUrl = " ${accessTokenUrl}
echo "userName = " ${userName}
echo "accessToken = " ${accessToken}

JMETER_HOME=/mnt/data/benchmark/apache-jmeter-4.0
JMETER_HOME=${jmeterHome}

SCENARIO_LOGS=/mount/data/benchmark/sunbird-perf-tests/sunbird-platform/logs/$scenario_name

JMETER_CLUSTER_IPS=$ips

echo "Executing $scenario_id"

if [ -f ~/logs/$scenario_id ]
then
	rm ~/logs/$scenario_id
fi

JMX_FILE_PATH=~/current_scenario/$scenario_name.jmx

mkdir $SCENARIO_LOGS
mkdir $SCENARIO_LOGS/$scenario_id
mkdir $SCENARIO_LOGS/$scenario_id/logs
mkdir $SCENARIO_LOGS/$scenario_id/server/

rm ~/current_scenario/*.jmx
cp /mount/data/benchmark/sunbird-perf-tests/sunbird-platform/$scenario_name/$scenario_name.jmx $JMX_FILE_PATH

echo "ip = " ${ips}
echo "scenario_name = " ${scenario_name}
echo "scenario_id = " ${scenario_id}
echo "numThreads = " ${numThreads}
echo "rampupTime = " ${rampupTime}
echo "ctrlLoops = " ${ctrlLoops}
echo "apiKey = " ${apiKey}
echo "accessTokenUrl = " ${accessTokenUrl}
echo "userName = " ${userName}
echo "accessToken = " ${accessToken}
echo "csvFileHost = " ${csvFileHost}
echo "csvFileRequest = " ${csvFileRequest}
echo "userReadApi = " ${userReadApi}


sed "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH


sed "s/API_KEY/${apiKey}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s/ACCESS_TOKEN/${accessToken}/g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s#DOMAIN_FILE#${csvFileHost}#g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s#CSV_FILE#${csvFileRequest}#g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH

sed "s#PATH_PREFIX#${userReadApi}#g" $JMX_FILE_PATH > jmx.tmp
mv jmx.tmp $JMX_FILE_PATH



echo "Running ... "
echo "$JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R ${ips} -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log"

#nohup $JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R ${ips} -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &

### Create HTML reports for every run ###
$JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R ${ips} -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log | tee $SCENARIO_LOGS/$scenario_id/logs/scenario.log


echo  "Thread Count = " ${numThreads} >> $SCENARIO_LOGS/$scenario_id/logs/summary/index.html
echo  " Loop Count = " ${ctrlLoops} >> $SCENARIO_LOGS/$scenario_id/logs/summary/index.html

az storage blob upload-batch --account-name dikshaloadtest --sas-token "?sv=2019-10-10&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-06-25T16:54:20Z&st=2020-06-25T08:54:20Z&spr=https&sig=%2FUKHuzhyt5sPixIXkY1jtjabC7aqV8awEXmBtKTCIOY%3D" --destination jmeter-html-reports/$scenario_id --source $SCENARIO_LOGS/$scenario_id/logs/summary | grep index.html

echo "Log file ..."
echo "$SCENARIO_LOGS/$scenario_id/logs/scenario.log"

echo "Execution of $scenario_id Complete."

tail -f $SCENARIO_LOGS/$scenario_id/logs/scenario.log
