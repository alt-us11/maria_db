#!/bin/bash

# Post-create script for setting up the development environment

echo "Installing MySQL client..."
sudo apt-get update
sudo apt-get install -y mysql-client

echo "Waiting for MariaDB to be ready..."
until mysql -h 127.0.0.1 -u root -prootpass -e "SELECT 1" &> /dev/null
do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

echo "MariaDB is ready!"
echo ""
echo "==================================="
echo "MariaDB Connection Information:"
echo "==================================="
echo "Host: localhost (or 127.0.0.1)"
echo "Port: 3306"
echo "Database: cop3710"
echo ""
echo "Users and passwords:"
echo "  root     -> rootpass"
echo "  red      -> redpass"
echo "  blue     -> bluepass"
echo "  green    -> greenpass"
echo "  orange   -> orangepass"
echo ""
echo "To connect via command line:"
echo "  mysql -h 127.0.0.1 -u root -prootpass cop3710"
echo ""
echo "To verify setup:"
echo "  bash .devcontainer/verify-setup.sh"
echo ""
echo "==================================="
