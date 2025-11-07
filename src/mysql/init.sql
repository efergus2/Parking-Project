-- init.sql : creates schema and seed data
CREATE DATABASE IF NOT EXISTS parkingdb;
USE parkingdb;

CREATE TABLE IF NOT EXISTS lots (
  id VARCHAR(32) NOT NULL PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  capacity INT UNSIGNED NOT NULL DEFAULT 0,
  open_spaces INT NOT NULL DEFAULT 0,
  last_updated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  note VARCHAR(255) DEFAULT NULL
);

INSERT INTO lots (id,name,capacity,open_spaces,note) VALUES
('A','Lot A - South',200,112,'Permit only'),
('B','Lot B - North',120,0,'Peak full'),
('C','Lot C - East',85,7,'Limited'),
('D','Lot D - West',45,20,''),
('E','Lot E - Center',300,245,'Visitor friendly'),
('F','Lot F - Garage',600,0,'Closed for maintenance')
ON DUPLICATE KEY UPDATE id=id;