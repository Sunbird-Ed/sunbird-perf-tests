#!/bin/bash
# usage - run.sh 4 1000000
processes=$1
eventsPerProcess=$2

for (( c=1; c<=2; c++ ))
do  
   node index.js $2 &
done