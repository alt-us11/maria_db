-- Initialize MariaDB with required user accounts
-- Root user is created automatically by MariaDB

-- Create additional users with passwords
CREATE USER IF NOT EXISTS 'red'@'%' IDENTIFIED BY 'redpass';
CREATE USER IF NOT EXISTS 'blue'@'%' IDENTIFIED BY 'bluepass';
CREATE USER IF NOT EXISTS 'green'@'%' IDENTIFIED BY 'greenpass';
CREATE USER IF NOT EXISTS 'orange'@'%' IDENTIFIED BY 'orangepass';

-- Grant privileges to all users on the cop3710 database
GRANT ALL PRIVILEGES ON cop3710.* TO 'red'@'%';
GRANT ALL PRIVILEGES ON cop3710.* TO 'blue'@'%';
GRANT ALL PRIVILEGES ON cop3710.* TO 'green'@'%';
GRANT ALL PRIVILEGES ON cop3710.* TO 'orange'@'%';

-- Flush privileges to ensure they take effect
FLUSH PRIVILEGES;

-- Create a sample table for testing
USE cop3710;

CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO test_table (name) VALUES 
    ('Sample Entry 1'),
    ('Sample Entry 2'),
    ('Sample Entry 3');
