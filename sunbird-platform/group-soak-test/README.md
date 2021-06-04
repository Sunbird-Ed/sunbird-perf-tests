Test Scenario:

Benchmarking Group Service API.

Test Environment Details:

 1. No. of Group Service Node: Min 1 to Max 12 Node
 2. Memory Config : Cpu Core: 2, RAM:3 GB
 3. Release Version: release-4.0.0

API Endpoints:
 1. /api/group/v1/create
 2. /api/group/v1/update
 3. /api/group/v1/read/${groupId}?fields=members,activities
 4. /api/group/v1/list

Execution Scenario:
Create Group: 20%
Add 5 Member(Update group API): 30%
Add 20 Activities(Update Group Api): 10%
Read Group: 30%
list: 10%

Executing the test scenario using JMeter:

./run_scenario_soak.sh <Scenario-Name>

e.g

./run_scenario_soak.sh  group-soak

Note:

    * Update CSV Data - GroupData config file, CSV Data - userToken, CSV Data - host file path before running the test script.

Test Result:

| API 	              | Concurrency Thread |    Count Samples  |   Errors% 	 | Throughput/sec  |Avg Resp Time  | 95th pct  |99th pct  |
|---------------------|:------------------:|:-----------------:|:-----------:|:---------------:|:-------------:|:---------:|:--------:|
|/api/group/v1/create | 	20% 	       |      1165540      |	  0.00%  |	   778.32	   |       232     |   	 447   |      516 |
|                     |                    |                   |             |                 |               |           |          |
|/api/group/v1/update |   30%              |     1893528       |       0.04% |     1263.6      |        218    |     479   |      621 |
|(add 5 Members)      |                    |                   |             |                 |               |           |          |
|                     |                    |                   |             |                 |               |           |          |
|/api/group/v1/update |   10%              |     1156129       |       0.04% |     772.04      |       240     |     494   |     647  |
|(add 20 Activities)  |                    |                   |             |                 |               |           |          |
|                     |                    |                   |             |                 |               |           |          |
|/api/group/v1/read   |   30%              |     1423205       |      0.04%  |     950.4       |       199     |     375   |     482  |
|                     |                    |                   |             |                 |               |           |          |
|/api/group/v1/list   |   10%              |     813062        |      0.00%  |     544.04      |       191     |     310   |     385  |
|                     |                    |                   |             |                 |               |           |          |
|                     |                    |                   |             |                 |               |           |          |
|    Total            |   100%             |     6451464       |      0.03%  |     4305.23     |       208     |     464   |     595  |