# sunbird-perf-tests
Data preparation scripts, JMX files, JMeter scripts for performance testing

Please refer this section on [Installation Details](#installation-details). This will give you details on how to setup jmeter on your machines and run the benchmarking scenarios against your infrastructure.

# Perf testing summary

### **Environment Details**

A new environment was created for this test. Here are the VMs and their configurations from the test.

![Infra View](https://github.com/Sunbird-Ed/sunbird-perf-tests/blob/master/images/LoadTestInfra.jpg)

3 Jmeter clusters (1 master + 4 slaves in each cluster) were setup to perform API testing and verifying improvements in parallel.


### Benchmarking Details
Please click on the below links to get details on the benchmark results
1. [Consumption APIs](consumption-api.md)
2. [User Management APIs](user-management-apis.md)
3. [Jmeter Installation](jmeter-installtion.md)
4. [Running the Consumption APIs](run-consumption-api.md)
5. [Running the User Management APIs](run-user-mgm-api.md)
