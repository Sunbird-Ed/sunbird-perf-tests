#!/bin/bash

rm *.txt
rm *.json
rm /Users/anmolgupta/sunbird-perf-tests/sunbird-platform/logs/user-create-with-course-batch-enrol/modifieds_t_1/logs/scenario.log
rm /Users/anmolgupta/sunbird-perf-tests/sunbird-platform/logs/user-create-with-course-batch-enrol/modifieds_t_1/logs/output.xml 
./generate-test-data.sh 10 10 10 1
