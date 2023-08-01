#!/bin/bash

# Fetch the entire metadata
get_instance_metadata() {
  local metadata
  metadata=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document)
  echo "${metadata}" | jq '.'
}

# Fetch a specific data key from the metadata
get_specific_metadata_key() {
  local key=$1
  local metadata
  metadata=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".$key")
  if [ -n "${metadata}" ] && [ "${metadata}" != "null" ]; then
    echo "{ \"$key\": \"$metadata\" }"
  else
    echo "Error: Key not found in metadata."
    exit 1
  fi
}

if [ -n "$1" ]; then
  key=$1
  get_specific_metadata_key "${data_key}"
else
  get_instance_metadata
fi
