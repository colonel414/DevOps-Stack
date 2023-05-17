#!/bin/bash

# Make sure the chrony service is running
systemctl start chronyd
systemctl enable chronyd

# Check the status of the time synchronization
chronyc tracking

# Wait for a while and then check the status again
sleep 30
chronyc tracking
