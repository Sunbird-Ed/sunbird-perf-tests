How to run ?

./run_scenario.sh <JMETER_HOME> <JMETER_IP_LIST> <SCENARIO_NAME> <SCENARIO_ID> <THREADS_COUNT> <RAMPUP_TIME> <CTRL_LOOPS> <API_KEY> <DOMAIN_FILE> <CSV_FILE> <pathPrefix>

e.g.

./run_scenario.sh ~/apache-jmeter-5.3/ 'Jmeter_Slave1_IP,Jmeter_Slave2_IP,Jmeter_Slave3_IP,Jmeter_Slave4_IP' group-delete group-delete-ID01 5 1 5 "ABCDEFabcdef012345" ~/sunbird-platform/group-delete/host.csv ~/sunbird-platform/group-delete/groupData.csv /api/group/v1/delete
