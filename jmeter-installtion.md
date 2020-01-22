## Installation Details

#### Jmeter machine requirements
* At least 2 core, 4GB RAM, Ubuntu 16.04
* Port 1099 to be open between master and slaves for jmeter to communicate if two machines are used.

#### Jmeter setup on master
_Note: Same user must be present on both master and slave since we will be copying the files folder under ~ directory. The script can be changd to install the files and folder under a common location like /mount which will be availble on both systems. In this case the user name will not matter._

1. Clone this repo on your jmeter master machine by running 
2. **git clone https://github.com/Sunbird-Ed/sunbird-perf-tests**
3. **cd sunbird-perf-tests/initial-setup**
4. **./setup_jmeter.sh**
5. Follow the onscreen instructions and provide input for the script.

The scenarios and jmeter binary will be installed in the current user's home directory.

#### Details on csv input data for jmeter scenarios

**bearer.csv**

In this file, enter the jwt bearer key of your sunbird installation.

**channel.csv**

In this file, enter the channel id's from your sunbird installation.

**collections.csv**

In this file, enter the do_id's of collections from your sunbird installation.

**content.csv**

In this file, enter the do_id's (content id's) from your sunbird installation.

**dialcodes.csv**

In this file, enter the dial codes (QR codes) of contents from your sunbird installation.

**frameworks.csv**

In this file, enter the framework id's from your sunbird installation.

**orgs.csv**

In this file, enter the org id's from your sunbird installation. 

**tenants.csv**

In this file, enter the tenant id's from your sunbird installation. 

**urls.csv**

In this file, enter the IP's of your machines or your sunbird domain.




#### Details on variables used in jmeter scenario files

**THREADS_COUNT**

This defines the number of threads for the scenario under execution

**RAMPUP_TIME**

This defines the ramp up time for the scenario under exectuion

**CTRL_LOOPS**

This defines the number of loops that the scenario should run

**PROTOCOL**

This is the protocol used to connect to your sunbird installation (http / https). If your domain has SSL certificate, use https. If not use http.

**PORT**

This defines the port which should be used for connecting to your sunbird installtion. It can be 443, 8080, 9000 etc. Please see examples below to understand this better.

**DATADIR**

This defines the path where your data directory resides. By default this is ~/benchmark/testdata



#### Jmeter setup on slaves (If using more than one jmeter machine)
1. Copy the ~/benchmark/apache-jmeter-4.0 and ~/benchmark/testdata directory from your jmeter master to jmeter slaves
2. **`mkdir ~/benchmark && scp -r username@jmeter_master:~/benchmark/\{apache-jmeter-4.0,testdata\} ~/benchmark/`**


#### Starting jmeter server on master and slaves
1. Start the jmeter server by using below command on the master and all slaves.
2. **nohup ~/benchmark/apache-jmeter-4.0/bin/jmeter-server &**


#### Few points to be noted
1. The **jmeter-server** must be running on master and slaves before starting the tests.
2. The testdata directory must be present under ~/benchmark/ in master and all slaves.
3. If there is a change in the csv files, this should be copied to all servers in the jmeter cluster.
4. The scenario files can reside only in master and it need not be present in slaves.
5. If there are connection issues while starting the run, kill and restart the **jmeter-server** process on the machines where the issue exists.
6. If there are connection issues or you want to stop a scenario test which is currently running, use the command **~/benchmark/apache-jmeter-4.0/bin/stoptest.sh** on the master. This will notifiy the slaves and stop the current running test.
7. All the CSV files needs to be updated with contents before starting the test.
8. All scenarios can be run using a single jmeter server.
