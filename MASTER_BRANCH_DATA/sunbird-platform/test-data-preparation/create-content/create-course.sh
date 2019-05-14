#!/bin/bash
start(){
	echo $rootOrgSize
	local i=1
	
	while [ $i -le $rootOrgSize ] 
	do 
		local j=1
		while [ $j -le $numberOfCourse ]
		do
    		createCourse $i $j
    		j=`expr $j + 1`
    	done
    i=`expr $i + 1`
	done 
}

createCourse(){
	# echo $now
	echo curl -X POST \
  $baseUrl/content/v1/create \
  -H \''Authorization: Bearer '$authKey''\' \
  -H \''Content-Type: application/json'\' \
  -H \''X-Channel-Id: channel'\' \
  -d \''{
	"request": {
		"content": {
			"osId": "org.ekstep.quiz.app",
			"mediaType": "content",
			"visibility": "Default",
			"description": "Course Test",
			"name": "Course TestCourse test$1$2",
			"language": [
				"English"
			],
			"contentType": "Course",
			"code": "SB_FT_COURSE_$1$2",
			"tags": [
				"QA_Content"
			],
			"mimeType": "application/vnd.ekstep.content-collection",
			"children": [],
			"createdBy": "'$userId'"
		}
	}
}'
 courseId=`curl -X POST \
  $baseUrl/content/v1/create \
  -H 'Authorization: Bearer '$authKey'' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 8280ac0a-fc15-449e-9e8d-b3e2a1558c77' \
  -H 'X-Channel-Id: channel' \
  -H 'cache-control: no-cache' \
  -d '{
	"request": {
		"content": {
			"osId": "org.ekstep.quiz.app",
			"mediaType": "content",
			"visibility": "Default",
			"description": "Course Test",
			"name": "Course TestCourse test$1$2",
			"language": [
				"English"
			],
			"contentType": "Course",
			"code": "SB_FT_COURSE_$1$2",
			"tags": [
				"QA_Content"
			],
			"mimeType": "application/vnd.ekstep.content-collection",
			"children": [],
			"createdBy": "a02bce3d-8f1f-4c6f-ab4d-b71b7e9c007a"
		}
	}
}' | jq  '.result.content_id' `
		courseId="${courseId%\"}"
		courseId="${courseId#\"}"
		echo courseId "$courseId"

	updateHierarchy $courseId
	if [ $count == 0 ]
	then
		count=`expr $count + 1`
		echo $courseId > $file
	else
		
		echo $courseId >> $file
	fi
}
updateHierarchy(){
		token=`curl -X POST \
				  $authUrl/auth/realms/sunbird/protocol/openid-connect/token \
				  -H 'Content-Type: application/x-www-form-urlencoded' \
				  -H 'Postman-Token: 03fb2525-c0c9-4619-9def-bbe955b3a335' \
				  -H 'cache-control: no-cache' \
				  -d 'client_id=admin-cli&username='$username'&password=password&grant_type=password&undefined='	 | jq '.access_token'`
		token="${token%\"}"
		token="${token#\"}"
		echo "$token"

		echo curl -X PATCH \
		  $baseUrl/course/v1/hierarchy/update \
		  -H \''Authorization: Bearer '$authKey''\' \
		  -H \''Content-Type: application/json'\' \
		  -H \''X-Channel-Id: channel'\' \
		  -H \''x-authenticated-user-token: '$token'' \'\
		  -d \''{
		  "request": {
		    "data": {
		      "nodesModified": {
		        "SB_FT_COURSEUNIT_0c329402-24f3-49c7-aef7-a1750d3248e5": {
		          "isNew": true,
		          "root": false,
		          "metadata": {
		            "mimeType": "application/vnd.ekstep.content-collection",
		            "contentType": "CourseUnit",
		            "code": "SB_FT_COURSEUNIT_0c329402-24f3-49c7-aef7-a1750d3248e5",
		            "name": "Test_CourseUnit_name_2232820492",
		            "description": "Test_CourseUnit_desc_5656073181"
		          }
		        }
		      },
		      "hierarchy": {
		        "$1": {
		          "contentType": "Course",
		          "children": [
		            "SB_FT_COURSEUNIT_0c329402-24f3-49c7-aef7-a1750d3248e5"
		          ],
		          "root": true
		        },
		        "SB_FT_COURSEUNIT_0c329402-24f3-49c7-aef7-a1750d3248e5": {
		          "contentType": "CourseUnit",
		          "children": [
		            "do_112728688963133440110506"
		          ],
		          "root": false
		        },
		        "do_112728688963133440110506": {
		          "name": "Test_Story_name_3276393653",
		          "contentType": "Resource",
		          "children": [],
		          "root": false
		        }
		      }
		    }
		  }
		}' 
	 curl -X PATCH \
		  $baseUrl/course/v1/hierarchy/update \
		  -H 'Authorization: Bearer '$authKey'' \
		  -H 'Content-Type: application/json' \
		  -H 'X-Channel-Id: channel'\' \
		  -H 'x-authenticated-user-token: '$token'' \
		  -d '{
		  "request": {
		    "data": {
		      "nodesModified": {
		        "SB_FT_COURSEUNIT_0c329402-24f3-49c7-aef7-a1750d3248e5": {
		          "isNew": true,
		          "root": false,
		          "metadata": {
		            "mimeType": "application/vnd.ekstep.content-collection",
		            "contentType": "CourseUnit",
		            "code": "SB_FT_COURSEUNIT_0c329402-24f3-49c7-aef7-a1750d3248e5",
		            "name": "Test_CourseUnit_name_2232820492",
		            "description": "Test_CourseUnit_desc_5656073181"
		          }
		        }
		      },
		      "hierarchy": {
		        '$1': {
		          "contentType": "Course",
		          "children": [
		            "SB_FT_COURSEUNIT_0c329402-24f3-49c7-aef7-a1750d3248e5"
		          ],
		          "root": true
		        },
		        "SB_FT_COURSEUNIT_0c329402-24f3-49c7-aef7-a1750d3248e5": {
		          "contentType": "CourseUnit",
		          "children": [
		            "do_112728688963133440110506"
		          ],
		          "root": false
		        },
		        "do_112728688963133440110506": {
		          "name": "Test_Story_name_3276393653",
		          "contentType": "Resource",
		          "children": [],
		          "root": false
		        }
		      }
		    }
		  }
		}' | jq

		publishCourse $1
}

publishCourse(){
	token=`curl -X POST \
				  $authUrl/auth/realms/sunbird/protocol/openid-connect/token \
				  -H 'Content-Type: application/x-www-form-urlencoded' \
				  -H 'Postman-Token: 03fb2525-c0c9-4619-9def-bbe955b3a335' \
				  -H 'cache-control: no-cache' \
				  -d 'client_id=admin-cli&username='$usernamereviewer'&password=password&grant_type=password&undefined='	 | jq '.access_token'`
		token="${token%\"}"
		token="${token#\"}"
		echo "$token"

		echo curl -X POST \
		  $baseUrl/content/v1/publish/"$1" \
		  -H \''Authorization: Bearer '$authKey''\' \
		  -H \''Content-Type: application/json'\' \
		  -H \''X-Channel-Id: channel'\' \
		  -H \''x-authenticated-user-token: '$token'' \'\
		  -d \''{
    			"request": {
	        "content" : {
	            "lastPublishedBy" : "SunBird_FT"
	        }
    		}
			}' \'

		
	 curl -X POST \
		  $baseUrl/content/v1/publish/"$1" \
		  -H 'Authorization: Bearer '$authKey'' \
		  -H 'Content-Type: application/json' \
		  -H 'X-Channel-Id: channel'\' \
		  -H 'x-authenticated-user-token: '$token'' \
		  -d '{
		    "request": {
		        "content" : {
		            "lastPublishedBy" : "SunBird_FT"
		        }
		    }
		}'
}

count=0
rootOrgSize="$1"
numberOfCourse="$2"
baseUrl="$3"
authUrl="$4"
userId="$5"
username="$6"
usernamereviewer="$7"
authKey="$8"
file="$9"
start