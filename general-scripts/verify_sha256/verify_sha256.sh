#!/usr/bin/env bash

# Name        : verify-sha256

# Description : Compare the actual and expected SHA256 sum of a file.

# =============================================================================

# VARIABLES
# ---------

filename="$1"
expected_sum="$2"

# Extract the expected SHA256.

actual_sum=$(sha256sum "$filename" | awk '{print $1}')

# CHECKS
# ------

# Check number of arguments.

if [ "$#" -ne 2 ]; then
  echo "Usage: verify <filename> <expected_sha256_sum>" >&2
  exit 1
fi

# Check if the file exists.
if [ ! -f "$filename" ]; then
  echo "Error: File not found." >&2
  exit 1
fi

# Check if sha256sum is installed.
if ! command -v sha256sum &>/dev/null; then
  echo "Error: sha256sum is not available." >&2
  exit 1
fi

# SCRIPT_EXECUTION
# ----------------

echo
echo "--- Verify SHA256 ---"
echo
echo "Filename: $filename"
echo
echo "Expect SHA256 sum: $expected_sum"
echo "Actual SHA256 sum: $actual_sum"

# Compare the actual and expected sums and report result.

echo
if [ "$actual_sum" = "$expected_sum" ]; then
  echo "✅ Verification successful: SHA256 sums match."
else
  echo "⛔ Verification failed: SHA256 sums do not match."
fi

exit 0
