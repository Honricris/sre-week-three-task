#!/bin/bash

# Define Variables
NAMESPACE="sre"
DEPLOYMENT_NAME="swype-app"
MAX_RESTARTS=2

# Start a Loop
while true; do
    # Check Pod Restarts
    restarts=$(kubectl get pods -n $NAMESPACE | grep $DEPLOYMENT_NAME | awk '{print $4}')

    # Display Restart Count
    echo "Current number of restarts: $restarts"

    # Check Restart Limit
    if [ "$restarts" -gt "$MAX_RESTARTS" ]; then
        # Scale Down if Necessary
        echo "Number of restarts exceeded maximum allowed. Scaling down deployment..."
        kubectl scale deployment -n $NAMESPACE $DEPLOYMENT_NAME --replicas=0
        break
    fi

    # Pause for 60 seconds
    sleep 60
done