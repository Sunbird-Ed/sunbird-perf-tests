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
				   	createUserForSubOrg $i $j $k
				    k=`expr $k + 1`
			    done
		   	
		    j=`expr $j + 1`
	    done
    i=`expr $i + 1`
	done 
}

createUserForSubOrg(){
	now=`date +%Y-%m-%d.%H:%M:%S%z`
	local query="INSERT INTO sunbird.user (id, channel, email, emailverified , firstName, rootorgid,status,username,roles,createddate) VALUES ('user-$1-$2-$3','channel$1','user-$1-$2-$3@gmaol.com',true,'name-$1-$2-$3','root-org-$1',1,'username-$1-$2-$3',['PUBLIC'],'$now');"
	echo $query
	local user_root_org_query="INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-org-sub-root-$1','root-org-$1','user-$1-$2-$3','root-org-$1','$now',['PUBLIC'],false);"
	local user_sub_org_query="INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-sub-org-$1','school-$1-$2','user-$1-$2-$3','school-$1-$2','$now',['PUBLIC'],false);"

	echo curl -X POST \
      $baseurl/auth/admin/realms/master/users/user-$1-$2-$3/reset-password \
      -H \''Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJCX0d3V0RSWXMxZ0dDQzA2UGUxTnJFaGtJNzZQYVR3SUZvQUo1eEJZV19rIn0.eyJqdGkiOiIxMDE0ZmU5Yy1iN2QyLTQzYWYtYTkxMC00ZDk1OTQ5OWZhYzUiLCJleHAiOjE1NTYzMTk0NDksIm5iZiI6MCwiaWF0IjoxNTU2MjgzNDQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODAvYXV0aC9yZWFsbXMvbWFzdGVyIiwiYXVkIjoiYWRtaW4tY2xpIiwic3ViIjoiMmIzNzI5NjYtZDI0Yy00YTRmLWE4ODYtNzBkMDc3YjdiOTRjIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYWRtaW4tY2xpIiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiNzZhNGM0MTktY2Q5NC00ZDkyLWE0YjMtNDVmN2U4MmFkMzkzIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6W10sInJlc291cmNlX2FjY2VzcyI6e30sIm5hbWUiOiJtYW56YXJ1bCBoYXF1ZSIsInByZWZlcnJlZF91c2VybmFtZSI6Im1hbnphcnVsIiwiZ2l2ZW5fbmFtZSI6Im1hbnphcnVsIiwiZmFtaWx5X25hbWUiOiJoYXF1ZSIsImVtYWlsIjoibWFuemFydWwuaGFxdWVAdGFyZW50by5jb20ifQ.IEjGTIF4AL3L-Oy3nj1lJvrmQ_pKiA9MSjYBXhEwcHxFgXtQhWZex_yLaiiQVRKjgfbw-gUS75zjtUFt58hFVKSW_brouNPADD-biq0qY-TRQAR_M3yB-zmKYaWtCIv3s1Rkg9-T2eIcl00guig0u-SDRi2wDXLbTbcB0zms1YLcXETklYvQEaoNxDxi6ncqbTMfXxzyuXEzqCKVjMWR8Qvc_QCXQ8d43_jnmInG7Ltwek0WQD0eTax0L9TlvqcfF3AVrLFcGcnERbkb5cqNO83M_sHHa7iy-kuJO68aWztIOp5LZvE8p7d1Gnj_DrR4AhjgiDkyUbH2uuS5jvbWNA'\' \
      -H \''Content-Type: application/json'\' \
      -d \''{"type": "password", "value": "password", "temporary": "false"}'\' '| jq'

	 curl -X POST \
      $baseurl/auth/admin/realms/master/users/user-$1-$2-$3/reset-password \
      -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJCX0d3V0RSWXMxZ0dDQzA2UGUxTnJFaGtJNzZQYVR3SUZvQUo1eEJZV19rIn0.eyJqdGkiOiIxMDE0ZmU5Yy1iN2QyLTQzYWYtYTkxMC00ZDk1OTQ5OWZhYzUiLCJleHAiOjE1NTYzMTk0NDksIm5iZiI6MCwiaWF0IjoxNTU2MjgzNDQ5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODAvYXV0aC9yZWFsbXMvbWFzdGVyIiwiYXVkIjoiYWRtaW4tY2xpIiwic3ViIjoiMmIzNzI5NjYtZDI0Yy00YTRmLWE4ODYtNzBkMDc3YjdiOTRjIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYWRtaW4tY2xpIiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiNzZhNGM0MTktY2Q5NC00ZDkyLWE0YjMtNDVmN2U4MmFkMzkzIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6W10sInJlc291cmNlX2FjY2VzcyI6e30sIm5hbWUiOiJtYW56YXJ1bCBoYXF1ZSIsInByZWZlcnJlZF91c2VybmFtZSI6Im1hbnphcnVsIiwiZ2l2ZW5fbmFtZSI6Im1hbnphcnVsIiwiZmFtaWx5X25hbWUiOiJoYXF1ZSIsImVtYWlsIjoibWFuemFydWwuaGFxdWVAdGFyZW50by5jb20ifQ.IEjGTIF4AL3L-Oy3nj1lJvrmQ_pKiA9MSjYBXhEwcHxFgXtQhWZex_yLaiiQVRKjgfbw-gUS75zjtUFt58hFVKSW_brouNPADD-biq0qY-TRQAR_M3yB-zmKYaWtCIv3s1Rkg9-T2eIcl00guig0u-SDRi2wDXLbTbcB0zms1YLcXETklYvQEaoNxDxi6ncqbTMfXxzyuXEzqCKVjMWR8Qvc_QCXQ8d43_jnmInG7Ltwek0WQD0eTax0L9TlvqcfF3AVrLFcGcnERbkb5cqNO83M_sHHa7iy-kuJO68aWztIOp5LZvE8p7d1Gnj_DrR4AhjgiDkyUbH2uuS5jvbWNA' \
      -H 'Content-Type: application/json' \
      -d '{"type": "password", "value": "password", "temporary": "false"}' | jq

	if [ $count == 1 ]
	then
		count=`expr $count + 1`
		echo $query > $userfile
		echo $user_root_org_query > $userorgfile
		echo $user_sub_org_query >> $userorgfile
	else
		echo $user_root_org_query >> $userorgfile
		echo $user_sub_org_query >> $userorgfile
		echo $query >> $userfile	
	fi		
	 
}
count=1
rootOrgSize="$1"
subOrgSize="$2"
userSubOrgSize="$3"
baseurl="$4"
userfile="$5"
userorgfile="$6"
start
