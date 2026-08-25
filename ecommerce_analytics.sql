CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    gender VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    payment_amount DECIMAL(10,2),
    payment_date DATETIME,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

INSERT INTO categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen'),
(4, 'Beauty'),
(5, 'Sports'),
(6, 'Books'),
(7, 'Toys'),
(8, 'Groceries'),
(9, 'Footwear'),
(10, 'Accessories');

INSERT INTO products
(product_id, product_name, category_id, price)
VALUES
(1, 'Wireless Headphones', 1, 2499.00),
(2, 'Smart Watch', 1, 3999.00),
(3, 'Bluetooth Speaker', 1, 1999.00),
(4, 'Laptop Backpack', 10, 1499.00),
(5, 'Cotton T-Shirt', 2, 699.00),
(6, 'Denim Jeans', 2, 1499.00),
(7, 'Running Shoes', 9, 2999.00),
(8, 'Sports T-Shirt', 5, 999.00),
(9, 'Coffee Maker', 3, 3499.00),
(10, 'Non-Stick Pan', 3, 1299.00),
(11, 'Face Wash', 4, 399.00),
(12, 'Shampoo', 4, 599.00),
(13, 'Cricket Bat', 5, 2499.00),
(14, 'Yoga Mat', 5, 799.00),
(15, 'Python Programming Book', 6, 899.00),
(16, 'SQL for Beginners', 6, 699.00),
(17, 'Building Blocks', 7, 999.00),
(18, 'Remote Control Car', 7, 1499.00),
(19, 'Organic Rice 5kg', 8, 549.00),
(20, 'Green Tea', 8, 299.00);

SELECT * FROM categories;
SELECT * FROM products;

SELECT COUNT(*) AS total_categories
FROM categories;

SELECT COUNT(*) AS total_products
FROM products;

INSERT INTO customers
(customer_id, customer_name, email, gender, city, state, signup_date)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 100
)
SELECT
    n,
    CONCAT('Customer ', n),
    CONCAT('customer', n, '@example.com'),
    CASE
        WHEN MOD(n, 2) = 0 THEN 'Female'
        ELSE 'Male'
    END,
    CASE MOD(n, 5)
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Bangalore'
        WHEN 3 THEN 'Pune'
        ELSE 'Hyderabad'
    END,
    CASE MOD(n, 5)
        WHEN 0 THEN 'Maharashtra'
        WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Karnataka'
        WHEN 3 THEN 'Maharashtra'
        ELSE 'Telangana'
    END,
    DATE_ADD('2023-01-01', INTERVAL MOD(n * 17, 730) DAY)
FROM numbers;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT *FROM customers
LIMIT 10;

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 500
)
SELECT
    n AS order_id,

    -- Customer 1–100
    MOD(n - 1, 100) + 1 AS customer_id,

    -- Orders spread across 2023–2024
    DATE_ADD(
        '2023-01-01',
        INTERVAL MOD(n * 13, 730) DAY
    ) + INTERVAL MOD(n * 7, 24) HOUR AS order_date,

    -- Different order statuses
    CASE
        WHEN MOD(n, 20) = 0 THEN 'Cancelled'
        WHEN MOD(n, 25) = 0 THEN 'Returned'
        ELSE 'Completed'
    END AS order_status

FROM numbers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

SELECT *FROM orders
LIMIT 10;


INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 1000
)
SELECT
    n AS order_item_id,

    -- Order IDs 1–500
    MOD(n - 1, 500) + 1 AS order_id,

    -- Product IDs 1–20
    MOD(n * 7 - 1, 20) + 1 AS product_id,

    -- Quantity 1–5
    MOD(n, 5) + 1 AS quantity,

    p.price AS unit_price

FROM numbers
JOIN products p
    ON p.product_id = MOD(n * 7 - 1, 20) + 1;
    
    SELECT COUNT(*) AS total_order_items
FROM order_items;

SELECT *
FROM order_items
LIMIT 10;

SELECT
    SUM(quantity * unit_price) AS total_gross_sales
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed';

-- Step 1 — Basic Customer EDA

-- Total Customers

SELECT COUNT(*) AS total_customers
FROM customers;

-- Gender-wise customers

SELECT 
    gender,
    COUNT(*) AS customer_count
FROM customers
GROUP BY gender;

-- City-wise customers

SELECT 
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

-- State-wise customers
SELECT 
    state,
    COUNT(*) AS customer_count
FROM customers
GROUP BY state
ORDER BY customer_count DESC;

-- Step 2 — Customer Registration Trend

DESCRIBE customers;
SHOW COLUMNS FROM customers;

SELECT
    YEAR(signup_date) AS signup_year,
    MONTH(signup_date) AS signup_month,
    MONTHNAME(signup_date) AS month_name,
    COUNT(*) AS new_customers
FROM customers
GROUP BY
    YEAR(signup_date),
    MONTH(signup_date),
    MONTHNAME(signup_date)
ORDER BY
    signup_year,
    signup_month;
    
-- City-wise Customer Analysis

SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

-- Gender-wise Analysis

SELECT
    gender,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers),
        2
    ) AS percentage
FROM customers
GROUP BY gender
ORDER BY customer_count DESC;

-- State-wise Customer Analysis

SELECT
    state,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers),
        2
    ) AS percentage
FROM customers
GROUP BY state
ORDER BY customer_count DESC;


SHOW TABLES;

-- Step 1 — Orders table
DESCRIBE orders;

-- Total Orders
SELECT 
    COUNT(*) AS total_orders
FROM orders;

-- Order Status Analysis

SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Monthly Order Trend
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    MONTHNAME(order_date) AS month_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY
    order_year,
    order_month;
    
-- Customer-wise Order Count

SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- Customer + Order Analysis

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.state,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city,
    c.state
ORDER BY total_orders DESC;

SELECT COUNT(*) AS total_orders
FROM orders;

-- 1. Order status distribution

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS percentage
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 2. Monthly order trend

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    MONTHNAME(order_date) AS month_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY
    order_year,
    order_month;
    
-- 3. Orders by customer

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC;

-- 4. Top 10 customers by orders

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC
LIMIT 10;

DESCRIBE order_items;

-- Total Revenue
SELECT
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM order_items;

-- Total quantity sold
SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;

-- Average Order Value (AOV)

SELECT
    ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed';

-- 4. Monthly Revenue

SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    MONTHNAME(o.order_date) AS month_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date),
    MONTHNAME(o.order_date)
ORDER BY
    order_year,
    order_month;

DESCRIBE products;

-- Top 10 Products by Revenue

SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- Top 10 Products by Quantity Sold

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY units_sold DESC
LIMIT 10;

-- Category-wise Revenue

DESCRIBE categories;

-- Product Performance — Revenue + Quantity

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
    ROUND(AVG(oi.unit_price), 2) AS avg_selling_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY revenue DESC;

-- Highest-priced Products

SELECT
    product_id,
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 10;

DESCRIBE categories;

-- Category-wise Revenue

SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.category_id,
    c.category_name
ORDER BY revenue DESC;

-- Category Revenue Contribution %

SELECT
    c.category_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
    ROUND(
        SUM(oi.quantity * oi.unit_price) * 100.0 /
        (
            SELECT SUM(oi2.quantity * oi2.unit_price)
            FROM order_items oi2
            JOIN orders o2
                ON oi2.order_id = o2.order_id
            WHERE o2.order_status = 'Completed'
        ),
        2
    ) AS revenue_percentage
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.category_id,
    c.category_name
ORDER BY revenue DESC;

-- Category-wise Average Selling Price

SELECT
    c.category_name,
    ROUND(AVG(oi.unit_price), 2) AS avg_selling_price,
    MIN(oi.unit_price) AS min_price,
    MAX(oi.unit_price) AS max_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.category_id,
    c.category_name
ORDER BY avg_selling_price DESC;

-- Products per Category

SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_products DESC;

-- Top Customers by Revenue:

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_units,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- Average Spending per Customer

SELECT
    ROUND(AVG(customer_spending), 2) AS avg_customer_spending
FROM (
    SELECT
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS customer_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id
) t;

-- Repeat Customers

SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_id) >= 2
) t;

-- One-time vs Repeat Customers

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customers
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
) t
GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END;
    
-- City-wise Revenue

SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.city
ORDER BY revenue DESC;

-- Gender-wise Revenue

SELECT
    c.gender,
    COUNT(DISTINCT c.customer_id) AS customers,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.gender
ORDER BY revenue DESC;

/*Customer Segmentation — RFM Analysis

R = Recency → customer ne last order kab kiya
F = Frequency → customer ne kitne orders kiye
M = Monetary → customer ne kitna spend kiya
*/

-- Customer RFM Data

SELECT
    c.customer_id,
    c.customer_name,

    DATEDIFF(
        (SELECT MAX(order_date)
         FROM orders
         WHERE order_status = 'Completed'),
        MAX(o.order_date)
    ) AS recency_days,

    COUNT(DISTINCT o.order_id) AS frequency,

    ROUND(
        SUM(oi.quantity * oi.unit_price),
        2
    ) AS monetary
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY monetary DESC;

-- RFM Score

WITH rfm AS (
    SELECT
        c.customer_id,
        c.customer_name,

        DATEDIFF(
            (SELECT MAX(order_date)
             FROM orders
             WHERE order_status = 'Completed'),
            MAX(o.order_date)
        ) AS recency,

        COUNT(DISTINCT o.order_id) AS frequency,

        SUM(oi.quantity * oi.unit_price) AS monetary

    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id

    WHERE o.order_status = 'Completed'

    GROUP BY
        c.customer_id,
        c.customer_name
),

scores AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm
)

SELECT
    customer_id,
    customer_name,
    recency,
    frequency,
    ROUND(monetary, 2) AS monetary,
    r_score,
    f_score,
    m_score,
    CONCAT(r_score, f_score, m_score) AS rfm_score
FROM scores
ORDER BY monetary DESC;

-- Customer Segmentation

WITH rfm AS (
    SELECT
        c.customer_id,
        c.customer_name,

        DATEDIFF(
            (SELECT MAX(order_date)
             FROM orders
             WHERE order_status = 'Completed'),
            MAX(o.order_date)
        ) AS recency,

        COUNT(DISTINCT o.order_id) AS frequency,

        SUM(oi.quantity * oi.unit_price) AS monetary

    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id

    WHERE o.order_status = 'Completed'

    GROUP BY
        c.customer_id,
        c.customer_name
),

scores AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm
)

SELECT
    customer_id,
    customer_name,
    recency,
    frequency,
    ROUND(monetary, 2) AS monetary,
    r_score,
    f_score,
    m_score,

    CASE
        WHEN r_score >= 4
             AND f_score >= 4
             AND m_score >= 4
            THEN 'VIP Customer'

        WHEN f_score >= 4
             AND m_score >= 4
            THEN 'Loyal Customer'

        WHEN r_score >= 4
             AND f_score <= 2
            THEN 'New Customer'

        WHEN r_score <= 2
             AND m_score >= 4
            THEN 'At Risk Customer'

        ELSE 'Regular Customer'
    END AS customer_segment

FROM scores
ORDER BY monetary DESC;

