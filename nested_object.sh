#!/bin/bash

get_nested_value() {
  local object="$1"
  local key="$2"

  local value
  value=$(echo "$object" | jq -r ".${key}")
  
  echo "$value"
}

object1='{"x":{"y":{"z":"a"}}}'
key1="x/y/z"

value1=$(get_nested_value "$object1" "$key1")

echo "Value 1: $value1"
