#!/bin/bash

start(){
	now=`date +%Y-%m-%d`
	count=1;
	while read  courseId type ceatedFor; do
		count=`expr $count + 1`
		local query="INSERT INTO sunbird.course_batch (id, courseid, createdfor, description, enrollmenttype,startdate,status, hashtagid,rootorgid) VALUES ('course_batch-$type-$count','$courseId',['$createdFor'],'Cousrse description','$type','$now',1,'course_batch-$count');"
		if [ $count == 0 ]
	then
		echo $query > $coursebatch
	else
		echo $query >> $coursebatch
	fi

	done < "$file"	
}
file="$1"
coursebatch="$2"
start