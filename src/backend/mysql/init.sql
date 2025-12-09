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

INSERT INTO lots (id, name, capacity, open_spaces, note) VALUES
('1',  'Lot 1',  120, 120, 'Commuter; Faculty'),
('2',  'Lot 2',   90,  90, 'Faculty'),
('3',  'Lot 3',   60,  60, 'Commuter'),
('4',  'Lot 4',   40,  40, 'Commuter'),
('5',  'Lot 5',  150, 150, 'C-Residential'),
('6',  'Lot 6',   80,  80, 'C-Residential'),
('7',  'Lot 7',   70,  70, 'Visitor'),
('8',  'Lot 8',   55,  55, 'Faculty'),
('9',  'Lot 9',  200, 200, 'Visitor'),
('10', 'Lot 10',  45,  45, 'Faculty'),
('11', 'Lot 11',  65,  65, 'Visitor'),
('12', 'Lot 12',  50,  50, 'Visitor'),
('20', 'Lot 20',  30,  30, 'B-Residential'),
('21', 'Lot 21', 110, 110, 'B-Residential'),
('22', 'Lot 22',  75,  75, 'Commuter'),
('23', 'Lot 23',  95,  95, 'Commuter; C-Residential'),
('24', 'Lot 24', 140, 140, 'Faculty'),
('25', 'Lot 25',  85,  85, 'Commuter; C-Residential; Faculty'),
('26', 'Lot 26',  35,  35, 'Commuter; Visitor'),
('27', 'Lot 27',  48,  48, 'B-Residential'),
('28', 'Lot 28',  28,  28, 'Faculty'),
('29', 'Lot 29', 160, 160, 'Commuter'),
('30', 'Lot 30', 220, 220, 'Faculty'),
('31', 'Lot 31',  25,  25, 'Commuter; C-Residential; Faculty')
ON DUPLICATE KEY UPDATE id = id;