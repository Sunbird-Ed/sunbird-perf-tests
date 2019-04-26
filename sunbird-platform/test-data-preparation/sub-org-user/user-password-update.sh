#!/bin/bash
start(){
	echo $rootOrgSize
	local i=1
	
	while [ $i -le $rootOrgSize ] 
	do 	
		local j=1
		while [ $j -le $subOrgSize ]
		do
			local k=1
			while [ $k -le $userSubOrgSize ]
				do
				   	updatePassword $i $j $k
				    k=`expr $k + 1`
			    done
		   	
		    j=`expr $j + 1`
	    done
    i=`expr $i + 1`
	done 
}
updatePassword(){
echo curl -X POST \
      $baseurl/auth/admin/realms/master/users/user-$1-$2-$3/reset-password \
      -H \''Authorization: Bearer '$token''\' \
      -H \''Content-Type: application/json'\' \
      -d \''{"type": "password", "value": "password", "temporary": "false"}'\' '| jq'

	 curl -X POST \
      $baseurl/auth/admin/realms/master/users/user-$1-$2-$3/reset-password \
      -H 'Authorization: Bearer '$token'' \
      -H 'Content-Type: application/json' \
      -d '{"type": "password", "value": "password", "temporary": "false"}' | jq
}

rootOrgSize="$1"
subOrgSize="$2"
userSubOrgSize="$3"
baseurl="$4"
token="$5"
start