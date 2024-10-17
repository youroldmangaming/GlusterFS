#!/bin/bash

# Define node names
MANAGER_NODE="rpi41"
WORKER_NODES=("rpi41" "rpi51" "rpi52" "rpi53" "rpi54")

# Function to run commands on a specific node
run_on_node() {
    echo $node
    local node=$1
    shift
    srun --nodes=1 --nodelist=$node "$@"
}

# Step 1: Install GlusterFS on all nodes
for node in $MANAGER_NODE "${WORKER_NODES[@]}"; do

    run_on_node $node sudo apt update
    run_on_node $node sudo apt install glusterfs-server -y
    run_on_node $node sudo systemctl status --now glusterd.service
    run_on_node $node sudo systemctl enable --now glusterd.service
    run_on_node $node sudo systemctl start --now glusterd.service
    run_on_node $node sudo systemctl status --now glusterd.service
    run_on_node $node sudo mkdir -p /glusterfs
done
