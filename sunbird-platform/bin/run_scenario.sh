#!/bin/bash
set -e
scenario_name=$1
numThreads=$2
rampupTime=$3
ctrlLoops=$4
csvFile="/mount/data/benchmark/current_scenario/$scenario_name.csv" # request body
pathPrefix=$5

source /usr/local/bin/creds.sh
JMETER_HOME="/mount/data/benchmark/apache-jmeter-4.0"
ips="28.0.0.34,28.0.0.35,28.0.0.36,28.0.0.37"
#host=28.0.0.8 # Dummy value; have to change
#protocol=https
#port=443
date=$(date +"%T")
csvFileHost="/mount/data/benchmark/current_scenario/hostFile.csv"
SCENARIO_LOGS=~/logs/$scenario_name
JMETER_CLUSTER_IPS=$ips
scenario_id=${date//:}


echo "Executing $scenario_id"

if [ -f ~/logs/$scenario_id ]
then
	rm ~/logs/$scenario_id
fi

mkdir -p ~/current_scenario
JMX_FILE_PATH=~/current_scenario/$scenario_name.jmx

mkdir -p $SCENARIO_LOGS
mkdir -p $SCENARIO_LOGS/$scenario_id
mkdir -p $SCENARIO_LOGS/$scenario_id/logs
mkdir -p $SCENARIO_LOGS/$scenario_id/server/

rm -rf ~/current_scenario/*.jmx
cp ~/sunbird-perf-tests/sunbird-platform/$scenario_name/$scenario_name.jmx $JMX_FILE_PATH

echo "ip = " ${ip}
echo "host = " ${host}
echo "pathPrefix = " ${pathPrefix}
echo "scenario_name = " ${scenario_name}
echo "scenario_id = " ${scenario_id}
echo "numThreads = " ${numThreads}
echo "rampupTime = " ${rampupTime}
echo "ctrlLoops = " ${ctrlLoops}
echo "apiKey = " ${apiKey}
echo "accessToken = " ${accessToken}
echo "csvFile = " ${csvFile}
echo "csvFileHost= "${csvFileHost}

#ips="28.0.0.34,28.0.0.35,28.0.0.36,28.0.0.37"
for server in $(echo "$ips" | tr ","  " ");
do
scp /mount/data/benchmark/current_scenario/hostFile.csv deployer@$server:/mount/data/benchmark/current_scenario/hostFile.csv
ssh -n deployer@$server curl  https://raw.githubusercontent.com/Sunbird-Ed/sunbird-perf-tests/master/sunbird-platform/org-search/org-search.csv -o $csvFile
done

sed -i "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH 

sed -i "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH

sed -i "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH

sed -i "s/ACCESS_TOKEN/${accessToken}/g" $JMX_FILE_PATH

sed -i "s/HOST/${host}/g" $JMX_FILE_PATH

sed -i "s/API_KEY/${apiKey}/g" $JMX_FILE_PATH

sed -i "s#CSV_FILE#${csvFile}#g" $JMX_FILE_PATH

sed -i "s#DOMAIN_FILE#${csvFileHost}#g" $JMX_FILE_PATH

sed -i "s#PATH_PREFIX#${pathPrefix}#g" $JMX_FILE_PATH

echo "Running ... "
echo "$JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R ${ips} -l $SCENARIO_LOGS/${scenario_id}/logs/output.xml -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log"

$JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R ${ips} -l $SCENARIO_LOGS/${scenario_id}/logs/output.xml -j $SCENARIO_LOGS/${scenario_id}/logs/jmeter.log > $SCENARIO_LOGS/${scenario_id}/logs/scenario.log 2>&1

echo "Log file ..."
echo "$SCENARIO_LOGS/${scenario_id}/logs/scenario.log"

echo "Execution of $scenario_id Complete."
