#!/bin/bash
start(){
	echo $rootOrgSize
	local i=1
	while [ $i -le $rootOrgSize ] 
	do 
    registerChannel $i
    i=`expr $i + 1`
	done 
}

registerChannel(){
	
curl -X POST \
  $baseurl/learning-service/channel/v3/create \
  -H 'Accept: */*' \
  -d '{"request":{"channel":{"name":"'channel$1'","description":"Channel for 'channel$1'","code":"'channel$1'"}}}'
}

rootOrgSize="$1"
baseurl="$2"
start