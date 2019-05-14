#!/bin/bash

start=$1
end=$2

if [ -f /mount/data/benchmark/scenarios/input_data.csv ]
then
	rm /mount/data/benchmark/scenarios/input_data.csv
fi

for i in `seq $start $end`
do
    echo "LP_PT_$i,LP_PT_$i" >> /mount/data/benchmark/scenarios/create_input_data.csv
done