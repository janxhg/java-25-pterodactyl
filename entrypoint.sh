#!/bin/bash

# Pterodactyl Java 25 Entrypoint Script
# This script handles server startup for Java 25 applications

cd /home/container || exit 1

# Print Java version for verification
echo "=========================================="
echo "Java Version:"
java -version
echo "=========================================="

# Make internal Docker IP address available to processes
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Replace Pterodactyl variables in startup command
MODIFIED_STARTUP=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "Starting server with command: ${MODIFIED_STARTUP}"

# Execute the startup command
eval "${MODIFIED_STARTUP}"
