-- Task 5: SQL Joins (Inner, Left, Right, Full)

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100)
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Customers
INSERT INTO Customers (customer_id, customer_name, email) VALUES
(1, 'Ashlesh', 'ashlesh@email.com'),
(2, 'Sony', 'sony@email.com'),
(3, 'Gagana', 'gagana@email.com'),
(4, 'Hasvitha', 'hasvitha@email.com'),
(5, 'Rahul', 'rahul@email.com'),
(6, 'Priya', 'priya@email.com');  -- Priya has no orders

-- Insert Products
INSERT INTO Products (product_id, product_name, price) VALUES
(101, 'Laptop', 55000.00),
(102, 'Smartphone', 25000.00),
(103, 'Headphones', 3000.00),
(104, 'Smartwatch', 7000.00),
(105, 'Tablet', 20000.00);

-- Insert Orders
INSERT INTO Orders (order_id, customer_id, product_id, order_date) VALUES
(201, 1, 101, '2025-09-01'),  -- Ashlesh bought Laptop
(202, 2, 102, '2025-09-02'),  -- Sony bought Smartphone
(203, 3, 103, '2025-09-03'),  -- Gagana bought Headphones
(204, 1, 104, '2025-09-04'),  -- Ashlesh bought Smartwatch
(205, 4, 105, '2025-09-05');  -- Hasvitha bought Tablet

-- Note: Rahul (customer_id 5) has no orders
-- Priya (customer_id 6) has no orders
-- Note: Product with product_id 106 does not exist, so no orders for it


-- INNER JOIN (only matching records from both tables)
SELECT Customers.customer_id, Customers.customer_name, Orders.order_id, Orders.product_id, Products.product_name
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
INNER JOIN Products ON Orders.product_id = Products.product_id;

-- LEFT JOIN (all customers, with orders if they exist)
SELECT Customers.customer_id, Customers.customer_name, Orders.order_id, Products.product_name
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id
LEFT JOIN Products ON Orders.product_id = Products.product_id;

-- RIGHT JOIN (all orders, with customers if they exist)
SELECT Customers.customer_id, Customers.customer_name, Orders.order_id, Products.product_name
FROM Customers
RIGHT JOIN Orders ON Customers.customer_id = Orders.customer_id
RIGHT JOIN Products ON Orders.product_id = Products.product_id;

-- FULL OUTER JOIN (all customers + all orders)
SELECT Customers.customer_id, Customers.customer_name, Orders.order_id, Products.product_name
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id
LEFT JOIN Products ON Orders.product_id = Products.product_id
UNION
SELECT Customers.customer_id, Customers.customer_name, Orders.order_id, Products.product_name
FROM Customers
RIGHT JOIN Orders ON Customers.customer_id = Orders.customer_id
RIGHT JOIN Products ON Orders.product_id = Products.product_id;
