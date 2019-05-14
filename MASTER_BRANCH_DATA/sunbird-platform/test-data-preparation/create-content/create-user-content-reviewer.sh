
#!/bin/bash
start(){
	echo $rootOrgSize
	local i=1
	while [ $i -le $rootOrgSize ] 
	do 	
		local j=1
		while [ $j -le $userSize ] 
		do 
			createUserForRootOrgAsReviewer $i $j
			j=`expr $j + 1`
		done

    i=`expr $i + 1`
	done 
}


createUserForRootOrgAsReviewer(){
	now=`date +%Y-%m-%d.%H:%M:%S%z`
	local query="INSERT INTO sunbird.user (id, channel, email, emailverified , firstName, rootorgid,status,username,roles,createddate) VALUES ('content-reviewer-$1-$2','channel$1','content-reviewer-$1@gmaol.com',true,'content-reviewer-$1-$2','root-org-$1',1,'content-reviewer-$1-$2',['PUBLIC'],'$now');"
	echo $query
	local user_root_org_query="INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-org-root-reviewer-$1','root-org-$1','content-reviewer-$1-$2','root-org-$1','$now',['PUBLIC','CONTENT_REVIEWER'],false);"
	echo $user_root_org_query
	if [ count == 1 ]
	then
		count=`expr $count + 1`
		echo $query > $cretorUserFile
		echo $user_root_org_query > $cretorUserOrgFile
	else
		echo $query >> $cretorUserFile	
		echo $user_root_org_query >> $cretorUserOrgFile
	fi
	
	
}
count=0
rootOrgSize="$1"
userSize="$2"
cretorUserFile="$3"
cretorUserOrgFile="$4"
start