#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 directory_path [output_file]"
    exit 1
fi

# First argument is the directory containing the text files
DIRECTORY="$1"

# Determine the output file. If a second argument is provided use it,
# otherwise place the file in the repository root next to this script.
if [ -n "$2" ]; then
    OUTPUT_FILE="$2"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    OUTPUT_FILE="$SCRIPT_DIR/tpl_code.txt"
fi

# Merge all text files in the directory into one, overwriting any
# existing file
cat "$DIRECTORY"/*.tpl > "$OUTPUT_FILE"

echo "All files in $DIRECTORY merged into $OUTPUT_FILE"

