#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
JMETER_HOME=~/benchmark
JMETER_CLUSTER=""
choice=2

displayChoice(){
echo -e "\n\e[0;32m${bold}Please check the above output..${normal}"
echo -e "\e[0;35m${bold}Choose 1 if all input data is correct${normal}"
echo -e "\e[0;35m${bold}Choose 2 to re-enter the data${normal}"
echo -e "\e[0;35m${bold}Choose 3 to quit the setup${normal}"
}

clusterData(){
echo -e "\e[0;33m${bold}Please enter the jmeter cluster IP's with , as delimiter between IP's. The first IP will be considered as master IP. Do not input spaces!${normal}"
read -p 'Jmeter cluster IPs: ' JMETER_CLUSTER

echo -e "\n\e[0;32m${bold}This will be your jmeter cluster${normal}"
JMETER_MASTER=$(echo $JMETER_CLUSTER | awk -F "," '{print $1}')
JMETER_SLAVES=$(echo $JMETER_CLUSTER | cut -d ',' -f1 --complement)
echo "JMETER_MASTER = $JMETER_MASTER"
echo "JMETER_SLAVES = $JMETER_SLAVES"
}

if [ ! -d "$JMETER_HOME/apache-jmeter-4.0" ]; then
echo -e "\n\e[0;32m${bold}Creating jmeter directories in your home${normal}"
mkdir -p $JMETER_HOME
mkdir -p $JMETER_HOME/logs
mkdir -p $JMETER_HOME/current_scenario

echo -e "\n\e[0;32m${bold}Download jmeter${normal}"
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-4.0.tgz

echo -e "\n\e[0;32m${bold}Extracting jmeter${normal}"
tar -xf apache-jmeter-4.0.tgz -C $JMETER_HOME
rm -rf apache-jmeter-4.0.tgz

echo -e "\n\e[0;32m${bold}Updating jmeter property files${normal}"
cp jmeter_properties/jmeter.properties $JMETER_HOME/apache-jmeter-4.0/bin/
cp jmeter_properties/jmeter $JMETER_HOME/apache-jmeter-4.0/bin/

echo -e "\n\e[0;32m${bold}Copying scenario and script files to jmeter home${normal}"
pwd
cp -r ./scripts $JMETER_HOME
cp -r ./scenarios $JMETER_HOME
cp -r ./testdata $JMETER_HOME


clusterData
displayChoice

while true; do
read -p 'Please enter your choice: ' choice
case $choice in
     1) echo -e "\n\e[0;32m${bold}Continuing setup..${normal}"
	break
	;;
     2) echo -e "\n\e[0;32m${bold}Please re-enter the data..${normal}"
	clusterData
	displayChoice
	continue
	;;
     3) echo -e "\n\e[0;31m${bold}Aborted..${normal}"
	exit
	;;
     *) echo -e "\n\e[0;32m${bold}Invalid option. Please enter correct choice${normal}"
	displayChoice
	;;
esac
done

echo -e "\n\e[0;32m${bold}Installing openjdk8 and openjfx${normal}"
sudo apt install openjdk-8-jdk
sudo apt install openjfx

echo -e "\n\e[0;32m${bold}Updating run_scenario.sh with Jmeter cluster info${normal}"
sed -i "s/JMETER_CLUSTER_REPLACE/$JMETER_SLAVES/g" $JMETER_HOME/scripts/run_scenario.sh
echo -e "\n\e[0;32m${bold}Setup complete. Please follow the documentation on the steps to run the scenarios${normal}"

else
echo -e "\n\e[0;33m${bold}~/benchmark directory already exists. Skipping installation..${normal}"
fi
