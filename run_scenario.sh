#!/bin/bash

# Variables

LOOPCOUNT=$1
RAMPUPTIME=$2
THREADNUM=$3

PORT=443
PROTOCOL=https
DATA_DIR=/mount/data/benchmark/testdata

# Copying assets to remote machines
## options ssh/scp not to check hostkey
options='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

## Copying assets
for client in `cat data/jmx_clients.txt`
do
    scp $options -r data/ $client:$DATA_DIR/
done
