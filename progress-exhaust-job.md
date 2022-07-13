## Progres Exhaust Job Details

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

**Steps to follow:**

**Test Result:** 
