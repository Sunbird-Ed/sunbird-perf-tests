#!/bin/bash
set -e
source variables.sh
# filepath for data file in jmeter slaves
csvFile="$data_file_path/$scenario_name.csv" # request body
pathPrefix=$5

# Generating x-authenticated-token
accessToken=$(curl -s -X POST https://loadtest.ntp.net.in/auth/realms/sunbird/protocol/openid-connect/token  -H 'content-type: application/x-www-form-urlencoded'  --data "client_id=admin-cli&username=${username}&password=${password}&grant_type=password" | jq -r '.access_token') # X-AUTHENTICATED-TOKEN

#host=28.0.0.8 # Dummy value; have to change
#protocol=https
#port=443
date=$(date +"%T")
csvFileHost="/mount/data/benchmark/current_scenario/hostFile.csv"
scenario_id=${date//:}

echo "Executing $scenario_id"

if [ -f $SCENARIO_LOGS/$scenario_id ]
then
	rm $SCENARIO_LOGS/$scenario_id
fi


mkdir -p $SCENARIO_LOGS
mkdir -p $SCENARIO_LOGS/$scenario_id
mkdir -p $SCENARIO_LOGS/$scenario_id/logs
mkdir -p $SCENARIO_LOGS/$scenario_id/server/


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


# Temporary directory to sed
mkdir -p ~/current_scenario
JMX_FILE_PATH=~/current_scenario/$scenario_name.jmx
rm -rf ~/current_scenario/*.jmx
cp ../$scenario_name/$scenario_name.jmx $JMX_FILE_PATH

sed -i "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH 
sed -i "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH
sed -i "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH
sed -i "s/ACCESS_TOKEN/${accessToken}/g" $JMX_FILE_PATH
sed -i "s/HOST/${host}/g" $JMX_FILE_PATH
sed -i "s/API_KEY/${apiKey}/g" $JMX_FILE_PATH
sed -i "s#CSV_FILE#${csvFile}#g" $JMX_FILE_PATH
sed -i "s#DOMAIN_FILE#${csvFileHost}#g" $JMX_FILE_PATH
sed -i "s#PATH_PREFIX#${pathPrefix}#g" $JMX_FILE_PATH

#JMETER_CLUSTER_IPS="28.0.0.34,28.0.0.35,28.0.0.36,28.0.0.37"
for server in $(echo "$JMETER_CLUSTER_IPS" | tr ","  " ");
do
#scp /mount/data/benchmark/current_scenario/hostFile.csv $ssh_jmeter_slave_user@$server:/mount/data/benchmark/current_scenario/hostFile.csv
scp ../$scenario_name/$scenario_name.csv $ssh_jmeter_slave_user@$server:$csvFile
done

echo "Running ... "

$JMETER_HOME/bin/jmeter.sh -n -t $JMX_FILE_PATH -R ${JMETER_CLUSTER_IPS} -l $SCENARIO_LOGS/${scenario_id}/logs/output.xml -j $SCENARIO_LOGS/${scenario_id}/logs/jmeter.log > $SCENARIO_LOGS/${scenario_id}/logs/scenario.log 2>&1

echo "Log file ..."
echo "$SCENARIO_LOGS/${scenario_id}/logs/scenario.log"

echo "Execution of $scenario_id Complete."
