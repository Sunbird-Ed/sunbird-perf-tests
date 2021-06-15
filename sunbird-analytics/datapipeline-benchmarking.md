
## Flink Benchmark Details (Telemetry Extractor Job) ##

**Pre-requisites:** Data Pipeline flink jobs are dependent on following services. These services needs to be up & running before starting flink jobs.

- **Kafka:**
   - Configuration: 3 node cluster ( 4 Core , 16 GB)
   - Data Source & sink for most of the jobs
- **Redis:**
   - Configuration: 16 Core , 128 GB
   - Used for duplicate checks & denormalisation functionality
- **Postgres:**
   - Configuration:
   - Used for Device Profile Updater job only

**Steps to follow:**
1. Check for configurations with required kafka input & output topics
2. Load data to input kafka topic
3. Update flink jobs setting to read from earliest offset in the code in below class 
   - Add ``setStartFromEarliest()`` for all Kafka Consumers under ``org.sunbird.dp.core.job.FlinkKafkaConnector``

4. Build & Deploy specific job using these jenkins job by selecting required job name - ```Build/DataPipeline/FlinkPipelineJobs``` & ```Deploy/loadtest/DataPipeline/FlinkPipelineJobs```
5. Compute throughput by checking offset on output kafka topics using below command 
```/opt/kafka/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list localhost:9092 --topic <output-topic> --time -1 | awk -F':' '{lag += $3} END {print lag}')```
   - Setup cron job to run above command every 5 mins and save it to a file
   - Compute throughput per 5 mins by getting difference from above command output


#### Benchmark result: ####
