-- Database schema for Smart Prison Management System
CREATE DATABASE IF NOT EXISTS smart_prison CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_prison;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(20) DEFAULT 'admin'
);

-- Sample admin (username: admin, password: admin) - plaintext for demo only
INSERT INTO users (username, password, role) VALUES ('admin','admin','admin')
ON DUPLICATE KEY UPDATE username=username;

CREATE TABLE IF NOT EXISTS inmates (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  dob DATE DEFAULT NULL,
  gender VARCHAR(10) DEFAULT NULL,
  cell VARCHAR(50) DEFAULT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Visitor requests submitted by people at home requesting to see an inmate
CREATE TABLE IF NOT EXISTS visitor_requests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) DEFAULT NULL,
  phone VARCHAR(50) DEFAULT NULL,
  gender VARCHAR(20) DEFAULT NULL,
  inmate_id INT DEFAULT NULL,
  message TEXT,
  status ENUM('pending','approved','rejected','resolved') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (inmate_id) REFERENCES inmates(id) ON DELETE SET NULL
);
