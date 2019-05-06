The purpose of this document is to describe the steps required to run the script to generate the course batch cql 

# Pre-requisites

Clone this repo (sunbird-perf-tests) in home directory and go to test-data-preperation folder and move to create-course-batch folder

## How to run?

Run load test scenario script with necessary arguments:

    sh create-course-batch <FILE_PATH_TO_READ_COURSE_INFO> <COURSE_BATCH_CQL>

# eg:

     sh create-course-batch course.csv course_batch.cql
    
2. `course_batch.cql` will be created in the path specified above.

    
3. Run the CQL commands generated on the cassandra server.

```
cqlsh -f course_batch.cql
```
