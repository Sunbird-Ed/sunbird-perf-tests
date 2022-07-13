## Progres Exhaust Job Test Run Details

**Pre-requisites:** To run the progres exhaust job following services/VMs needs to be up and running before running the test

**1. Provision SparkHDinsightCluster**
- **Configuration:**
  
   - No of headnode: 2
  
  - No of workernode:16
  
   - Head Node configuration: E4 V3 (4 Cores, 32 GB RAM)
  
   - Worker Node configuration: E16 V3 (16 Cores, 128 GB RAM)
  
   - spark.driver.memory: "100g"
   
   - Job version: progress-exhaust
  
   - jobs_submit_type: parallel-jobs-submit
  
   - dynamic_allocation: False 
  
**2. Data Exhaust - Request API:** 
  - This API is required to submit the requests.
  
**3. Cassandra Cluster:**
  - Configuration: 11 Nodes Cluster (16Core, 64GB)
  
**4. Postgres:**
  - Configuration:
  
**5. Redis:**
  - Configuration: 1 node (64core, 256GB)

##Steps to follow:
  1. Provision the SparkHDinsightCluster with required head node and worker node configuration (/job/Provision/job/loadtest/job/DataPipeline/job/SparkHDinsightCluster/)
  2. Submit the progres exhaust requests using Data Exhaust - Request API
  3. Submit the SparkClusterSubmitJobs job from jenkins (/job/Deploy/job/loadtest/job/DataPipeline/job/SparkClusterSubmitJobs/)

## Test Result:
***Note**: Total batches: 1000 (20 course batches per request)
| No of Requests | Parallelism| Spark Worker Nodes | Cassandra CPU Usage (max) | Time Taken (Hours) | Failure|
|--------------|----------|--------------|----------|----------|----------|
|50            |1         |16            |22%       |11        |0         |
|50            |2         |16            |32%       |7.5       |0         |
|50            |4         |16            |62%       |6         |0         |
|50            |5         |16            |74%       |5         |0         |
