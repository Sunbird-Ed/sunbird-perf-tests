#!/bin/bash
start(){
	echo $rootOrgSize
	local i=1
	while [ $i -le $rootOrgSize ] 
	do 
    createRootOrgCql $i
    i=`expr $i + 1`
	done 
}

createRootOrgCql(){
	now=`date +%Y-%m-%d.%H:%M:%S%z`
	local query="INSERT INTO sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid) VALUES ('root-org-$1','root-org-name-$1','channel$1','$now',true,'channel$1',1,'channel$1');"
	echo $query
	if [ $1 == 1 ]
	then
		echo $query > $orgfile
	else
		echo $query >> $orgfile
	fi
}

rootOrgSize="$1"
orgfile="$2"
start