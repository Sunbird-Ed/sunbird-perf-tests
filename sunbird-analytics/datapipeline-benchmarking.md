
## Flink Benchmark Details ##

**Pre-requisites:** Data Pipeline flink jobs are dependent on following services. These services needs to be up & running before starting flink jobs.

- Kafka:
   - Configuration:
   - Data Source & sink for most of the jobs
- Redis:
   - Configuration:
   - Used for duplicate checks & denormalisation functionality
- Postgres:
   - Configuration:
   - Used for Device Profile Updater job only

**Steps to follow:**
- Check for configurations with required kafka input & output topics
