CREATE DATABASE BankDB;
USE BankDB;

CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(60) NOT NULL UNIQUE,
    city VARCHAR(50) DEFAULT 'Bengaluru'
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(80) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50) DEFAULT 'Bengaluru',
    joined_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_type VARCHAR(20) NOT NULL DEFAULT 'Savings',
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    opened_date DATE NOT NULL,
    status VARCHAR(15) NOT NULL DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE transactions (
    txn_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    txn_type VARCHAR(12) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    txn_date DATE NOT NULL,
    remarks VARCHAR(100),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    loan_type VARCHAR(30) NOT NULL,
    principal DECIMAL(12,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    start_date DATE NOT NULL,
    status VARCHAR(15) NOT NULL DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

ALTER TABLE customers ADD COLUMN phone VARCHAR(15);
ALTER TABLE customers ADD COLUMN credit_score INT DEFAULT 700;
ALTER TABLE customers MODIFY COLUMN phone VARCHAR(20);
ALTER TABLE customers RENAME COLUMN phone TO mobile_no;
ALTER TABLE customers DROP COLUMN mobile_no;
ALTER TABLE loans ADD COLUMN end_date DATE;

CREATE INDEX idx_txn_date ON transactions(txn_date);

CREATE TABLE atm_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(200) NOT NULL
);

INSERT INTO atm_log (message) VALUES
('ATM 15 cash low'),
('ATM 09 card issue'),
('ATM 21 maintenance');

TRUNCATE TABLE atm_log;
DROP TABLE atm_log;

DESCRIBE accounts;
SHOW TABLES;

INSERT INTO branches (branch_name, city) VALUES
('Koramangala Branch', 'Bengaluru'),
('Bandra Branch', 'Mumbai'),
('Karol Bagh Branch', 'Delhi'),
('Anna Nagar Branch', 'Chennai');

INSERT INTO customers (full_name, email, city, joined_date) VALUES
('Rahul Sharma', 'rahul@example.com', 'Delhi', '2022-02-12'),
('Priya Nair', 'priya@example.com', 'Bengaluru', '2021-06-15'),
('Amit Verma', 'amit@example.com', 'Mumbai', '2023-02-20'),
('Sneha Kapoor', 'sneha@example.com', 'Pune', '2023-07-10'),
('Karan Mehta', 'karan@example.com', 'Chennai', '2020-10-25'),
('Divya Reddy', 'divya@example.com', 'Mumbai', '2022-08-14'),
('Imran Khan', 'imran@example.com', 'Bengaluru', '2024-03-11'),
('Ananya Das', 'ananya@example.com', 'Chennai', '2026-08-25');

INSERT INTO accounts (customer_id, branch_id, account_type, balance, opened_date) VALUES
(1, 3, 'Savings', 95000.00, '2022-02-12'),
(1, 3, 'Current', 220000.00, '2022-05-15'),
(2, 1, 'Savings', 135000.00, '2021-06-15'),
(3, 2, 'Savings', 55000.00, '2023-02-20'),
(4, 2, 'Savings', 40000.00, '2023-07-10'),
(5, 4, 'Savings', 110000.00, '2020-10-25'),
(6, 2, 'Current', 350000.00, '2022-08-14'),
(7, 1, 'Savings', 25000.00, '2024-03-11'),
(2, 1, 'Fixed Deposit', 280000.00, '2025-02-10'),
(5, 4, 'Current', 160000.00, '2021-05-12');

INSERT INTO transactions (account_id, txn_type, amount, txn_date, remarks) VALUES
(1, 'Deposit', 25000.00, '2026-07-04', 'Monthly salary'),
(1, 'Withdrawal', 7000.00, '2026-07-12', 'Shopping payment'),
(3, 'Deposit', 40000.00, '2026-07-06', 'Salary transfer'),
(3, 'Withdrawal', 15000.00, '2026-07-19', 'House rent'),
(4, 'Deposit', 12000.00, '2026-07-23', 'Branch cash deposit'),
(6, 'Withdrawal', 9000.00, '2026-08-03', 'ATM cash withdrawal'),
(7, 'Deposit', 140000.00, '2026-08-06', 'Customer payment'),
(7, 'Withdrawal', 55000.00, '2026-08-20', 'Supplier payment'),
(2, 'Deposit', 85000.00, '2026-08-26', 'Sales income'),
(8, 'Withdrawal', 4000.00, '2026-09-02', 'Personal expenses'),
(5, 'Deposit', 6000.00, '2026-09-05', 'Cash received'),
(10, 'Deposit', 95000.00, '2026-09-11', 'Business income'),
(3, 'Withdrawal', 18000.00, '2026-09-16', 'Bill payment'),
(6, 'Deposit', 30000.00, '2026-09-21', 'Monthly salary'),
(1, 'Withdrawal', 12000.00, '2026-09-23', 'Online purchase');

INSERT INTO loans (customer_id, loan_type, principal, interest_rate, start_date, status) VALUES
(1, 'Home Loan', 4200000.00, 8.75, '2025-04-05', 'Active'),
(2, 'Car Loan', 750000.00, 9.50, '2025-11-20', 'Active'),
(3, 'Personal Loan', 350000.00, 12.50, '2026-02-15', 'Active'),
(5, 'Business Loan', 1800000.00, 11.25, '2025-08-25', 'Active'),
(6, 'Home Loan', 3000000.00, 9.00, '2024-12-10', 'Active'),
(7, 'Personal Loan', 175000.00, 13.75, '2026-05-20', 'Closed'),
(4, 'Car Loan', 650000.00, 9.75, '2026-03-05', 'Active');

INSERT INTO customers (full_name, email) VALUES
('Test Person', 'testperson@example.com');

SELECT customer_id, full_name, city, joined_date, credit_score
FROM customers
WHERE full_name = 'Test Person';

CREATE TABLE high_value_accounts AS
SELECT * FROM accounts WHERE 1 = 0;

INSERT INTO high_value_accounts
SELECT * FROM accounts
WHERE balance >= 200000;

SELECT * FROM high_value_accounts;

SET SQL_SAFE_UPDATES = 1;

UPDATE customers
SET credit_score = 780
WHERE customer_id = 2;

INSERT INTO transactions (account_id, txn_type, amount, txn_date, remarks)
SELECT account_id, 'Deposit', ROUND(balance * 0.01, 2), '2026-09-30', 'Quarterly interest'
FROM accounts
WHERE account_type = 'Savings' AND status = 'Active';

SET SQL_SAFE_UPDATES = 0;

UPDATE accounts
SET balance = ROUND(balance * 1.01, 2)
WHERE account_type = 'Savings' AND status = 'Active';

SET SQL_SAFE_UPDATES = 1;

INSERT INTO customers (full_name, email, city)
VALUES ('Meera Iyer', 'meera@example.com', 'Delhi');

SET @new_customer = LAST_INSERT_ID();

INSERT INTO accounts (customer_id, branch_id, account_type, balance, opened_date)
VALUES (@new_customer, 3, 'Savings', 15000.00, '2026-09-25');

SET @new_account = LAST_INSERT_ID();

INSERT INTO transactions (account_id, txn_type, amount, txn_date, remarks)
VALUES (@new_account, 'Deposit', 15000.00, '2026-09-25', 'Initial deposit');

INSERT INTO transactions (account_id, txn_type, amount, txn_date, remarks)
VALUES (2, 'Withdrawal', 35000.00, '2026-09-26', 'Cheque withdrawal');

UPDATE accounts
SET balance = balance - 35000.00
WHERE account_id = 2;

INSERT INTO transactions (account_id, txn_type, amount, txn_date, remarks)
SELECT account_id, 'Withdrawal', balance, '2026-09-28', 'Account closure payment'
FROM accounts
WHERE account_id = 8;

UPDATE accounts
SET balance = 0, status = 'Closed'
WHERE account_id = 8;

SET SQL_SAFE_UPDATES = 0;

UPDATE loans
SET interest_rate = interest_rate - 0.25
WHERE loan_type = 'Home Loan' AND status = 'Active';

SET SQL_SAFE_UPDATES = 1;

UPDATE loans
SET status = 'Closed', end_date = '2026-09-27'
WHERE loan_id = 3;

INSERT INTO transactions (account_id, txn_type, amount, txn_date, remarks)
VALUES (3, 'Deposit', 888888.00, '2026-09-28', 'Incorrect transaction');

SET @wrong_txn = LAST_INSERT_ID();

DELETE FROM transactions
WHERE txn_id = @wrong_txn;

DELETE FROM customers
WHERE full_name = 'Test Person' AND customer_id = 9;

DROP TABLE high_value_accounts;

SELECT * FROM branches;

SELECT full_name, city FROM customers;

SELECT account_id, account_type, balance
FROM accounts
WHERE balance > 100000;

SELECT account_id, balance
FROM accounts
WHERE balance BETWEEN 50000 AND 150000;

SELECT full_name, city
FROM customers
WHERE city IN ('Mumbai', 'Chennai');

SELECT full_name
FROM customers
WHERE full_name LIKE 'P%' OR full_name LIKE '%Iyer';

SELECT loan_id, loan_type
FROM loans
WHERE end_date IS NULL;

SELECT DISTINCT account_type
FROM accounts;

SELECT account_id, balance
FROM accounts
ORDER BY balance DESC
LIMIT 5;

SELECT loan_id, loan_type, principal, interest_rate,
       ROUND(principal * interest_rate / 100, 2) AS yearly_interest,
       TIMESTAMPDIFF(MONTH, start_date, CURDATE()) AS months_running
FROM loans;

SELECT account_id, balance,
       CASE
           WHEN balance >= 250000 THEN 'Premium'
           WHEN balance >= 50000 THEN 'Regular'
           ELSE 'Basic'
       END AS customer_tier
FROM accounts
WHERE status = 'Active'
ORDER BY balance DESC;

SELECT a.account_id, c.full_name, a.account_type, a.balance, b.branch_name
FROM accounts a
JOIN customers c ON c.customer_id = a.customer_id
JOIN branches b ON b.branch_id = a.branch_id
ORDER BY c.full_name;

SELECT t.txn_id, t.txn_date, c.full_name, a.account_type,
       t.txn_type, t.amount, t.remarks
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
JOIN customers c ON c.customer_id = a.customer_id
ORDER BY t.txn_date, t.txn_id;

SELECT c.customer_id, c.full_name
FROM customers c
LEFT JOIN accounts a ON a.customer_id = c.customer_id
WHERE a.account_id IS NULL;

SELECT DISTINCT c.full_name
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
JOIN loans l ON l.customer_id = c.customer_id;

SELECT account_id, account_type, balance
FROM accounts
WHERE balance > (
    SELECT AVG(balance)
    FROM accounts
    WHERE status = 'Active'
)
ORDER BY balance DESC;

SELECT a.account_id, a.account_type, a.balance
FROM accounts a
WHERE a.balance > (
    SELECT AVG(balance)
    FROM accounts
    WHERE account_type = a.account_type
);

SELECT COUNT(*) AS total_accounts,
       SUM(balance) AS total_deposits,
       ROUND(AVG(balance), 2) AS average_balance,
       MIN(balance) AS smallest_balance,
       MAX(balance) AS largest_balance
FROM accounts
WHERE status = 'Active';

SELECT account_type,
       COUNT(*) AS accounts,
       SUM(balance) AS total_balance,
       ROUND(AVG(balance), 2) AS avg_balance
FROM accounts
WHERE status = 'Active'
GROUP BY account_type
ORDER BY total_balance DESC;

SELECT b.branch_name, b.city,
       COUNT(a.account_id) AS accounts,
       SUM(a.balance) AS deposits_held,
       MAX(a.balance) AS largest_account
FROM branches b
JOIN accounts a ON a.branch_id = b.branch_id
WHERE a.status = 'Active'
GROUP BY b.branch_name, b.city
ORDER BY deposits_held DESC;

SELECT b.branch_name, SUM(a.balance) AS deposits_held
FROM branches b
JOIN accounts a ON a.branch_id = b.branch_id
WHERE a.status = 'Active'
GROUP BY b.branch_name
HAVING SUM(a.balance) > 500000;

SELECT txn_type,
       COUNT(*) AS transactions,
       SUM(amount) AS total_amount,
       AVG(amount) AS average_amount,
       MAX(amount) AS largest
FROM transactions
GROUP BY txn_type;

SELECT DATE_FORMAT(txn_date, '%Y-%m') AS month,
       SUM(CASE WHEN txn_type = 'Deposit' THEN amount ELSE 0 END) AS money_in,
       SUM(CASE WHEN txn_type = 'Withdrawal' THEN amount ELSE 0 END) AS money_out
FROM transactions
GROUP BY DATE_FORMAT(txn_date, '%Y-%m')
ORDER BY month;

SELECT c.full_name,
       COUNT(a.account_id) AS accounts_held,
       SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
WHERE a.status = 'Active'
GROUP BY c.full_name
HAVING SUM(a.balance) >= 200000
ORDER BY total_balance DESC;

SELECT loan_type,
       COUNT(*) AS loans,
       SUM(principal) AS total_lent,
       ROUND(AVG(interest_rate), 2) AS avg_interest_rate,
       MIN(interest_rate) AS lowest_rate,
       MAX(interest_rate) AS highest_rate
FROM loans
WHERE status = 'Active'
GROUP BY loan_type
ORDER BY total_lent DESC;

SELECT c.full_name,
       COUNT(l.loan_id) AS active_loans,
       SUM(l.principal) AS total_borrowed
FROM customers c
JOIN loans l ON l.customer_id = c.customer_id
WHERE l.status = 'Active'
GROUP BY c.full_name
HAVING SUM(l.principal) > 1000000;

SELECT c.full_name,
       SUM(CASE WHEN t.txn_type = 'Deposit' THEN t.amount ELSE -t.amount END) AS net_flow
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
JOIN customers c ON c.customer_id = a.customer_id
GROUP BY c.full_name
ORDER BY net_flow DESC;

CREATE USER 'bank_teller'@'localhost' IDENTIFIED BY 'Teller@123';
CREATE USER 'loan_officer'@'localhost' IDENTIFIED BY 'Loan@123';
CREATE USER 'internal_auditor'@'localhost' IDENTIFIED BY 'Audit@123';

GRANT SELECT ON BankDB.customers TO 'bank_teller'@'localhost';
GRANT SELECT, UPDATE ON BankDB.accounts TO 'bank_teller'@'localhost';
GRANT SELECT, INSERT ON BankDB.transactions TO 'bank_teller'@'localhost';

GRANT SELECT, INSERT, UPDATE ON BankDB.loans TO 'loan_officer'@'localhost';
GRANT SELECT ON BankDB.customers TO 'loan_officer'@'localhost';

GRANT SELECT ON BankDB.* TO 'internal_auditor'@'localhost';

SHOW GRANTS FOR 'bank_teller'@'localhost';
SHOW GRANTS FOR 'loan_officer'@'localhost';

REVOKE UPDATE ON BankDB.accounts FROM 'bank_teller'@'localhost';
REVOKE UPDATE ON BankDB.loans FROM 'loan_officer'@'localhost';

SHOW GRANTS FOR 'bank_teller'@'localhost';

DROP USER 'bank_teller'@'localhost';
DROP USER 'loan_officer'@'localhost';
DROP USER 'internal_auditor'@'localhost';

SET autocommit = 0;

START TRANSACTION;

UPDATE customers
SET credit_score = credit_score + 10
WHERE customer_id = 4;

COMMIT;

START TRANSACTION;

UPDATE accounts
SET balance = 0
WHERE account_id = 7;

SELECT account_id, balance
FROM accounts
WHERE account_id = 7;

ROLLBACK;

SELECT account_id, balance
FROM accounts
WHERE account_id = 7;

START TRANSACTION;

UPDATE customers
SET credit_score = credit_score + 20
WHERE customer_id = 5;

SAVEPOINT after_score;

UPDATE customers
SET city = 'Hyderabad'
WHERE customer_id = 5;

SAVEPOINT after_city;

ROLLBACK TO SAVEPOINT after_score;

COMMIT;

SELECT customer_id, full_name, city, credit_score
FROM customers
WHERE customer_id = 5;

START TRANSACTION;

UPDATE accounts
SET balance = balance - 10000.00
WHERE account_id = 3;

UPDATE accounts
SET balance = balance + 10000.00
WHERE account_id = 1;

INSERT INTO transactions (account_id, txn_type, amount, txn_date, remarks) VALUES
(3, 'Withdrawal', 10000.00, '2026-09-29', 'Transfer to account 1'),
(1, 'Deposit', 10000.00, '2026-09-29', 'Transfer from account 3');

SELECT account_id, balance
FROM accounts
WHERE account_id IN (1, 3);

COMMIT;

START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000.00
WHERE account_id = 3;

ROLLBACK;

SELECT account_id, balance
FROM accounts
WHERE account_id = 3;

SET autocommit = 1;