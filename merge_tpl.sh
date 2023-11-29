#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 directory_path"
    exit 1
fi

# First argument is the directory containing the text files
DIRECTORY="$1"

# Define the output file
OUTPUT_FILE="/Users/wes/Documents/GitHub/TPL_Repo/tpl_code.txt"

# Merge all text files in the directory into one
cat "$DIRECTORY"/*.tpl >> "$OUTPUT_FILE"

echo "All files in $DIRECTORY merged into $OUTPUT_FILE"

