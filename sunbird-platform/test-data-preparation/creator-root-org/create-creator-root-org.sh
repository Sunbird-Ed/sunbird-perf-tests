
#!/bin/bash
start(){
	echo $rootOrgSize
	local i=1
	while [ $i -le $rootOrgSize ] 
	do 	
		local j=1
		while [ $j -le $rootOrgUserSize ] 
		do 
			createUserForRootOrgAsCreator $i $j
			j=`expr $j + 1`
		done

    i=`expr $i + 1`
	done 
}


createUserForRootOrgAsCreator(){
	now=`date +%Y-%m-%d.%H:%M:%S%z`
	local query="INSERT INTO sunbird.user (id, channel, email, emailverified , firstName, rootorgid,status,username,roles,createddate) VALUES ('creator-$1-$2',channel$1,'creator-$1@gmaol.com',true,'name-creator-$1-$2','root-org-$1',1,'creatorusername-$1-$2',['Public','BOOK_CREATOR','CONTENT_CREATOR'],$now);"
	echo $query
	local user_root_org_query="INSERT INTO sunbird.user_org (id, organisationid,userid, hashtagid,orgjoindate,roles,isdeleted ) VALUES ('user-org-root-creator-$1','root-org-$1','creator-$1-$2','root-org-$1',$now,['Public','BOOK_CREATOR','CONTENT_CREATOR'],false);"
	if [ $1 == 1 ]
	then
		echo $query > $cretorUserFile
		echo $user_root_org_query > $cretorUserOrgFile
	else
		echo $query >> $cretorUserFile	
		echo $user_root_org_query >> $cretorUserOrgFile
	fi
	
	
}

rootOrgSize="$1"
rootOrgUserSize="$2"
cretorUserFile="$3"
cretorUserOrgFile="$4"
start