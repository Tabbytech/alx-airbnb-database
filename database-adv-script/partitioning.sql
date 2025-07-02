-- partitioning.sql

-- Note: The specific syntax for table partitioning can vary depending on the database system you are using (e.g., MySQL, PostgreSQL, SQL Server). Below is an example using MySQL syntax. Please adapt it to your specific database.

-- Drop the existing Booking table if it exists (for demonstration purposes, be careful with this in production)
-- DROP TABLE IF EXISTS Booking;

-- Create the Booking table (assuming a basic structure)
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT,
    user_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    -- other relevant columns
    INDEX (user_id),
    INDEX (property_id),
    INDEX (start_date),
    INDEX (end_date)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION pfuture VALUES LESS THAN MAXVALUE
);

-- Example of adding more partitions if needed
-- ALTER TABLE Booking ADD PARTITION (PARTITION p2027 VALUES LESS THAN (2028));
