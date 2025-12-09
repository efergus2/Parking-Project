# Parking Lot Project

IS436 Team B --- Campus Smart Parking System Prototype
Database-driven system for managing, monitoring, and publishing
real-time parking availability.

[Parking Database Schema](#database-schema) •
[Docker Deployment Workflow](#docker-deployment-workflow) •
[System Usage](#system-usage) •
[Setup Instructions](#setup-instructions)

------------------------------------------------------------------------

## Table of Contents

-   [Overview](#overview)
-   [Core Features](#core-features)
-   [System Architecture](#system-architecture)
    -   [Database Schema](#database-schema)
    -   [Conceptual Model](#conceptual-model)
-   [Setup Instructions](#setup-instructions)
    -   [Start](#start)
    -   [Stop](#stop)
    -   [Connect](#connect)
-   [System Usage](#system-usage)
    -   [Querying Availability](#querying-availability)
    -   [Updating Availability](#updating-availability)
    -   [Safe Update Mode Fix](#safe-update-mode-fix)
-   [Docker Deployment Workflow](#docker-deployment-workflow)
    -   [GitHub Actions Pipeline](#github-actions-pipeline)
    -   [Pulling the Image](#pulling-the-image)
-   [Future Enhancements](#future-enhancements)
-   [Troubleshooting](#troubleshooting)
-   [License](#license)

------------------------------------------------------------------------

# Overview

This project is the prototype Campus Smart Parking Management System
built for **IS436 Team B**.
It stores parking lot information, user accounts, and simulated IoT
sensor data to track real-time availability on campus.

The system is fully database-driven and supports both manual SQL updates
and automated containerized deployment workflows.

------------------------------------------------------------------------

# Core Features

-   Single-table parking availability model
-   Real-time simulation of IoT sensor updates
-   Docker-hosted database environment
-   GitHub Actions workflow for automatic Docker Hub deployment
-   Easy integration with dashboards, mobile apps, or kiosks

------------------------------------------------------------------------

# System Architecture

## Database Schema

    lots
    ├── id            INT PRIMARY KEY
    ├── name          VARCHAR
    ├── capacity      INT
    ├── open_spaces   INT
    └── note          VARCHAR

## Conceptual Model

-   **One row = one parking lot**
-   **capacity** = total spaces
-   **open_spaces** = available spaces
-   **note** = lot classification

------------------------------------------------------------------------

# Setup Instructions

## Start

1.  Ensure your Docker MySQL or Oracle XE container is running.

2.  Open SQL Developer or MySQL Workbench.

3.  Run:

        create_parking_db.sql

4.  Verify:

    ``` sql
    SELECT * FROM lots;
    ```

## Stop

Windows:

    net stop OracleServiceXE
    net stop mysql

macOS / Linux:

    sudo service mysql stop
    sudo systemctl stop oracle-xe

## Connect

MySQL:

    mysql -u parking_user -p -h localhost -P 3306 parking_db

Oracle:

    CONNECT parking_admin@localhost:1521/XE

------------------------------------------------------------------------

# System Usage

## Querying Availability

``` sql
SELECT name, open_spaces, capacity FROM lots;
```

## Updating Availability

``` sql
UPDATE lots SET open_spaces = open_spaces - 1 WHERE id = 1;
```

## Safe Update Mode Fix

    SET SQL_SAFE_UPDATES = 0;

------------------------------------------------------------------------

# Docker Deployment Workflow

## GitHub Actions Pipeline

``` yaml
name: Build and Push Docker Image

on:
  push:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Login to DockerHub
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build image
      run: docker build -t ${{ secrets.DOCKER_USERNAME }}/is436:latest .

    - name: Push image
      run: docker push ${{ secrets.DOCKER_USERNAME }}/is436:latest
```

## Pulling the Image

    docker pull <docker-username>/is436:latest

------------------------------------------------------------------------

# Troubleshooting

### Safe Mode Error

    SET SQL_SAFE_UPDATES = 0;

### Docker Not Running

Start Docker Desktop or system service.

------------------------------------------------------------------------

# License

MIT License unless otherwise specified.
