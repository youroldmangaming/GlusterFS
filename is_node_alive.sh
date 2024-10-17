#!/bin/bash

# Function to check if a node is ready
check_node_ready() {
    local node=$1
    state=$(sinfo -n $node -o "%T" -h)
    if [[ $state == "idle" ]]; then
        echo "Ready"
    else
        echo "Not Ready"
    fi
}

# Function to make a node ready
make_node_ready() {
    local node=$1
    echo "Making node $node ready..."
    scontrol update nodename=$node state=idle
}

# Function to restart a node
restart_node() {
    local node=$1
    echo "Restarting node $node..."
    scontrol reboot $node
}

# Get all nodes
nodes=$(sinfo -h -o "%n")

# Main loop
while true; do
    not_ready_nodes=()
    all_ready=true

    echo "Checking node readiness..."
    for node in $nodes; do
        status=$(check_node_ready $node)
        echo "Node $node: $status"
        if [[ $status != "Ready" ]]; then
            all_ready=false
            not_ready_nodes+=($node)
        fi
    done

    if $all_ready; then
        echo "All nodes are ready for processing."
        break
    else
        echo "The following nodes are not ready:"
        printf '%s\n' "${not_ready_nodes[@]}"

        read -p "Do you want to make these nodes ready? (y/n): " make_ready
        if [[ $make_ready == "y" ]]; then
            for node in "${not_ready_nodes[@]}"; do
                make_node_ready $node
            done
        else
            echo "Exiting without making nodes ready."
            exit 1
        fi
    fi
done

# Options after all nodes are ready
while true; do
    echo "All nodes are ready. Choose an option:"
    echo "1. Quit"
    echo "2. Restart ready nodes"
    read -p "Enter your choice (1 or 2): " choice

    case $choice in
        1)
            echo "Exiting script."
            exit 0
            ;;
        2)
            echo "Restarting all ready nodes..."
            for node in $nodes; do
                if [[ $(check_node_ready $node) == "Ready" ]]; then
                    restart_node $node
                fi
            done
            echo "All ready nodes have been restarted."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 1 or 2."
            ;;
    esac
done
