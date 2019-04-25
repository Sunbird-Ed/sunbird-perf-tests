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
	if [ $exec == true ]
  then  
    echo  'curl -X POST \
      '$baseurl'/learning-service/channel/v3/create \
      -H \''Content-Type: application/json'\'' \
      -d \'{"request":{"channel":{"name":"'channel$1'","description":"Channel for 'channel$1'","code":"'channel$1'"}}}''\'
      
     curl -X POST \
      $baseurl/learning-service/channel/v3/create \
      -H 'Content-Type: application/json' \
      -d '{"request":{"channel":{"name":"'channel$1'","description":"Channel for 'channel$1'","code":"'channel$1'"}}}'
  else
    echo  'curl -X POST \
      '$baseurl'/learning-service/channel/v3/create \
      -H 'Content-Type: application/json' \
      -d '{"request":{"channel":{"name":"'channel$1'","description":"Channel for 'channel$1'","code":"'channel$1'"}}}''
  fi    
}

rootOrgSize="$1"
baseurl="$2"
exec="$3"
start