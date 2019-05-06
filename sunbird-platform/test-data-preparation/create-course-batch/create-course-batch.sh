#!/bin/bash

start(){
	now=`date +%Y-%m-%d`
	count=1;
	IFS=","

while read f1 f2 f3 f4
do
		count=`expr $count + 1`
        echo "Line is : $f1 $f2 $f3 $f4"
        local query="INSERT INTO sunbird.course_batch (id, courseid, createdfor, description, enrollmenttype,startdate,status, hashtagid,rootorgid,createdby) VALUES ('course_batch-$f2-$count','$f1',['$f3'],'Cousrse description','$f2','$now',1,'course_batch-$count',"$f4");"
        echo $query
        if [ $count == 1 ]
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