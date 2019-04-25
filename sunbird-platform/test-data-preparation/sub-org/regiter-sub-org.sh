#!/bin/bash
start(){
	echo $rootOrgSize
	echo $baseurl
	local i=1
	while [ $i -le $rootOrgSize ] 
	do 
		local j=1
		while [ $j -le $subOrgSize ]
		do
			 registerSubOrg $i $j		
   			
			 j=`expr $j + 1`
		done	 
    i=`expr $i + 1`
	done 
}

registerSubOrg(){

	if [ $exec == true ]
	  then  	
	  	echo curl -X POST \
		  $baseurl/tag/register/school-$1-$2\
		  -H \''Content-Type: application/json' \' \
		  -H \''Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0YzZhNjhiMWMzNDc0YmZiYjM5NGI0MDYwODVjZjRhZiJ9.0ZRY7Ya87ZKJl8Wj7a9uIbROivP0b2KpUOjKgLwnLQE'\' \
		  -d \''{}' \' '| jq' 
		 curl -X POST \
		  $baseurl/tag/register/school-$1-$2\
		  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0YzZhNjhiMWMzNDc0YmZiYjM5NGI0MDYwODVjZjRhZiJ9.0ZRY7Ya87ZKJl8Wj7a9uIbROivP0b2KpUOjKgLwnLQE' \
		  -d '{}' | jq
		else
		echo curl -X POST \
		  $baseurl/tag/register/school-$1-$2\
		  -H \''Content-Type: application/json' \' \
		  -H \''Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI0YzZhNjhiMWMzNDc0YmZiYjM5NGI0MDYwODVjZjRhZiJ9.0ZRY7Ya87ZKJl8Wj7a9uIbROivP0b2KpUOjKgLwnLQE'\' \
		  -d \''{}'\' '| jq' 
	fi	  
}

rootOrgSize="$1"
subOrgSize="$2"
baseurl="$3"
exec="$4"
start
