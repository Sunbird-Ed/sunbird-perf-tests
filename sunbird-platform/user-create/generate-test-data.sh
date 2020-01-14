#!/bin/sh
generateUserData(){
	rm user-create-test-data.csv
	echo "firstName,userName,email" >> user-create-test-data.csv
	
	local counter=1
	while [ $counter -le $nonCustodianOrgUserCount ]
	do
		local name=$startTime-$counter
		local email=$name@yopmail.com
		echo $name,$name,$email >> user-create-test-data.csv
		counter=`expr $counter + 1`
	done
	echo $(($counter-1)) non-custodian users data generated

	local counter=1
	while [ $counter -le $custodianOrgUserCount ]
	do
		local name=$startTime-$(($counter+$nonCustodianOrgUserCount))
		local email=$name@yopmail.com
		echo $name,$name,$email, >> user-create-test-data.csv
		counter=`expr $counter + 1`
	done
	echo $(($counter-1)) custodian users data generated
}

rootOrgCount=$1
subOrgCount=$2
nonCustodianOrgUserCount=$3
custodianOrgUserCount=$4
totalUserRecords=$(($3+$4))
echo generating user data - $totalUserRecords records
startTime=$(date +%s)
echo start-time in epoch seconds - $startTime
generateUserData
echo end-time in epoch seconds - $(date +%s)
