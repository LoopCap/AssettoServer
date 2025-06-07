#!/bin/sh
# download-data.sh

# Default URL if none provided
DEFAULT_URL="https://media.loopcap.me/data.tgz"

# Use DATA_URL environment variable if set, otherwise use default
URL=${DATA_URL:-$DEFAULT_URL}

# Check if /data is writable
if [ ! -w /data ]; then
  echo "Error: /data directory is not writable"
  exit 1
fi

# Download and extract the tar.gz file to /data
echo "Downloading from $DATA_URL..."
curl -L "$DATA_URL" -o /data/data.tgz
if [ $? -eq 0 ]; then
  echo "Extracting to /data..."
  # Extract to a temporary directory first
  mkdir -p /data/temp
  tar -xzf /data/data.tgz -C /data/temp
  if [ $? -eq 0 ]; then
    # Move contents from data/temp/data/* to /data/
    if [ -d "/data/temp/data" ]; then
      echo "Moving contents from data directory..."
      cp -rf /data/temp/data/* /data/
      rm -rf /data/temp
    else
      echo "Moving all extracted contents..."
      cp -rf /data/temp/* /data/
      rm -rf /data/temp
    fi
    echo "Extraction successful, removing tgz file..."
    rm /data/data.tgz
  else
    echo "Error: Failed to extract /data/data.tgz"
    exit 1
  fi
else
  echo "Error: Failed to download from $DATA_URL"
  exit 1
fi