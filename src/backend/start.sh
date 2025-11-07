#!/bin/bash
set -e

# Start MySQL in the background
mysqld --datadir=/var/lib/mysql &

# Wait for MySQL to start
echo "Waiting for MySQL to initialize..."
until mysqladmin ping --silent; do
  sleep 2
done

# Setup database and user (only if not exists)
mysql -e "CREATE DATABASE IF NOT EXISTS parkingdb;"
mysql -e "CREATE USER IF NOT EXISTS 'parking_user'@'%' IDENTIFIED BY 'parking_pass';"
mysql -e "GRANT ALL PRIVILEGES ON parkingdb.* TO 'parking_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Import initial SQL
mysql parkingdb < /init.sql

# Start Node app
node server.js
