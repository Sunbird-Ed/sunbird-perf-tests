How To Run <br>

./run_scenario.sh ~/apache-jmeter-5.1.1/ '127.0.0.1' private-user-read private-user-read-R1 {{THREAD_SIZE}} {{RAMPUP}} {{LOOPCOUNT}} {{api_key}} {{accessTokenUrl}} {{username}} ~/sunbird-perf-tests/sunbird-platform/private-user-read/host.csv ~/sunbird-perf-tests/sunbird-platform/private-user-read/userId.csv /api/user/v1/read