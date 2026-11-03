CREATE DATABASE KJU;
USE KJU;

CREATE TABLE students
(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT,
    city VARCHAR(30),
    marks INT
);

INSERT INTO students (name, age, city, marks)
VALUES
    ('RAHUL', 19, 'Mumbai', 88),
    ('PRIYA', 21, 'Pune', 76),
    ('ADITYA', 20, 'Kochi', 92),
    ('SNEHA', 22, 'Mysuru', 81),
    ('ROHAN', 18, 'Jaipur', 69),
    ('MEERA', 20, 'Coimbatore', 85),
    ('KARTHIK', 23, 'Lucknow', 73),
    ('DIVYA', 19, 'Visakhapatnam', 95),
    ('ARJUN', 21, 'Bhopal', 78),
    ('NISHA', 17, 'Mangaluru', 87);

SELECT * FROM students;

SELECT name, marks FROM students;

SELECT * FROM students
WHERE age = 20;

SELECT * FROM students
WHERE marks > 80;
