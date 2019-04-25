#!/bin/bash
start(){
	echo $rootOrgSize
	echo $baseurl
	local i=1
	while [ $i -le $rootOrgSize ] 
	do 
    registerRootOrg $i
    i=`expr $i + 1`
	done 
}

registerRootOrg(){

	if [ $exec == true ]
	  then  	
	  	echo curl -X POST \
		  $baseurl/tag/register/root-org-$1\
		  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0YzZhNjhiMWMzNDc0YmZiYjM5NGI0MDYwODVjZjRhZiJ9.0ZRY7Ya87ZKJl8Wj7a9uIbROivP0b2KpUOjKgLwnLQE' \
		  -d '{}'
		 curl -X POST \
		  $baseurl/tag/register/root-org-$1\
		  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0YzZhNjhiMWMzNDc0YmZiYjM5NGI0MDYwODVjZjRhZiJ9.0ZRY7Ya87ZKJl8Wj7a9uIbROivP0b2KpUOjKgLwnLQE' \
		  -d '{}'
		else
		echo curl -X POST \
		  $baseurl/tag/register/root-org-$1\
		  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0YzZhNjhiMWMzNDc0YmZiYjM5NGI0MDYwODVjZjRhZiJ9.0ZRY7Ya87ZKJl8Wj7a9uIbROivP0b2KpUOjKgLwnLQE' \
		  -d '{}'
	fi	  
}

rootOrgSize="$1"
baseurl="$2"
exec="$3"
start