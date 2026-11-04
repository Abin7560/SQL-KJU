CREATE DATABASE CAMPUS_STORE_DB;
USE CAMPUS_STORE_DB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    membership_type VARCHAR(20) DEFAULT 'Standard',
    city VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    order_date DATE NOT NULL,
    order_quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

ALTER TABLE Customers ADD mobile_number VARCHAR(15);
ALTER TABLE Customers DROP COLUMN mobile_number;

INSERT INTO Customers (customer_name, email, membership_type, city) VALUES
('Neha Kapoor', 'neha@campusmail.com', 'Gold', 'Pune'),
('Arjun Nair', 'arjun@campusmail.com', 'Standard', 'Kochi'),
('Sanjay Rao', 'sanjay@campusmail.com', 'Gold', 'Hyderabad'),
('Maya Thomas', 'maya@campusmail.com', 'Standard', 'Chennai'),
('Rohan Mehta', 'rohan@campusmail.com', 'Silver', 'Pune');

INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('NovaBook Laptop', 'Computers', 57500.00, 18),
('Bluetooth Headset', 'Accessories', 1850.00, 45),
('Gaming Keyboard', 'Accessories', 4200.00, 28),
('Office Workstation', 'Furniture', 9200.00, 12),
('Compact Study Desk', 'Furniture', 13200.00, 7),
('Legacy USB Drive', 'Clearance', 650.00, 0);

INSERT INTO Orders (customer_id, product_id, order_date, order_quantity) VALUES
(1, 1, '2026-09-03', 1),
(1, 2, '2026-09-04', 3),
(2, 4, '2026-09-05', 1),
(3, 1, '2026-09-06', 1),
(4, 5, '2026-09-07', 2),
(5, 2, '2026-09-08', 4);

SET SQL_SAFE_UPDATES = 0;

UPDATE Products
SET price = price * 1.06
WHERE category = 'Accessories';

DELETE FROM Products
WHERE stock_quantity = 0 AND category = 'Clearance';

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM Customers;
SELECT * FROM Products;

SELECT city, COUNT(*) AS customer_count
FROM Customers
GROUP BY city;

SELECT
    category,
    COUNT(*) AS unique_products,
    SUM(stock_quantity) AS total_items_stocked,
    AVG(price) AS average_unit_price,
    MIN(price) AS cheapest_item_price,
    MAX(price) AS peak_item_price
FROM Products
GROUP BY category;

SELECT category, AVG(price) AS average_price
FROM Products
GROUP BY category
HAVING AVG(price) > 5000.00;

SELECT
    o.order_id,
    c.customer_name,
    c.city,
    p.product_name,
    p.category,
    o.order_quantity,
    p.price AS unit_price,
    (o.order_quantity * p.price) AS total_order_revenue
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Products p ON o.product_id = p.product_id
ORDER BY total_order_revenue DESC;
