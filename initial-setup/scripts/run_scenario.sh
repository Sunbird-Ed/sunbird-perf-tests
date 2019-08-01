#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

if [ $# -ne 7 ]; then
echo -e "\n\e[0;31m${bold}Please enter 7 arguments exactly${normal}"
echo -e "\n\e[0;33m${bold}The args list in sequece are as follows${normal}"
echo -e "\n\e[0;33m${bold}1. Scenario ID - This will be directory name where the log files will be saved${normal}"
echo -e "\n\e[0;33m${bold}2. Number of threads${normal}"
echo -e "\n\e[0;33m${bold}3. Ramp up time${normal}"
echo -e "\n\e[0;33m${bold}4. Number of loops${normal}"
echo -e "\n\e[0;33m${bold}5. Protocol - http / https${normal}"
echo -e "\n\e[0;33m${bold}6. Port number${normal}"
echo -e "\n\e[0;33m${bold}7. JMX file name you would like to run. Provide only file name. Check scenarios directory${normal}"
exit 1
fi

scenario_id=$1
numThreads=$2
rampupTime=$3
ctrlLoops=$4
protocol=$5
port=$6
JMX_FILE=$7

JMETER_HOME=~/benchmark
SCENARIO_LOGS=~/benchmark/logs
datadir=$JMETER_HOME/testdata

echo "Executing $scenario_id"
JMX_FILE_PATH=~/benchmark/scenarios/$7

mkdir -p $JMETER_HOME/logs/$scenario_id
mkdir -p $JMETER_HOME/logs/$scenario_id/logs
mkdir -p $JMETER_HOME/logs/$scenario_id/server/
cp $JMX_FILE_PATH $JMETER_HOME/current_scenario/

JMX_FILE_PATH=$JMETER_HOME/current_scenario/$7

sed -i "s/THREADS_COUNT/${numThreads}/g" $JMX_FILE_PATH
sed -i "s/RAMPUP_TIME/${rampupTime}/g" $JMX_FILE_PATH
sed -i "s/CTRL_LOOPS/${ctrlLoops}/g" $JMX_FILE_PATH
sed -i "s/PORT/${port}/g" $JMX_FILE_PATH
sed -i "s#DATADIR#${datadir}#g" $JMX_FILE_PATH
sed -i "s/PROTOCOL/${protocol}/g" $JMX_FILE_PATH

cp $JMX_FILE_PATH $SCENARIO_LOGS/$scenario_id/logs

echo "Check logs at $JMETER_HOME/logs/$scenario_id/logs/scenario.log"

nohup $JMETER_HOME/apache-jmeter-4.0/bin/jmeter.sh -n -t $JMX_FILE_PATH -RJMETER_CLUSTER_REPLACE -l $SCENARIO_LOGS/$scenario_id/logs/output.xml -e -o $SCENARIO_LOGS/$scenario_id/logs/summary -j $SCENARIO_LOGS/$scenario_id/logs/jmeter.log > $SCENARIO_LOGS/$scenario_id/logs/scenario.log 2>&1 &


echo "Execution of $scenario_id Complete."
