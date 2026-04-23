#!/bin/bash

# Verification script for MariaDB Codespaces setup
# This script tests that all components are properly configured

echo "========================================"
echo "MariaDB Environment Verification Script"
echo "========================================"
echo ""

FAILED=0

# Test 1: Check if MySQL client is installed
echo "Test 1: Checking MySQL client installation..."
if command -v mysql &> /dev/null; then
    echo "  ✓ MySQL client is installed"
else
    echo "  ✗ MySQL client is NOT installed"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 2: Check if MariaDB server is running
echo "Test 2: Checking MariaDB server connectivity..."
if mysql -h 127.0.0.1 -u root -prootpass -e "SELECT 1" &> /dev/null; then
    echo "  ✓ MariaDB server is running and accessible"
else
    echo "  ✗ Cannot connect to MariaDB server"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 3: Check if cop3710 database exists
echo "Test 3: Checking cop3710 database..."
if mysql -h 127.0.0.1 -u root -prootpass -e "USE cop3710; SELECT 1" &> /dev/null; then
    echo "  ✓ Database 'cop3710' exists"
else
    echo "  ✗ Database 'cop3710' does NOT exist"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 4: Check user accounts
echo "Test 4: Checking user accounts..."
USERS=("root:rootpass" "red:redpass" "blue:bluepass" "green:greenpass" "orange:orangepass")

for user_pass in "${USERS[@]}"; do
    IFS=':' read -r user pass <<< "$user_pass"
    if mysql -h 127.0.0.1 -u "$user" -p"$pass" -e "SELECT 1" &> /dev/null; then
        echo "  ✓ User '$user' can connect"
    else
        echo "  ✗ User '$user' CANNOT connect"
        FAILED=$((FAILED + 1))
    fi
done
echo ""

# Test 5: Check if test_table exists and has data
echo "Test 5: Checking sample table and data..."
ROWCOUNT=$(mysql -h 127.0.0.1 -u root -prootpass cop3710 -se "SELECT COUNT(*) FROM test_table" 2>/dev/null)
if [ $? -eq 0 ] && [ "$ROWCOUNT" -ge 1 ]; then
    echo "  ✓ Table 'test_table' exists with $ROWCOUNT rows"
else
    echo "  ✗ Table 'test_table' is missing or empty"
    FAILED=$((FAILED + 1))
fi
echo ""

# Test 6: Check port 3306 is accessible
echo "Test 6: Checking MariaDB port (3306)..."
if nc -z 127.0.0.1 3306 2>/dev/null; then
    echo "  ✓ Port 3306 is open and accessible"
else
    echo "  ⚠ Cannot verify port 3306 (nc not available or port closed)"
fi
echo ""

# Test 7: Check SSH configuration
echo "Test 7: Checking SSH server..."
if command -v ssh &> /dev/null && pgrep sshd &> /dev/null; then
    echo "  ✓ SSH server is installed and running"
elif command -v ssh &> /dev/null; then
    echo "  ⚠ SSH client is installed but server may not be running"
else
    echo "  ⚠ SSH not fully configured"
fi
echo ""

# Summary
echo "========================================"
if [ $FAILED -eq 0 ]; then
    echo "✓ All critical tests passed!"
    echo "Environment is ready to use."
    exit 0
else
    echo "✗ $FAILED test(s) failed"
    echo "Please check the configuration."
    exit 1
fi
