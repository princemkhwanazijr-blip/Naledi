#!/usr/bin/env bash
# pack-and-optimize.sh
#
# Runs optimize-images.js (if present and Node is available) then creates
# valentine-assets.zip containing the ./assets directory (recursively).
#
# Usage:
#   ./pack-and-optimize.sh         # run optimizer if present, then zip
#   SKIP_OPT=1 ./pack-and-optimize.sh   # skip the optimizer even if present
#
# Notes:
# - If optimize-images.js exists the script will try to run it with node.
# - If sharp (node_modules/sharp) is not present the script will attempt to
#   install dependencies with `npm install` (or `npm ci` if package-lock.json exists).
# - Installing sharp may require build tools on some systems (see https://sharp.pixelplumbing.com/install).
# - This script is intended for macOS/Linux/WSL environments.

set -euo pipefail

SRC_DIR="assets"
OUT="valentine-assets.zip"
OPT_SCRIPT="optimize-images.js"

echo "Starting pack-and-optimize.sh"
echo "Project root: $(pwd)"

# Check assets directory exists
if [ ! -d "$SRC_DIR" ]; then
  echo "Error: '$SRC_DIR' directory not found in $(pwd). Place your images in ./$SRC_DIR and retry."
  exit 1
fi

# Run optimizer if present and not explicitly skipped
if [ -f "$OPT_SCRIPT" ] && [ "${SKIP_OPT:-0}" != "1" ]; then
  echo "Found $OPT_SCRIPT — attempting to run image optimizer..."
  if command -v node >/dev/null 2>&1; then
    echo "Node.js detected: $(node --version)"
    # If sharp not installed, attempt to install dependencies
    if [ ! -d "node_modules/sharp" ]; then
      echo "sharp not found in node_modules. Installing dependencies..."
      # Prefer npm ci if lockfile exists, otherwise npm install
      if [ -f package-lock.json ]; then
        npm ci
      else
        npm install sharp
      fi
    else
      echo "sharp already installed."
    fi

    echo "Running: node $OPT_SCRIPT"
    node "$OPT_SCRIPT"
    echo "Image optimization complete."
  else
    echo "Warning: Node.js not found. Skipping image optimization."
    echo "Install Node.js (https://nodejs.org/) and run this script again to generate optimized images."
  fi
else
  if [ -f "$OPT_SCRIPT" ]; then
    echo "Image optimizer present but SKIP_OPT is set. Skipping optimization."
  else
    echo "No optimizer script ($OPT_SCRIPT) found — skipping optimization."
  fi
fi

# Create ZIP of the assets directory
if [ -f "$OUT" ]; then
  echo "Removing existing $OUT"
  rm -f "$OUT"
fi

echo "Creating zip archive $OUT from directory $SRC_DIR ..."
# Use zip -r; exclude macOS .DS_Store files
zip -r "$OUT" "$SRC_DIR" -x "**/.DS_Store" > /dev/null

echo "Created archive: $(ls -lh "$OUT")"
echo "Contents (first 50 lines):"
unzip -l "$OUT" | sed -n '1,50p'

echo "Done."