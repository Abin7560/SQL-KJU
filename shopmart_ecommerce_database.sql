CREATE DATABASE shopmart_db;
USE shopmart_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    city VARCHAR(60),
    state VARCHAR(60),
    signup_date DATE NOT NULL
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(120) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    cost DECIMAL(10,2) NOT NULL CHECK (cost > 0),
    stock_qty INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    CONSTRAINT fk_prod_cat FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Placed',
    CONSTRAINT fk_ord_cust FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    discount_pct DECIMAL(5,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_oi_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    method VARCHAR(20) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    paid_on DATE,
    CONSTRAINT fk_pay_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

ALTER TABLE customers ADD COLUMN phone VARCHAR(15);
ALTER TABLE customers MODIFY COLUMN phone VARCHAR(20) DEFAULT 'NA';
ALTER TABLE payments ADD COLUMN pay_status VARCHAR(15) NOT NULL DEFAULT 'Paid';
ALTER TABLE products ADD COLUMN is_active TINYINT NOT NULL DEFAULT 1;
ALTER TABLE products DROP COLUMN is_active;

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_items_product ON order_items(product_id);

CREATE TABLE temp_vouchers (
    voucher_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(20) NOT NULL,
    discount DECIMAL(5,2)
);
INSERT INTO temp_vouchers (code, discount) VALUES ('START15', 15), ('SAVE25', 25);
RENAME TABLE temp_vouchers TO vouchers;
TRUNCATE TABLE vouchers;
DROP TABLE vouchers;

SHOW TABLES;
DESCRIBE customers;
DESCRIBE products;
DESCRIBE payments;

INSERT INTO customers (full_name, email, city, state, signup_date, phone) VALUES
('Ananya Iyer', 'ananya@shopmail.com', 'Chennai', 'Tamil Nadu', '2024-01-18', '9811000001'),
('Rahul Das', 'rahul@shopmail.com', 'Kolkata', 'West Bengal', '2024-02-22', '9811000002'),
('Nisha Thomas', 'nisha@shopmail.com', 'Thiruvalla', 'Kerala', '2024-03-09', '9811000003'),
('Kabir Malhotra', 'kabir@shopmail.com', 'Jaipur', 'Rajasthan', '2024-04-14', '9811000004'),
('Priya Shah', 'priya@shopmail.com', 'Surat', 'Gujarat', '2024-05-26', '9811000005'),
('Aditya Kulkarni', 'aditya@shopmail.com', 'Pune', 'Maharashtra', '2024-07-02', '9811000006'),
('Farah Ahmed', 'farah@shopmail.com', 'Hyderabad', 'Telangana', '2025-01-13', '9811000007'),
('Dev Menon', 'dev@shopmail.com', 'Kochi', 'Kerala', '2025-02-17', '9811000008'),
('Ishita Roy', 'ishita@shopmail.com', 'Kolkata', 'West Bengal', '2025-03-21', '9811000009'),
('Manav Joshi', 'manav@shopmail.com', 'Ahmedabad', 'Gujarat', '2025-04-05', '9811000010');

INSERT INTO categories (category_name) VALUES
('Computers'), ('Clothing'), ('Kitchen Appliances'), ('Stationery'), ('Fitness');

INSERT INTO products (product_name, category_id, price, cost, stock_qty) VALUES
('Bluetooth Speaker', 1, 3499.00, 2100.00, 95),
('Nova Smartphone', 1, 21999.00, 16500.00, 35),
('Ultrabook 15', 1, 58999.00, 47000.00, 12),
('Linen Shirt', 2, 899.00, 390.00, 240),
('Running Shoes', 2, 2499.00, 1300.00, 130),
('Electric Kettle', 3, 1899.00, 1100.00, 75),
('Food Processor', 3, 4299.00, 2800.00, 55),
('Python Guidebook', 4, 799.00, 370.00, 180),
('Resistance Bands', 5, 699.00, 280.00, 160),
('Adjustable Dumbbell', 5, 4999.00, 3100.00, 30),
('Unused USB Hub', 1, 1299.00, 700.00, 18);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2025-01-14', 'Delivered'), (2, '2025-01-28', 'Delivered'),
(3, '2025-02-06', 'Delivered'), (1, '2025-02-21', 'Delivered'),
(4, '2025-03-10', 'Returned'), (5, '2025-03-24', 'Delivered'),
(6, '2025-04-05', 'Cancelled'), (7, '2025-04-18', 'Delivered'),
(2, '2025-05-12', 'Delivered'), (8, '2025-05-30', 'Shipped'),
(9, '2025-06-17', 'Delivered'), (1, '2025-07-03', 'Delivered'),
(3, '2025-07-22', 'Delivered'), (4, '2025-08-11', 'Delivered'),
(5, '2025-09-15', 'Delivered'), (7, '2025-10-04', 'Shipped');

INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_pct) VALUES
(1, 1, 2, 3499.00, 10), (1, 4, 2, 899.00, 0),
(2, 2, 1, 21999.00, 5),
(3, 6, 2, 1899.00, 0), (3, 8, 1, 799.00, 0),
(4, 3, 1, 58999.00, 8),
(5, 5, 1, 2499.00, 0),
(6, 7, 1, 4299.00, 10), (6, 9, 3, 699.00, 0),
(7, 10, 1, 4999.00, 0),
(8, 1, 1, 3499.00, 0), (8, 5, 2, 2499.00, 5),
(9, 2, 1, 21999.00, 10),
(10, 4, 4, 899.00, 0),
(11, 6, 1, 1899.00, 5), (11, 8, 2, 799.00, 0),
(12, 1, 2, 3499.00, 15),
(13, 9, 3, 699.00, 0), (13, 10, 1, 4999.00, 10),
(14, 3, 1, 58999.00, 0),
(15, 7, 2, 4299.00, 5),
(16, 2, 1, 21999.00, 0);

INSERT INTO payments (order_id, method, amount, paid_on)
SELECT o.order_id,
       ELT(1 + MOD(o.order_id, 4), 'Card', 'UPI', 'COD', 'NetBanking'),
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2),
       CASE WHEN o.status = 'Shipped' THEN NULL ELSE o.order_date END
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status <> 'Cancelled'
GROUP BY o.order_id, o.status, o.order_date;

UPDATE products SET price = 3299.00 WHERE product_name = 'Bluetooth Speaker';

UPDATE products
SET price = ROUND(price * 1.05, 2)
WHERE category_id = (SELECT category_id FROM categories WHERE category_name = 'Stationery');

UPDATE products p
JOIN (
    SELECT product_id, SUM(quantity) AS sold
    FROM order_items
    GROUP BY product_id
) s ON s.product_id = p.product_id
SET p.stock_qty = p.stock_qty - s.sold;

UPDATE payments pay
JOIN orders o ON o.order_id = pay.order_id
SET pay.pay_status = 'Refunded'
WHERE o.status = 'Returned';

UPDATE payments SET pay_status = 'Pending' WHERE paid_on IS NULL;

INSERT INTO customers (full_name, email, city, state, signup_date)
VALUES ('Sample Buyer', 'sample@shopmail.com', 'Mysuru', 'Karnataka', '2025-10-13');
DELETE FROM customers WHERE email = 'sample@shopmail.com';

START TRANSACTION;
UPDATE products SET stock_qty = 0;
SELECT COUNT(*) AS products_with_zero_stock FROM products WHERE stock_qty = 0;
ROLLBACK;
SELECT COUNT(*) AS products_with_zero_stock_after_rollback FROM products WHERE stock_qty = 0;

START TRANSACTION;
UPDATE products SET stock_qty = stock_qty + 40 WHERE product_name = 'Ultrabook 15';
COMMIT;

SELECT product_id, product_name, price, stock_qty FROM products;
SELECT * FROM payments;

SELECT customer_id, full_name, city FROM customers WHERE city IN ('Chennai', 'Kochi');
SELECT product_name, price FROM products WHERE price BETWEEN 1000 AND 10000 ORDER BY price;
SELECT product_name, price FROM products WHERE product_name LIKE '%Book%' OR product_name LIKE 'Electric%';
SELECT order_id, customer_id, order_date
FROM orders
WHERE status = 'Delivered' AND order_date BETWEEN '2025-01-01' AND '2025-03-31';
SELECT order_id, order_date, status FROM orders WHERE status <> 'Delivered';
SELECT payment_id, order_id, method, amount, pay_status FROM payments WHERE paid_on IS NULL;
SELECT product_name, price FROM products ORDER BY price DESC LIMIT 3;
SELECT DISTINCT city FROM customers ORDER BY city;

SELECT COUNT(*) AS total_products,
       SUM(stock_qty) AS total_units_in_stock,
       ROUND(AVG(price), 2) AS avg_price,
       MIN(price) AS cheapest,
       MAX(price) AS costliest
FROM products;

SELECT COUNT(*) AS total_orders,
       COUNT(DISTINCT customer_id) AS customers_who_ordered
FROM orders;

SELECT SUM(stock_qty * cost) AS inventory_cost_value,
       SUM(stock_qty * price) AS inventory_retail_value
FROM products;

SELECT ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS total_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status IN ('Delivered', 'Shipped');

SELECT SUM(CASE WHEN paid_on IS NOT NULL THEN amount ELSE 0 END) AS collected,
       SUM(CASE WHEN paid_on IS NULL THEN amount ELSE 0 END) AS pending
FROM payments;

SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC, city;

SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;

SELECT c.category_name,
       COUNT(p.product_id) AS products,
       ROUND(AVG(p.price), 2) AS avg_price,
       MIN(p.price) AS min_price,
       MAX(p.price) AS max_price
FROM categories c
JOIN products p ON p.category_id = c.category_id
GROUP BY c.category_name;

SELECT method, COUNT(*) AS payments, SUM(amount) AS total_amount
FROM payments
GROUP BY method
ORDER BY total_amount DESC;

SELECT customer_id, COUNT(*) AS orders_placed
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 2
ORDER BY orders_placed DESC, customer_id;

SELECT product_id, SUM(quantity) AS units_sold
FROM order_items
GROUP BY product_id
HAVING SUM(quantity) > 3
ORDER BY units_sold DESC;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month, COUNT(*) AS orders
FROM orders
WHERE status <> 'Cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

SELECT o.order_id, c.full_name, o.order_date, o.status
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_id
LIMIT 8;

SELECT o.order_id, c.full_name, p.product_name, cat.category_name,
       oi.quantity, oi.discount_pct,
       ROUND(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100), 2) AS line_total
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories cat ON cat.category_id = p.category_id
ORDER BY o.order_id, p.product_name
LIMIT 10;

SELECT c.customer_id, c.full_name
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.order_item_id IS NULL;

SELECT o.order_id, o.status
FROM orders o
LEFT JOIN payments pay ON pay.order_id = o.order_id
WHERE pay.payment_id IS NULL;

SELECT cat.category_name, COUNT(p.product_id) AS products
FROM products p
RIGHT JOIN categories cat ON cat.category_id = p.category_id
GROUP BY cat.category_name;

SELECT cat.category_name,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories cat ON cat.category_id = p.category_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY cat.category_name
ORDER BY revenue DESC;

SELECT c.full_name,
       COUNT(DISTINCT o.order_id) AS orders,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)), 2) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY c.customer_id, c.full_name
HAVING total_spent > 20000
ORDER BY total_spent DESC;

SELECT a.full_name AS customer_1, b.full_name AS customer_2, a.city
FROM customers a
JOIN customers b ON a.city = b.city AND a.customer_id < b.customer_id;

CREATE VIEW v_sales_detail AS
SELECT o.order_id, o.order_date, o.status, c.customer_id, c.full_name, c.state,
       p.product_name, cat.category_name, oi.quantity,
       ROUND(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100), 2) AS revenue,
       ROUND(oi.quantity * p.cost, 2) AS total_cost
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories cat ON cat.category_id = p.category_id;

SELECT COUNT(DISTINCT order_id) AS total_orders,
       COUNT(DISTINCT customer_id) AS active_customers,
       SUM(quantity) AS units_sold,
       ROUND(SUM(revenue), 2) AS total_revenue,
       ROUND(SUM(revenue - total_cost), 2) AS gross_profit,
       ROUND(SUM(revenue - total_cost) / SUM(revenue) * 100, 1) AS profit_margin_pct,
       ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM v_sales_detail
WHERE status IN ('Delivered', 'Shipped');

SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month,
       COUNT(DISTINCT order_id) AS orders,
       ROUND(SUM(revenue), 2) AS revenue,
       ROUND(SUM(revenue - total_cost), 2) AS profit
FROM v_sales_detail
WHERE status IN ('Delivered', 'Shipped')
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

SELECT full_name, ROUND(SUM(revenue), 2) AS revenue
FROM v_sales_detail
WHERE status IN ('Delivered', 'Shipped')
GROUP BY customer_id, full_name
ORDER BY revenue DESC
LIMIT 5;

SELECT state, COUNT(DISTINCT order_id) AS orders, ROUND(SUM(revenue), 2) AS revenue
FROM v_sales_detail
WHERE status IN ('Delivered', 'Shipped')
GROUP BY state
ORDER BY revenue DESC;
