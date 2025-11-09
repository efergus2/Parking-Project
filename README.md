# Parking-Project
IS436 Team B Parking Project 

Overview - This project is a database-driven prototype for the Campus Smart Parking Management System, developed as part of the IS436 course. It stores parking lot information, user accounts, and simulated IoT sensor data to track real-time availability on campus.

Start - To start the database, make sure the Docker container is running, then open Oracle SQL Developer or MySQL Workbench.
Run the script create_parking_db.sql to create tables and insert sample data.
After it runs, type SELECT * FROM LOTS; to check that the setup worked.

Stop - To stop the database, close your SQL session or stop the Docker service.
On Windows, use net stop OracleServiceXE or net stop mysql.
On Mac or Linux, use sudo service mysql stop or sudo systemctl stop oracle-xe.

Connect- To connect, use localhost as the host and whichever port you chose before running the Docker container. By default it is 3308.
The username is parking_user and the password is parking_pass
For Oracle, use CONNECT parking_admin@localhost:1521/XE.
For MySQL, use mysql -u parking_user -p -h localhost -P 3306 parking_db.
