#!/bin/bash

# Function to retrieve instance metadata using curl and jq
get_instance_metadata() {
    # Fetch the instance ID using curl
    local instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

    # Fetch instance identity document using curl
    local instance_metadata=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document)
    
    # Combine instance ID with other metadata using jq
    local metadata="{\"InstanceId\":\"$instance_id\", $(echo "$instance_metadata" | jq -r '. | del(.instanceId)')}"
    
    echo "$metadata"
}

# Main function
main() {
    # Get the instance metadata
    instance_metadata=$(get_instance_metadata)
    
    if [ -n "$instance_metadata" ]; then
        # Print the metadata in JSON format using jq
        echo "$instance_metadata" | jq .
    else
        echo "Failed to retrieve instance metadata."
        exit 1
    fi
}

# Run the main function
main
