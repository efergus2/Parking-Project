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

# Start MariaDB in background, bind to all interfaces
echo "Starting MariaDB..."
mariadbd --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0 &

# Wait until MariaDB is ready
echo "Waiting for MariaDB to initialize..."
until mysqladmin ping --host=127.0.0.1 --silent; do
  sleep 2
done

# Create database and user (allow connections from any host)
mysql -e "CREATE DATABASE IF NOT EXISTS parkingdb;"
mysql -e "CREATE USER IF NOT EXISTS 'parking_user'@'%' IDENTIFIED BY 'parking_pass';"
mysql -e "GRANT ALL PRIVILEGES ON parkingdb.* TO 'parking_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Import initial SQL if exists
if [ -f /init.sql ]; then
    echo "Importing initial SQL..."
    mysql parkingdb < /init.sql
fi

# Start Node server
echo "Starting Node server..."
node server.js
