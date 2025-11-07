#!/bin/bash
set -e

# Ensure MariaDB directories exist
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initialize MariaDB data directory if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in background
echo "Starting MariaDB..."
mariadbd --user=mysql --datadir=/var/lib/mysql &

# Wait until MariaDB is ready
echo "Waiting for MariaDB to initialize..."
until mysqladmin ping --silent; do
  sleep 2
done

# Create database and user
mysql -e "CREATE DATABASE IF NOT EXISTS parkingdb;"
mysql -e "CREATE USER IF NOT EXISTS 'parking_user'@'%' IDENTIFIED BY 'parking_pass';"
mysql -e "GRANT ALL PRIVILEGES ON parkingdb.* TO 'parking_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Import initial SQL
mysql parkingdb < /init.sql

# Start Node server
echo "Starting Node server..."
node server.js
