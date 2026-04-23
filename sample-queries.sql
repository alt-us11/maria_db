-- Sample SQL Scripts for Testing
-- COP3710 MariaDB Development Environment
-- 
-- These scripts demonstrate basic database operations
-- You can run these to test your MariaDB environment

-- ======================================
-- 1. BASIC TABLE OPERATIONS
-- ======================================

-- View existing sample data
SELECT * FROM test_table;

-- Insert new data
INSERT INTO test_table (name) VALUES ('My Test Entry');

-- Update data
UPDATE test_table SET name = 'Updated Entry' WHERE id = 1;

-- Delete data (be careful!)
-- DELETE FROM test_table WHERE id = 1;

-- ======================================
-- 2. CREATE A STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    gpa DECIMAL(3, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample students
INSERT INTO students (first_name, last_name, email, gpa) VALUES
    ('John', 'Doe', 'john.doe@university.edu', 3.75),
    ('Jane', 'Smith', 'jane.smith@university.edu', 3.90),
    ('Bob', 'Johnson', 'bob.johnson@university.edu', 3.45),
    ('Alice', 'Williams', 'alice.williams@university.edu', 3.85);

-- Query students
SELECT * FROM students;
SELECT * FROM students WHERE gpa > 3.70;
SELECT * FROM students ORDER BY gpa DESC;

-- ======================================
-- 3. CREATE A COURSES TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT DEFAULT 3,
    department VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample courses
INSERT INTO courses (course_code, course_name, credits, department) VALUES
    ('COP3710', 'Database Management', 3, 'Computer Science'),
    ('COP3330', 'Object-Oriented Programming', 3, 'Computer Science'),
    ('COP4530', 'Data Structures', 3, 'Computer Science'),
    ('MAC2311', 'Calculus I', 4, 'Mathematics');

-- Query courses
SELECT * FROM courses;
SELECT * FROM courses WHERE department = 'Computer Science';

-- ======================================
-- 4. CREATE AN ENROLLMENTS TABLE (MANY-TO-MANY)
-- ======================================

CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    semester VARCHAR(20),
    grade VARCHAR(2),
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, course_id, semester)
);

-- Insert sample enrollments
INSERT INTO enrollments (student_id, course_id, semester, grade) VALUES
    (1, 1, 'Fall 2024', 'A'),
    (1, 2, 'Fall 2024', 'B+'),
    (2, 1, 'Fall 2024', 'A-'),
    (2, 3, 'Fall 2024', 'A'),
    (3, 1, 'Spring 2025', NULL),
    (4, 2, 'Spring 2025', NULL);

-- ======================================
-- 5. USEFUL QUERIES
-- ======================================

-- Join students with their enrollments and courses
SELECT 
    s.first_name,
    s.last_name,
    c.course_code,
    c.course_name,
    e.semester,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.last_name, c.course_code;

-- Count enrollments per course
SELECT 
    c.course_code,
    c.course_name,
    COUNT(e.enrollment_id) as enrollment_count
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id
ORDER BY enrollment_count DESC;

-- Find students with no grade yet (currently enrolled)
SELECT 
    s.first_name,
    s.last_name,
    c.course_code,
    c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.grade IS NULL;

-- ======================================
-- 6. AGGREGATE FUNCTIONS
-- ======================================

-- Average GPA
SELECT AVG(gpa) as average_gpa FROM students;

-- Student count
SELECT COUNT(*) as total_students FROM students;

-- Total credits available
SELECT SUM(credits) as total_credits FROM courses;

-- ======================================
-- 7. VIEW ALL TABLES
-- ======================================

SHOW TABLES;

-- ======================================
-- 8. DESCRIBE TABLE STRUCTURE
-- ======================================

DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;

-- ======================================
-- 9. CLEAN UP (if needed)
-- ======================================

-- Uncomment the lines below if you want to remove the test data
-- DROP TABLE IF EXISTS enrollments;
-- DROP TABLE IF EXISTS students;
-- DROP TABLE IF EXISTS courses;

-- ======================================
-- TIPS:
-- ======================================
-- 1. Always test queries with SELECT before UPDATE or DELETE
-- 2. Use LIMIT to restrict results: SELECT * FROM students LIMIT 5;
-- 3. Use transactions for important changes:
--    START TRANSACTION;
--    -- your queries
--    COMMIT; -- or ROLLBACK;
-- 4. Check table structure: DESCRIBE tablename;
-- 5. See recent changes: SHOW WARNINGS;
