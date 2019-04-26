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
	if [ $exec == true ]
  	then  
    echo  curl -X POST \
      $baseurl/api/v2/user/create \
      -H \''Content-Type: application/json'\' \
      -d \' '{"request":{"firstName":"'name-$1-$2-$3'","email":"'user-$1-$2-$3@gmaol.com'","emailVerified":true,"channel":"'channel$1'","organisationId":"'school-$1-$2'"}}' \' '| jq' 

     curl -X POST \
      $baseurl/api/v2/user/create \
      -H 'Content-Type: application/json' \
      -d '{"request":{"firstName":"'name-$1-$2-$3'","email":"'user-$1-$2-$3@gmaol.com'","emailVerified":true,"channel":"'channel$1'","organisationId":"'school-$1-$2'"}}' | jq

  else
    echo  curl -X POST \
      $baseurl/api/user/v2/create \
      -H \''Content-Type: application/json'\' \
      -d \' '{"request":{"firstName":"'name-$1-$2-$3'","email":"'user-$1-$2-$3@gmaol.com'","emailVerified":true,"channel":"'channel$1'","organisationId":"'school-$1-$2'"}}' \' '| jq' 

  fi 

	# local query="INSERT INTO sunbird.user (id, channel, email, emailverified , firstName, rootorgid,status,username,roles,createddate) VALUES ('user-$1-$2-$3','channel$1','user-$1-$2-$3@gmaol.com',true,'name-$1-$2-$3','root-org-$1',1,'username-$1-$2-$3',['PUBLIC'],'$now');"
	# echo $query
	# local user_root_org_query="INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-org-sub-root-$1','root-org-$1','user-$1-$2-$3','root-org-$1','$now',['PUBLIC'],false);"
	# local user_sub_org_query="INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-sub-org-$1','school-$1-$2','user-$1-$2-$3','school-$1-$2','$now',['PUBLIC'],false);"
	
	# echo $rootOrgSize
	# if [ $count == 1 ]
	# then
	# 	count=`expr $count + 1`
	# 	echo $query > $userfile
	# 	echo $user_root_org_query > $userorgfile
	# 	echo $user_sub_org_query >> $userorgfile
	# else
	# 	echo $user_root_org_query >> $userorgfile
	# 	echo $user_sub_org_query >> $userorgfile
	# 	echo $query >> $userfile	
	# fi		
	 
}
count=1
rootOrgSize="$1"
subOrgSize="$2"
userSubOrgSize="$3"
baseurl="$4"
exec="$5"
start