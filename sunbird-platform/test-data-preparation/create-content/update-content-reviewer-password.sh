#!/bin/bash
start(){
	echo $rootOrgSize
	local i=1
	
	while [ $i -le $rootOrgSize ] 
	do 
		local k=1
		while [ $k -le $userSubOrgSize ]
			do
			   	updatePassword $i $k
			    k=`expr $k + 1`
		    done
    i=`expr $i + 1`
	done 
}
updatePassword(){
echo curl -X POST \
      $baseurl/auth/admin/realms/sunbird/users/f:$federationid:content-reviewer-$1-$2/reset-password \
      -H \''Authorization: Bearer '$token''\' \
      -H \''Content-Type: application/json'\' \
      -d \''{"type": "password", "value": "password", "temporary": "false"}'\' '| jq'

	 curl -X POST \
      $baseurl/auth/admin/realms/sunbird/users/f:$federationid:content-reviewer-$1-$2/reset-password \
      -H 'Authorization: Bearer '$token'' \
      -H 'Content-Type: application/json' \
      -d '{"type": "password", "value": "password", "temporary": "false"}' | jq
}

rootOrgSize="$1"
userSubOrgSize="$2"
baseurl="$3"
token="$4"
federationid="$5"
start