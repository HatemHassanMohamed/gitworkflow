#!/bin/bash

# CI/CD Test Script for app.py
# This script validates that app.py runs successfully

set -e  # Exit on any error

echo "Starting CI/CD tests for app.py..."
echo "=================================="

# Test 1: Check if Python3 is installed
echo "[TEST 1] Checking Python3 installation..."
if ! command -v python3 &> /dev/null; then
    echo "❌ FAILED: Python3 is not installed"
    exit 1
fi
echo "✓ PASSED: Python3 is installed"

# Test 2: Check if app.py exists
echo ""
echo "[TEST 2] Checking if app.py exists..."
if [ ! -f "app.py" ]; then
    echo "❌ FAILED: app.py not found"
    exit 1
fi
echo "✓ PASSED: app.py exists"

# Test 3: Run app.py and check exit code
echo ""
echo "[TEST 3] Running app.py..."
if python3 app.py > /tmp/app_output.txt 2>&1; then
    echo "✓ PASSED: app.py executed successfully"
else
    echo "❌ FAILED: app.py execution failed"
    cat /tmp/app_output.txt
    exit 1
fi

# Test 4: Validate output
echo ""
echo "[TEST 4] Validating output..."
OUTPUT=$(cat /tmp/app_output.txt)
if grep -q "Welcome" /tmp/app_output.txt; then
    echo "✓ PASSED: Output contains expected message"
    echo "   Output: $OUTPUT"
else
    echo "❌ FAILED: Output validation failed"
    echo "   Expected: 'Welcome' in output"
    echo "   Got: $OUTPUT"
    exit 1
fi

echo ""
echo "=================================="
echo "✓ All tests passed!"
echo "=================================="
