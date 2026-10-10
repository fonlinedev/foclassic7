#!/bin/bash

# Define paths based on your existing server configuration
SERVER_DIR="/home/fonline/foclassic7/Server"
SAVE_DIR="$SERVER_DIR/save"

# Ensure the script is executed from the directory containing server_control_headless.sh
# Adjust this path if the control script is located elsewhere.
CONTROL_SCRIPT="./server_control_headless.sh"

echo "Initiating server shutdown..."
"$CONTROL_SCRIPT" stop

echo "Cleaning up old save files in $SAVE_DIR..."
if [ -d "$SAVE_DIR" ]; then
    cd "$SAVE_DIR" || { echo "Failed to access $SAVE_DIR"; exit 1; }
    
    # List all world*.fo files sorted by modification time (newest first)
    # Skip the first 5 files, and delete the remaining older files
    ls -t world*.fo 2>/dev/null | tail -n +6 | xargs -r rm -f
    
    echo "Cleanup complete. The 5 most recent world saves have been retained."
else
    echo "Directory $SAVE_DIR does not exist. Skipping cleanup phase."
fi

echo "Restarting the server..."
# Return to the original directory to execute the start command if necessary
cd - > /dev/null || exit 1
"$CONTROL_SCRIPT" start

echo "Maintenance cycle complete."