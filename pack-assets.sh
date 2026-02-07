#!/usr/bin/env bash
# pack-assets.sh
# Creates valentine-assets.zip containing the ./assets directory (recursively).
# Run this from your project root (the folder that contains index.html and assets/).

set -euo pipefail

OUT="valentine-assets.zip"
SRC_DIR="assets"

if [ ! -d "$SRC_DIR" ]; then
  echo "Error: $SRC_DIR directory not found in $(pwd)"
  exit 1
fi

# Remove existing zip if present (uncomment if you want overwrite)
if [ -f "$OUT" ]; then
  echo "Removing existing $OUT"
  rm -f "$OUT"
fi

echo "Creating $OUT from $SRC_DIR ..."
zip -r "$OUT" "$SRC_DIR" -x "**/.DS_Store" > /dev/null

echo "Created $(ls -lh "$OUT")"