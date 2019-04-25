#!/bin/bash
start(){
	echo $rootOrgSize
	local i=1
	
	while [ $i -le $rootOrgSize ] 
	do 
		local j=1
		while [ $j -le $subOrgSize ]
		do
    		createSubOrgCql $i $j
    		j=`expr $j + 1`
    	done
    i=`expr $i + 1`
	done 
}

createSubOrgCql(){
	now=`date +%Y-%m-%d.%H:%M:%S%z`
	# echo $now
	local query="INSERT INTO sunbird.organisation (id, orgName, channel, createddate, isrootorg,slug,status, hashtagid,rootorgid) VALUES ('school-$1-$2','school-name-$1-$2','channel$1','$now',false,'channel$1',1,'school-$1-$2','root-org-$1');"
	echo $query
	if [ $count == 0 ]
	then
		echo $count
		count=`expr $count + 1`
		echo $query > $suborgfile
	else
		echo $count
		echo $query >> $suborgfile
	fi

}
count=0
rootOrgSize="$1"
subOrgSize="$2"
suborgfile="$3"
start