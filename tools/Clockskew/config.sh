#!/bin/bash

# Install clockskew on all nodes
go get github.com/uber-go/clockskew

# Define the IP addresses of all nodes
master_node=192.238.51.141
worker_node_1=192.238.49.187
worker_node_2=192.238.55.237
worker_node_3=192.238.62.229

# Start clockskew on master node and check time difference with worker nodes
clockskew -v $worker_node_1 &
clockskew -v $worker_node_2 &
clockskew -v $worker_node_3 &

# Start clockskew on worker nodes and check time difference with master node
clockskew -v $master_node &

# Wait for clockskew to finish
wait

# Verify that clocks are in sync on all nodes
clockskew -v $master_node
clockskew -v $worker_node_1
clockskew -v $worker_node_2
clockskew -v $worker_node_3
