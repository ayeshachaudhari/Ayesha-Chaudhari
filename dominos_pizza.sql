CREATE DATABASE dominos_pizza;

USE dominos_pizza;


USE dominos_pizza;

-- 1. Pizza Types Table
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    ingredients TEXT
);

-- 2. Pizzas Table
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(10),
    price DECIMAL(10,2),
    FOREIGN KEY (pizza_type_id)
        REFERENCES pizza_types(pizza_type_id)
);

-- 3. Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    order_time TIME
);

-- 4. Order Details Table
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id)
        REFERENCES pizzas(pizza_id)
);

SHOW TABLES;


INSERT INTO pizza_types (pizza_type_id, name, category, ingredients) VALUES
('PT001', 'Margherita', 'Classic', 'Tomato Sauce, Mozzarella Cheese, Basil'),
('PT002', 'Pepperoni', 'Classic', 'Tomato Sauce, Mozzarella Cheese, Pepperoni'),
('PT003', 'Farmhouse', 'Veg', 'Tomato Sauce, Mozzarella Cheese, Onion, Capsicum, Mushroom'),
('PT004', 'Veggie Paradise', 'Veg', 'Tomato Sauce, Mozzarella Cheese, Onion, Capsicum, Black Olives'),
('PT005', 'Chicken Dominator', 'Non-Veg', 'Tomato Sauce, Mozzarella Cheese, Chicken, Onion, Capsicum'),
('PT006', 'Chicken Pepperoni', 'Non-Veg', 'Tomato Sauce, Mozzarella Cheese, Chicken, Pepperoni'),
('PT007', 'Cheese Burst', 'Classic', 'Tomato Sauce, Extra Cheese, Mozzarella Cheese'),
('PT008', 'Mexican Green Wave', 'Veg', 'Tomato Sauce, Mozzarella Cheese, Capsicum, Jalapeno, Onion');

SELECT * FROM pizza_types;


INSERT INTO pizzas (pizza_id, pizza_type_id, size, price) VALUES
('P001', 'PT001', 'Small', 199.00),
('P002', 'PT001', 'Medium', 299.00),
('P003', 'PT001', 'Large', 499.00),

('P004', 'PT002', 'Small', 249.00),
('P005', 'PT002', 'Medium', 399.00),
('P006', 'PT002', 'Large', 599.00),

('P007', 'PT003', 'Small', 229.00),
('P008', 'PT003', 'Medium', 349.00),
('P009', 'PT003', 'Large', 549.00),

('P010', 'PT004', 'Small', 219.00),
('P011', 'PT004', 'Medium', 339.00),
('P012', 'PT004', 'Large', 529.00),

('P013', 'PT005', 'Small', 279.00),
('P014', 'PT005', 'Medium', 449.00),
('P015', 'PT005', 'Large', 649.00),

('P016', 'PT006', 'Small', 289.00),
('P017', 'PT006', 'Medium', 459.00),
('P018', 'PT006', 'Large', 669.00),

('P019', 'PT007', 'Small', 239.00),
('P020', 'PT007', 'Medium', 379.00),
('P021', 'PT007', 'Large', 579.00),

('P022', 'PT008', 'Small', 229.00),
('P023', 'PT008', 'Medium', 359.00),
('P024', 'PT008', 'Large', 549.00);

SELECT * FROM pizzas;


INSERT INTO orders (order_id, order_date, order_time) VALUES
(1, '2026-08-01', '11:15:00'),
(2, '2026-08-01', '12:30:00'),
(3, '2026-08-01', '13:45:00'),
(4, '2026-08-02', '14:10:00'),
(5, '2026-08-02', '18:20:00'),
(6, '2026-08-02', '19:45:00'),
(7, '2026-08-03', '12:15:00'),
(8, '2026-08-03', '13:30:00'),
(9, '2026-08-03', '20:10:00'),
(10, '2026-08-04', '11:40:00'),
(11, '2026-08-04', '14:25:00'),
(12, '2026-08-04', '19:30:00'),
(13, '2026-08-05', '12:05:00'),
(14, '2026-08-05', '13:50:00'),
(15, '2026-08-05', '20:25:00'),
(16, '2026-08-06', '11:30:00'),
(17, '2026-08-06', '15:10:00'),
(18, '2026-08-06', '19:15:00'),
(19, '2026-08-07', '12:40:00'),
(20, '2026-08-07', '18:50:00');

SELECT * FROM orders;


INSERT INTO order_details
(order_details_id, order_id, pizza_id, quantity) VALUES
(1, 1, 'P002', 2),
(2, 1, 'P010', 1),
(3, 2, 'P005', 1),
(4, 2, 'P013', 2),
(5, 3, 'P003', 1),
(6, 3, 'P020', 1),
(7, 4, 'P008', 2),
(8, 4, 'P016', 1),
(9, 5, 'P006', 1),
(10, 5, 'P011', 2),
(11, 6, 'P014', 1),
(12, 6, 'P022', 2),
(13, 7, 'P001', 3),
(14, 7, 'P017', 1),
(15, 8, 'P009', 1),
(16, 8, 'P019', 2),
(17, 9, 'P018', 1),
(18, 9, 'P004', 2),
(19, 10, 'P012', 1),
(20, 10, 'P021', 1),
(21, 11, 'P007', 2),
(22, 11, 'P015', 1),
(23, 12, 'P003', 1),
(24, 12, 'P023', 2),
(25, 13, 'P005', 2),
(26, 13, 'P010', 1),
(27, 14, 'P006', 1),
(28, 14, 'P020', 1),
(29, 15, 'P016', 2),
(30, 15, 'P008', 1),
(31, 16, 'P002', 1),
(32, 16, 'P022', 2),
(33, 17, 'P013', 1),
(34, 17, 'P019', 1),
(35, 18, 'P018', 2),
(36, 18, 'P011', 1),
(37, 19, 'P014', 1),
(38, 19, 'P004', 2),
(39, 20, 'P021', 1),
(40, 20, 'P009', 1);

SELECT * FROM order_details;

SELECT * FROM pizza_types;
SELECT * FROM pizzas;
SELECT * FROM orders;
SELECT * FROM order_details;

-- First Analysis Query

SELECT COUNT(*) AS total_orders
FROM orders;

-- Total Pizza Quantity Sold

SELECT SUM(quantity) AS total_pizzas_sold
FROM order_details;

-- Total Revenue

SELECT 
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id;
    
-- Average Order Value

SELECT 
    ROUND(SUM(od.quantity * p.price) / COUNT(DISTINCT od.order_id), 2) 
    AS average_order_value
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id;

-- Best-Selling Pizza by Quantity

SELECT 
    pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity_sold DESC
LIMIT 1;

-- Sales by Pizza Category

SELECT 
    pt.category,
    SUM(od.quantity * p.price) AS total_sales
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_sales DESC;

-- Top 5 Best-Selling Pizzas

SELECT 
    pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Pizza with Highest Revenue

SELECT 
    pt.name AS pizza_name,
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 1;

-- Daily Sales Analysis

SELECT
    o.order_date,
    SUM(od.quantity * p.price) AS daily_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY o.order_date
ORDER BY o.order_date;

-- Peak Ordering Hour

SELECT
    HOUR(order_time) AS order_hour,
    COUNT(*) AS total_orders
FROM orders
GROUP BY HOUR(order_time)
ORDER BY total_orders DESC;

-- Sales by Pizza Size

SELECT
    p.size,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_sales
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_sales DESC;

-- Category-wise Pizza Quantity

SELECT
    pt.category,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity_sold DESC;

-- Highest Spending Order

SELECT
    o.order_id,
    SUM(od.quantity * p.price) AS order_total
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY o.order_id
ORDER BY order_total DESC
LIMIT 1;

-- Lowest Spending Order

SELECT
    o.order_id,
    SUM(od.quantity * p.price) AS order_total
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY o.order_id
ORDER BY order_total ASC
LIMIT 1;

-- Most Ordered Pizza Size

SELECT
    p.size,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;

-- Pizza-wise Sales Report

SELECT
    pt.name AS pizza_name,
    pt.category,
    p.size,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name, pt.category, p.size
ORDER BY total_revenue DESC;

-- Top 5 Revenue-Generating Pizza Types

SELECT
    pt.name AS pizza_name,
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 5;

-- Orders by Date

SELECT
    order_date,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- Highest Number of Orders in a Day

SELECT
    order_date,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY total_orders DESC
LIMIT 1;

-- Pizza Sales View

USE dominos_pizza;

CREATE VIEW pizza_sales_view AS
SELECT
    pt.name AS pizza_name,
    pt.category,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name, pt.category;

SELECT * FROM pizza_sales_view;

-- Daily Sales View

CREATE VIEW daily_sales_view AS
SELECT
    o.order_date,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity) AS total_pizzas_sold,
    SUM(od.quantity * p.price) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY o.order_date
ORDER BY o.order_date;
SELECT * FROM daily_sales_view;

-- Category Sales View

CREATE VIEW category_sales_view AS
SELECT
    pt.category,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_sales
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;
SELECT * FROM category_sales_view;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- Stored Procedure 1

USE dominos_pizza;

DELIMITER //

CREATE PROCEDURE GetCategorySales(IN p_category VARCHAR(50))
BEGIN
    SELECT
        pt.name AS pizza_name,
        pt.category,
        SUM(od.quantity) AS total_quantity_sold,
        SUM(od.quantity * p.price) AS total_revenue
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    WHERE pt.category = p_category
    GROUP BY pt.name, pt.category
    ORDER BY total_revenue DESC;
END //

DELIMITER ;
CALL GetCategorySales('Classic');

-- Stored Procedure 2

USE dominos_pizza;

DELIMITER //

CREATE PROCEDURE GetDailySales(IN p_date DATE)
BEGIN
    SELECT
        o.order_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(od.quantity) AS total_pizzas_sold,
        SUM(od.quantity * p.price) AS total_sales
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    WHERE o.order_date = p_date
    GROUP BY o.order_date;
END //

DELIMITER ;
CALL GetDailySales('2026-08-04');

-- Stored Procedure 3

USE dominos_pizza;

DELIMITER //

CREATE PROCEDURE GetPizzaSales(IN p_pizza_name VARCHAR(100))
BEGIN
    SELECT
        pt.name AS pizza_name,
        pt.category,
        SUM(od.quantity) AS total_quantity_sold,
        SUM(od.quantity * p.price) AS total_revenue
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    WHERE pt.name = p_pizza_name
    GROUP BY pt.name, pt.category;
END //

DELIMITER ;
CALL GetPizzaSales('Pepperoni');

-- Stored Procedure 4

USE dominos_pizza;

DELIMITER //

CREATE PROCEDURE GetTop5Pizzas()
BEGIN
    SELECT
        pt.name AS pizza_name,
        SUM(od.quantity) AS total_quantity_sold,
        SUM(od.quantity * p.price) AS total_revenue
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.name
    ORDER BY total_quantity_sold DESC
    LIMIT 5;
END //

DELIMITER ;
CALL GetTop5Pizzas();

-- Stored Procedure 5: Order Details

USE dominos_pizza;

DELIMITER //

CREATE PROCEDURE GetOrderDetails(IN p_order_id INT)
BEGIN
    SELECT
        o.order_id,
        o.order_date,
        pt.name AS pizza_name,
        pt.category,
        p.size,
        od.quantity,
        p.price,
        (od.quantity * p.price) AS item_total
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    WHERE o.order_id = p_order_id;
END //

DELIMITER ;
CALL GetOrderDetails(18);

-- Stored Procedure 6: Sales by Pizza Size

USE dominos_pizza;

DELIMITER //

CREATE PROCEDURE GetSizeSales(IN p_size VARCHAR(10))
BEGIN
    SELECT
        p.size,
        SUM(od.quantity) AS total_quantity_sold,
        SUM(od.quantity * p.price) AS total_sales
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    WHERE p.size = p_size
    GROUP BY p.size;
END //

DELIMITER ;
CALL GetSizeSales('Large');

-- Stored Procedure 7: Category Quantity

USE dominos_pizza;

DELIMITER //

CREATE PROCEDURE GetCategoryQuantity(IN p_category VARCHAR(50))
BEGIN
    SELECT
        pt.category,
        SUM(od.quantity) AS total_quantity_sold
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    WHERE pt.category = p_category
    GROUP BY pt.category;
END //

DELIMITER ;
CALL GetCategoryQuantity('Veg');

-- Function 1 — Get Order Total

USE dominos_pizza;

DELIMITER //

CREATE FUNCTION GetOrderTotal(p_order_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_amount DECIMAL(10,2);

    SELECT COALESCE(SUM(od.quantity * p.price), 0)
    INTO total_amount
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    WHERE od.order_id = p_order_id;

    RETURN total_amount;
END //

DELIMITER ;
SELECT GetOrderTotal(18) AS order_total;

-- Function 2: Get User Order Count

DROP FUNCTION IF EXISTS GetUserOrderCount;
DELIMITER //

CREATE FUNCTION GetOrderCountByDate(p_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_orders INT;

    SELECT COUNT(*)
    INTO total_orders
    FROM orders
    WHERE order_date = p_date;

    RETURN total_orders;
END //

DELIMITER ;
SELECT GetOrderCountByDate('2026-08-01') AS total_orders;

-- Function 3: Get Daily Sales

DELIMITER //

CREATE FUNCTION GetDailySalesAmount(p_date DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_sales DECIMAL(10,2);

    SELECT COALESCE(SUM(od.quantity * p.price), 0)
    INTO total_sales
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    WHERE o.order_date = p_date;

    RETURN total_sales;
END //

DELIMITER ;
SELECT GetDailySalesAmount('2026-08-04') AS daily_sales;

-- Function 4: Get Pizza Quantity Sold

DELIMITER //

CREATE FUNCTION GetPizzaQuantity(p_pizza_name VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_quantity INT;

    SELECT COALESCE(SUM(od.quantity), 0)
    INTO total_quantity
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    WHERE pt.name = p_pizza_name;

    RETURN total_quantity;
END //

DELIMITER ;
SELECT GetPizzaQuantity('Pepperoni') AS quantity_sold;

-- Function 5: Get Pizza Revenue

DELIMITER //

CREATE FUNCTION GetPizzaRevenue(p_pizza_name VARCHAR(100))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(10,2);

    SELECT COALESCE(SUM(od.quantity * p.price), 0)
    INTO total_revenue
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    WHERE pt.name = p_pizza_name;

    RETURN total_revenue;
END //

DELIMITER ;
SELECT GetPizzaRevenue('Pepperoni') AS total_revenue;

-- Function 6: Get Category Revenue

DELIMITER //

CREATE FUNCTION GetCategoryRevenue(p_category VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(10,2);

    SELECT COALESCE(SUM(od.quantity * p.price), 0)
    INTO total_revenue
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    WHERE pt.category = p_category;

    RETURN total_revenue;
END //

DELIMITER ;
SELECT GetCategoryRevenue('Classic') AS total_revenue;

-- Get Size Revenue

DELIMITER //

CREATE FUNCTION GetSizeRevenue(p_size VARCHAR(20))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(10,2);

    SELECT COALESCE(SUM(od.quantity * p.price), 0)
    INTO total_revenue
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    WHERE p.size = p_size;

    RETURN total_revenue;
END //

DELIMITER ;
SELECT GetSizeRevenue('Large') AS total_revenue;

-- Functions ka Final Check

SHOW FUNCTION STATUS
WHERE Db = 'dominos_pizza';

DESCRIBE pizzas;

-- Final Database Objects Check
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- Stored Procedures Check

SHOW PROCEDURE STATUS
WHERE Db = 'dominos_pizza';

SHOW TABLES;

-- Important Final Query

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity) AS total_pizzas_sold,
    SUM(od.quantity * p.price) AS total_revenue
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id;
    
-- Average Order Value

SELECT
    ROUND(SUM(od.quantity * p.price) / COUNT(DISTINCT o.order_id), 2)
    AS average_order_value
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id;
    
-- Highest Revenue Pizza

SELECT
    pt.name AS pizza_name,
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 1;

-- Lowest Revenue Pizza

SELECT
    pt.name AS pizza_name,
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue ASC
LIMIT 1;

-- Most Popular Pizza Size

SELECT
    p.size,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity_sold DESC
LIMIT 1;

-- Most Popular Pizza Category

SELECT
    pt.category,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity_sold DESC
LIMIT 1;

-- Best Sales Day

SELECT
    o.order_date,
    SUM(od.quantity * p.price) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY o.order_date
ORDER BY total_sales DESC
LIMIT 1;

-- Lowest Sales Day

SELECT
    o.order_date,
    SUM(od.quantity * p.price) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY o.order_date
ORDER BY total_sales ASC
LIMIT 1;

-- Most Ordered Pizza

SELECT
    pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity_sold DESC
LIMIT 1;