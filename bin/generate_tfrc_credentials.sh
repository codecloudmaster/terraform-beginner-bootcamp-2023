#!/usr/bin/env bash

# Define the directory and file path
dir="/home/gitpod/.terraform.d/"
filename="credentials.tfrc.json"
filepath="${dir}${filename}"

# Check if the Terraform token is set
if [ -z "$MY_TERRAFORM_CLOUD_TOKEN" ]; then
  echo "Error: MY_TERRAFORM_TOKEN environment variable is not set."
  exit 1
fi

# Check if the directory exists; if not, create it
if [ ! -d "$dir" ]; then
  mkdir -p "$dir"
fi

# JSON content
json_content="{
  \"credentials\": {
    \"app.terraform.io\": {
      \"token\": \"$MY_TERRAFORM_CLOUD_TOKEN\"
    }
  }
}"

# Create the directory if it doesn't exist
mkdir -p "$dir"

# Write the JSON content to the file
echo "$json_content" > "$filepath"

# Check if the file was created successfully
if [ -e "$filepath" ]; then
  echo "JSON file created successfully at $filepath"
else
  echo "Failed to create JSON file"
fi
