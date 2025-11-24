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
('1',  'Lot 1',  120, 120, 'Commuter'),
('2',  'Lot 2',   90,  90, 'Commuter; Faculty'),
('3',  'Lot 3',   60,  60, 'Commuter'),
('4',  'Lot 4',   40,  40, 'Faculty'),
('5',  'Lot 5',  150, 150, 'Commuter'),
('6',  'Lot 6',   80,  80, 'Faculty'),
('7',  'Lot 7',   70,  70, 'C Residential'),
('8',  'Lot 8',   55,  55, 'A Residential'),
('9',  'Lot 9',  200, 200, 'Commuter; Faculty'),
('10', 'Lot 10',  45,  45, 'A Residential'),
('11', 'Lot 11',  65,  65, 'Commuter'),
('12', 'Lot 12',  50,  50, 'C Residential'),
('20', 'Lot 20',  30,  30, 'Faculty'),
('21', 'Lot 21', 110, 110, 'Commuter'),
('22', 'Lot 22',  75,  75, 'Commuter; Faculty'),
('23', 'Lot 23',  95,  95, 'Commuter'),
('24', 'Lot 24', 140, 140, 'Commuter'),
('25', 'Lot 25',  85,  85, 'C Residential'),
('26', 'Lot 26',  35,  35, 'A Residential'),
('27', 'Lot 27',  48,  48, 'Commuter'),
('28', 'Lot 28',  28,  28, 'C Residential'),
('29', 'Lot 29', 160, 160, 'Commuter; Faculty'),
('30', 'Lot 30', 220, 220, 'Commuter'),
('31', 'Lot 31',  25,  25, 'C Residential')
ON DUPLICATE KEY UPDATE id = id;