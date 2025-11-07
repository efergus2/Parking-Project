#!/bin/bash
set -e

# Start MySQL service in the background
service mysql start

# Wait for MySQL to be ready
echo "Waiting for MySQL to initialize..."
until mysqladmin ping --silent; do
  sleep 2
done

# Create database and user if they don't exist
mysql -e "CREATE DATABASE IF NOT EXISTS parkingdb;"
mysql -e "CREATE USER IF NOT EXISTS 'parking_user'@'%' IDENTIFIED BY 'parking_pass';"
mysql -e "GRANT ALL PRIVILEGES ON parkingdb.* TO 'parking_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Import initial SQL
mysql parkingdb < /init.sql

# Start Node server
node server.js

