create database zeptodb;

use zeptodb;

-- 1. USER TABLE 

CREATE TABLE users (
	userid INT  PRIMARY KEY auto_increment,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100)  UNIQUE NOT NULL ,
    phonenumber VARCHAR(15) ,
    createdAt DATETIME  DEFAULT current_timestamp);
    

CREATE TABLE stores (
    storeid INT PRIMARY KEY AUTO_INCREMENT,
    storeName VARCHAR(100) NOT NULL,
    ownerName VARCHAR(100),
    phoneNumber VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(100),
    pincode VARCHAR(10),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE products (
    productid INT PRIMARY KEY AUTO_INCREMENT,
    storeid INT NOT NULL,
    productName VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    description VARCHAR(255),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (storeid) REFERENCES stores(storeid)
);



CREATE TABLE orders (
    orderid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT NOT NULL,
    storeid INT NOT NULL,
    orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    totalAmount DECIMAL(10,2) NOT NULL,
    orderStatus VARCHAR(50) DEFAULT 'Pending',

    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (storeid) REFERENCES stores(storeid)
);

CREATE TABLE order_items (
    orderItemId INT PRIMARY KEY AUTO_INCREMENT,
    orderid INT NOT NULL,
    productid INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (orderid) REFERENCES orders(orderid),
    FOREIGN KEY (productid) REFERENCES products(productid)
);

CREATE TABLE delivery_partners (
    deliveryPartnerId INT PRIMARY KEY AUTO_INCREMENT,
    fullName VARCHAR(100) NOT NULL,
    phoneNumber VARCHAR(15) UNIQUE NOT NULL,
    vehicleNumber VARCHAR(20),
    status VARCHAR(30) DEFAULT 'Available',
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments (
    paymentId INT PRIMARY KEY AUTO_INCREMENT,
    orderid INT NOT NULL,
    paymentMethod VARCHAR(50) NOT NULL,
    paymentStatus VARCHAR(50) DEFAULT 'Pending',
    paymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (orderid) REFERENCES orders(orderid)
);

CREATE TABLE addresses (
    addressId INT PRIMARY KEY AUTO_INCREMENT,
    userid INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    pincode VARCHAR(10),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (userid) REFERENCES users(userid)
);


ALTER TABLE users
ADD COLUMN password VARCHAR(255) NOT NULL;

INSERT INTO users (fullName, email, phoneNumber, password)
VALUES
('Ayesha Khan', 'ayesha@gmail.com', '9876543210', '12345'),
('Rahul Sharma', 'rahul@gmail.com', '9876543211', '12345'),
('Neha Patel', 'neha@gmail.com', '9876543212', '12345'),
('Arjun Mehta', 'arjun@gmail.com', '9876543213', '12345'),
('Sana Shaikh', 'sana@gmail.com', '9876543214', '12345');

SELECT * FROM users;


INSERT INTO stores
(storeName, ownerName, phoneNumber, address, city, pincode)
VALUES
('Fresh Mart', 'Ramesh Kumar', '9988776655', 'Main Road', 'Mumbai', '400072'),
('Daily Needs', 'Suresh Patel', '9988776656', 'Market Road', 'Mumbai', '400070'),
('Quick Grocery', 'Amit Shah', '9988776657', 'Station Road', 'Mumbai', '400086'),
('Smart Store', 'Imran Khan', '9988776658', 'Link Road', 'Mumbai', '400064');

SELECT * FROM stores;

INSERT INTO products
(storeid, productName, category, price, stock, description)
VALUES
(1, 'Milk 1L', 'Dairy', 60.00, 50, 'Fresh milk'),
(1, 'Bread', 'Bakery', 40.00, 30, 'Fresh bread'),
(1, 'Eggs 12 Pack', 'Dairy', 90.00, 25, 'Farm fresh eggs'),
(2, 'Rice 5Kg', 'Grocery', 350.00, 20, 'Premium rice'),
(2, 'Wheat Flour 5Kg', 'Grocery', 280.00, 15, 'Fresh wheat flour'),
(3, 'Cooking Oil 1L', 'Grocery', 150.00, 25, 'Refined cooking oil'),
(3, 'Sugar 1Kg', 'Grocery', 50.00, 40, 'Fine sugar'),
(4, 'Biscuits', 'Snacks', 30.00, 60, 'Chocolate biscuits'),
(4, 'Cold Drink', 'Beverages', 45.00, 40, 'Refreshing drink'),
(4, 'Chips', 'Snacks', 20.00, 50, 'Crispy potato chips');

SELECT * FROM products;

INSERT INTO delivery_partners
(fullName, phoneNumber, vehicleNumber, status)
VALUES
('Vikas Yadav', '9876500011', 'MH01AB1234', 'Available'),
('Rohit Singh', '9876500012', 'MH02CD5678', 'Available'),
('Sameer Khan', '9876500013', 'MH03EF9012', 'Busy'),
('Akash Patil', '9876500014', 'MH04GH3456', 'Available');

SELECT * FROM delivery_partners;


INSERT INTO orders
(userid, storeid, totalAmount, orderStatus)
VALUES
(1, 1, 190.00, 'Delivered'),
(2, 2, 630.00, 'Pending'),
(3, 3, 200.00, 'Out for Delivery'),
(4, 4, 95.00, 'Delivered'),
(5, 1, 150.00, 'Preparing');

SELECT * FROM orders;

INSERT INTO order_items
(orderid, productid, quantity, price)
VALUES
(1, 1, 1, 60.00),
(1, 3, 1, 90.00),
(1, 2, 1, 40.00),

(2, 4, 1, 350.00),
(2, 5, 1, 280.00),

(3, 6, 1, 150.00),
(3, 7, 1, 50.00),

(4, 8, 1, 30.00),
(4, 9, 1, 45.00),
(4, 10, 1, 20.00),

(5, 1, 1, 60.00),
(5, 3, 1, 90.00);

SELECT * FROM order_items;

INSERT INTO payments
(orderid, paymentMethod, paymentStatus)
VALUES
(1, 'UPI', 'Paid'),
(2, 'Cash on Delivery', 'Pending'),
(3, 'Credit Card', 'Paid'),
(4, 'UPI', 'Paid'),
(5, 'Cash on Delivery', 'Pending');

SELECT * FROM payments;

INSERT INTO addresses
(userid, address, city, pincode)
VALUES
(1, 'Sakinaka Main Road', 'Mumbai', '400072'),
(2, 'Andheri East', 'Mumbai', '400069'),
(3, 'Kurla West', 'Mumbai', '400070'),
(4, 'Ghatkopar East', 'Mumbai', '400077'),
(5, 'Vikhroli West', 'Mumbai', '400079');

SELECT * FROM addresses;

SELECT * FROM users;
SELECT * FROM stores;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM delivery_partners;
SELECT * FROM payments;
SELECT * FROM addresses;

-- 1. Which products did each customer order?

SELECT 
    u.fullName AS Customer,
    s.storeName AS Store,
    p.productName AS Product,
    oi.quantity,
    oi.price,
    o.totalAmount,
    o.orderStatus
FROM users u
JOIN orders o ON u.userid = o.userid
JOIN stores s ON o.storeid = s.storeid
JOIN order_items oi ON o.orderid = oi.orderid
JOIN products p ON oi.productid = p.productid;

-- 2. Display all products available in each store.

SELECT 
    s.storeName AS Store,
    p.productName AS Product,
    p.category,
    p.price,
    p.stock
FROM stores s
JOIN products p ON s.storeid = p.storeid
ORDER BY s.storeName;

-- 3. Display complete details of all orders.

SELECT 
    o.orderid,
    u.fullName AS Customer,
    s.storeName AS Store,
    o.orderDate,
    o.totalAmount,
    o.orderStatus
FROM orders o
JOIN users u ON o.userid = u.userid
JOIN stores s ON o.storeid = s.storeid;

-- 4. Display all pending orders.

SELECT 
    o.orderid,
    u.fullName AS Customer,
    s.storeName AS Store,
    o.totalAmount,
    o.orderStatus
FROM orders o
JOIN users u ON o.userid = u.userid
JOIN stores s ON o.storeid = s.storeid
WHERE o.orderStatus = 'Pending';

-- 5. Calculate the total sales for each store.

SELECT 
    s.storeName AS Store,
    SUM(o.totalAmount) AS Total_Sales
FROM stores s
JOIN orders o ON s.storeid = o.storeid
GROUP BY s.storeid, s.storeName;

-- 6. Display orders in descending order of total amount.

SELECT 
    o.orderid,
    u.fullName AS Customer,
    o.totalAmount,
    o.orderStatus
FROM orders o
JOIN users u ON o.userid = u.userid
ORDER BY o.totalAmount DESC;

-- 7. Find the customer who spent the most money.

SELECT 
    u.fullName AS Customer,
    SUM(o.totalAmount) AS Total_Spent
FROM users u
JOIN orders o ON u.userid = o.userid
GROUP BY u.userid, u.fullName
ORDER BY Total_Spent DESC;

-- 8. Count the number of products in each category.

SELECT 
    category,
    COUNT(*) AS Total_Products
FROM products
GROUP BY category;

-- 9. Display all products that are currently in stock.

SELECT 
    productName,
    category,
    price,
    stock
FROM products
WHERE stock > 0
ORDER BY stock DESC;

-- 10. Display the top 5 most expensive products.

SELECT 
    productName,
    category,
    price
FROM products
ORDER BY price DESC
LIMIT 5;

-- 11. Display payment details along with order details.

SELECT 
    o.orderid,
    u.fullName AS Customer,
    o.totalAmount,
    p.paymentMethod,
    p.paymentStatus
FROM orders o
JOIN users u ON o.userid = u.userid
JOIN payments p ON o.orderid = p.orderid;

-- 12. Display all available delivery partners.

SELECT 
    fullName,
    phoneNumber,
    vehicleNumber,
    status
FROM delivery_partners
WHERE status = 'Available';

-- 13. Display the address of each customer.

SELECT 
    u.fullName AS Customer,
    a.address,
    a.city,
    a.pincode
FROM users u
JOIN addresses a ON u.userid = a.userid;

-- 14. Count the number of products in each order.

SELECT 
    o.orderid,
    COUNT(oi.productid) AS Total_Products
FROM orders o
JOIN order_items oi ON o.orderid = oi.orderid
GROUP BY o.orderid;

-- 15. Count the number of orders for each order status.

SELECT 
    orderStatus,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY orderStatus;

-- 16. Find customers who have placed more than one order.

SELECT 
    u.fullName AS Customer,
    COUNT(o.orderid) AS Total_Orders
FROM users u
JOIN orders o ON u.userid = o.userid
GROUP BY u.userid, u.fullName
HAVING COUNT(o.orderid) > 1;

-- 17. Find the total number of orders handled by each store.

SELECT 
    s.storeName AS Store,
    COUNT(o.orderid) AS Total_Orders
FROM stores s
JOIN orders o ON s.storeid = o.storeid
GROUP BY s.storeid, s.storeName;

-- 18. Find the average order amount for each store.

SELECT 
    s.storeName AS Store,
    AVG(o.totalAmount) AS Average_Order_Amount
FROM stores s
JOIN orders o ON s.storeid = o.storeid
GROUP BY s.storeid, s.storeName;

-- 19. Find products that have never been ordered.

SELECT 
    p.productName AS Product,
    p.category,
    p.price
FROM products p
LEFT JOIN order_items oi 
ON p.productid = oi.productid
WHERE oi.productid IS NULL;

-- 20. Find the customer with the highest single order amount.

SELECT 
    u.fullName AS Customer,
    o.orderid,
    o.totalAmount
FROM users u
JOIN orders o ON u.userid = o.userid
ORDER BY o.totalAmount DESC
LIMIT 1;

-- 21. Find the store with the highest total sales.

SELECT 
    s.storeName AS Store,
    SUM(o.totalAmount) AS Total_Sales
FROM stores s
JOIN orders o ON s.storeid = o.storeid
GROUP BY s.storeid, s.storeName
ORDER BY Total_Sales DESC
LIMIT 1;

-- 22. Find the most ordered product.

SELECT 
    p.productName AS Product,
    SUM(oi.quantity) AS Total_Quantity
FROM products p
JOIN order_items oi 
ON p.productid = oi.productid
GROUP BY p.productid, p.productName
ORDER BY Total_Quantity DESC
LIMIT 1;

-- 23. Find the total revenue generated from each product category.

SELECT 
    p.category AS Category,
    SUM(oi.quantity * oi.price) AS Total_Revenue
FROM products p
JOIN order_items oi 
ON p.productid = oi.productid
GROUP BY p.category;

-- 24. Find all customers who have made a successful payment.

SELECT DISTINCT
    u.fullName AS Customer,
    u.email,
    p.paymentMethod,
    p.paymentStatus
FROM users u
JOIN orders o ON u.userid = o.userid
JOIN payments p ON o.orderid = p.orderid
WHERE p.paymentStatus = 'Paid';

-- 25. Find delivery partners who are currently available.

SELECT 
    deliveryPartnerId,
    fullName,
    phoneNumber,
    vehicleNumber
FROM delivery_partners
WHERE status = 'Available';

-- 26. Find customers whose total spending is greater than the average customer spending.

SELECT
    u.fullName AS Customer,
    SUM(o.totalAmount) AS Total_Spent
FROM users u
JOIN orders o ON u.userid = o.userid
GROUP BY u.userid, u.fullName
HAVING SUM(o.totalAmount) > (
    SELECT AVG(totalAmount)
    FROM orders
);

-- 27. Find products whose price is higher than the average product price.

SELECT
    productName AS Product,
    category,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- 28. Find the most expensive product in each category.

SELECT
    p.productName AS Product,
    p.category,
    p.price
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category = p.category
);

-- 29. Find stores that have more than 2 products.

SELECT
    s.storeName AS Store,
    COUNT(p.productid) AS Total_Products
FROM stores s
JOIN products p ON s.storeid = p.storeid
GROUP BY s.storeid, s.storeName
HAVING COUNT(p.productid) > 2;

-- 30. Display the order status with a meaningful description.

SELECT
    orderid,
    totalAmount,
    orderStatus,
    CASE
        WHEN orderStatus = 'Delivered' THEN 'Order completed'
        WHEN orderStatus = 'Pending' THEN 'Waiting for confirmation'
        WHEN orderStatus = 'Preparing' THEN 'Store is preparing the order'
        WHEN orderStatus = 'Out for Delivery' THEN 'Order is on the way'
        ELSE 'Unknown status'
    END AS Status_Description
FROM orders;

-- 31. Classify products based on their price.

SELECT
    productName AS Product,
    price,
    CASE
        WHEN price < 50 THEN 'Low Price'
        WHEN price BETWEEN 50 AND 200 THEN 'Medium Price'
        ELSE 'High Price'
    END AS Price_Category
FROM products;

-- 32. Find stores whose total sales are greater than 300.

SELECT
    s.storeName AS Store,
    SUM(o.totalAmount) AS Total_Sales
FROM stores s
JOIN orders o ON s.storeid = o.storeid
GROUP BY s.storeid, s.storeName
HAVING SUM(o.totalAmount) > 300;

-- 33. Find the average price of products in each category.

SELECT
    category,
    AVG(price) AS Average_Price
FROM products
GROUP BY category;

-- 34. Find customers who have not placed any orders.

SELECT
    u.userid,
    u.fullName AS Customer,
    u.email
FROM users u
LEFT JOIN orders o ON u.userid = o.userid
WHERE o.orderid IS NULL;

-- 35. Find the total quantity of products sold by each store.

SELECT
    s.storeName AS Store,
    SUM(oi.quantity) AS Total_Quantity_Sold
FROM stores s
JOIN orders o ON s.storeid = o.storeid
JOIN order_items oi ON o.orderid = oi.orderid
GROUP BY s.storeid, s.storeName;

-- 36. Create a view for complete order details

CREATE VIEW order_details_view AS
SELECT
    o.orderid,
    u.fullName AS Customer,
    s.storeName AS Store,
    o.orderDate,
    o.totalAmount,
    o.orderStatus
FROM orders o
JOIN users u ON o.userid = u.userid
JOIN stores s ON o.storeid = s.storeid;

SELECT * FROM order_details_view;

-- 37. Create a view for store-wise sales

CREATE VIEW store_sales_view AS
SELECT
    s.storeName AS Store,
    COUNT(o.orderid) AS Total_Orders,
    SUM(o.totalAmount) AS Total_Sales
FROM stores s
JOIN orders o ON s.storeid = o.storeid
GROUP BY s.storeid, s.storeName;

SELECT * FROM store_sales_view;

-- 38. Create a view for available products

CREATE VIEW available_products_view AS
SELECT
    p.productid,
    s.storeName AS Store,
    p.productName AS Product,
    p.category,
    p.price,
    p.stock
FROM products p
JOIN stores s ON p.storeid = s.storeid
WHERE p.stock > 0;

SELECT * FROM available_products_view;

-- 39. Create a view for customer payment details

CREATE VIEW customer_payment_view AS
SELECT
    u.fullName AS Customer,
    o.orderid,
    o.totalAmount,
    p.paymentMethod,
    p.paymentStatus
FROM users u
JOIN orders o ON u.userid = o.userid
JOIN payments p ON o.orderid = p.orderid;

SELECT * FROM customer_payment_view;

-- 40. Create a view for delivery partner availability

CREATE VIEW delivery_partner_view AS
SELECT
    deliveryPartnerId,
    fullName,
    phoneNumber,
    vehicleNumber,
    status
FROM delivery_partners;

SELECT * FROM delivery_partner_view;

-- 41. Get all products of a specific store

DELIMITER //

CREATE PROCEDURE GetStoreProducts(IN store_id INT)
BEGIN
    SELECT
        p.productid,
        p.productName,
        p.category,
        p.price,
        p.stock
    FROM products p
    WHERE p.storeid = store_id;
END //

DELIMITER ;

CALL GetStoreProducts(1);

-- 42. Get all orders of a specific customer

DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN customer_id INT)
BEGIN
    SELECT
        o.orderid,
        o.orderDate,
        o.totalAmount,
        o.orderStatus
    FROM orders o
    WHERE o.userid = customer_id;
END //

DELIMITER ;

CALL GetCustomerOrders(1);

-- 43. Get orders by status

DELIMITER //

CREATE PROCEDURE GetOrdersByStatus(IN status_name VARCHAR(50))
BEGIN
    SELECT
        o.orderid,
        u.fullName AS Customer,
        s.storeName AS Store,
        o.totalAmount,
        o.orderStatus
    FROM orders o
    JOIN users u ON o.userid = u.userid
    JOIN stores s ON o.storeid = s.storeid
    WHERE o.orderStatus = status_name;
END //

DELIMITER ;

CALL GetOrdersByStatus('Pending');

-- 44. Get total sales of a store

DELIMITER //

CREATE PROCEDURE GetStoreSales(IN store_id INT)
BEGIN
    SELECT
        s.storeName AS Store,
        COUNT(o.orderid) AS Total_Orders,
        SUM(o.totalAmount) AS Total_Sales
    FROM stores s
    JOIN orders o ON s.storeid = o.storeid
    WHERE s.storeid = store_id
    GROUP BY s.storeid, s.storeName;
END //

DELIMITER ;

CALL GetStoreSales(1);

-- 45. Get customer payment details

DELIMITER //

CREATE PROCEDURE GetCustomerPayments(IN customer_id INT)
BEGIN
    SELECT
        u.fullName AS Customer,
        o.orderid,
        o.totalAmount,
        p.paymentMethod,
        p.paymentStatus
    FROM users u
    JOIN orders o ON u.userid = o.userid
    JOIN payments p ON o.orderid = p.orderid
    WHERE u.userid = customer_id;
END //

DELIMITER ;

CALL GetCustomerPayments(1);

-- 46. Automatically reduce stock when a product is ordered

DELIMITER //

CREATE TRIGGER reduce_product_stock
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE productid = NEW.productid;
END //

DELIMITER ;

-- 47. Prevent negative product stock

DELIMITER //

CREATE TRIGGER prevent_negative_stock
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SET NEW.stock = 0;
    END IF;
END //

DELIMITER ;

-- 48. Automatically mark payment as Paid when an order is delivered

DELIMITER //

CREATE TRIGGER update_payment_on_delivery
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.orderStatus = 'Delivered' THEN
        UPDATE payments
        SET paymentStatus = 'Paid'
        WHERE orderid = NEW.orderid;
    END IF;
END //

DELIMITER ;

-- 49. Automatically update delivery partner status when assigned

ALTER TABLE orders
ADD COLUMN deliveryPartnerId INT NULL;

ALTER TABLE orders
ADD CONSTRAINT fk_delivery_partner
FOREIGN KEY (deliveryPartnerId)
REFERENCES delivery_partners(deliveryPartnerId);

DELIMITER //

CREATE TRIGGER assign_delivery_partner
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.deliveryPartnerId IS NOT NULL THEN
        UPDATE delivery_partners
        SET status = 'Busy'
        WHERE deliveryPartnerId = NEW.deliveryPartnerId;
    END IF;
END //

DELIMITER ;


-- 50. Automatically make delivery partner available after delivery

DELIMITER //

CREATE TRIGGER complete_delivery_partner
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.orderStatus = 'Delivered'
       AND NEW.deliveryPartnerId IS NOT NULL THEN

        UPDATE delivery_partners
        SET status = 'Available'
        WHERE deliveryPartnerId = NEW.deliveryPartnerId;

    END IF;
END //

DELIMITER ;


USE zeptoddb;

DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN p_userId INT)
BEGIN
    SELECT
        o.orderId,
        o.userId,
        o.storeId,
        o.orderDate,
        o.totalAmount,
        o.orderStatus,
        o.deliveryPartnerId
    FROM orders o
    WHERE o.userId = p_userId;
END //

DELIMITER ;

CALL GetCustomerOrders(1);


USE zeptoddb;

DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN p_userId INT)
BEGIN
    SELECT
        o.orderId,
        o.userId,
        o.storeId,
        o.orderDate,
        o.totalAmount,
        o.orderStatus,
        o.deliveryPartnerId
    FROM orders o
    WHERE o.userId = p_userId;
END //

DELIMITER ;

CALL GetCustomerOrders(1);

USE zeptoddb;

DELIMITER //

CREATE PROCEDURE GetStoreOrders(IN p_storeId INT)
BEGIN
    SELECT
        o.orderId,
        o.userId,
        o.storeId,
        o.orderDate,
        o.totalAmount,
        o.orderStatus,
        o.deliveryPartnerId
    FROM orders o
    WHERE o.storeId = p_storeId;
END //

DELIMITER ;

CALL GetStoreOrders(1);

USE zeptoddb;

DELIMITER //

CREATE PROCEDURE GetDeliveryPartnerOrders(IN p_deliveryPartnerId INT)
BEGIN
    SELECT
        o.orderId,
        o.userId,
        o.storeId,
        o.orderDate,
        o.totalAmount,
        o.orderStatus,
        o.deliveryPartnerId
    FROM orders o
    WHERE o.deliveryPartnerId = p_deliveryPartnerId;
END //

DELIMITER ;

CALL GetDeliveryPartnerOrders(1);

SELECT orderId, userId, storeId, orderDate, totalAmount, orderStatus, deliveryPartnerId
FROM orders;


SELECT * FROM deliverypartners;

SHOW TABLES;

SELECT * FROM delivery_partners;


UPDATE orders
SET deliveryPartnerId = 1
WHERE orderId = 1;

UPDATE orders
SET deliveryPartnerId = 2
WHERE orderId = 2;

UPDATE orders
SET deliveryPartnerId = 3
WHERE orderId = 3;

UPDATE orders
SET deliveryPartnerId = 4
WHERE orderId = 4;

UPDATE orders
SET deliveryPartnerId = 1
WHERE orderId = 5;

SELECT orderId, userId, totalAmount, orderStatus, deliveryPartnerId
FROM orders;

UPDATE orders SET deliveryPartnerId = 1 WHERE orderId = 1;
UPDATE orders SET deliveryPartnerId = 2 WHERE orderId = 2;
UPDATE orders SET deliveryPartnerId = 3 WHERE orderId = 3;
UPDATE orders SET deliveryPartnerId = 4 WHERE orderId = 4;

SELECT orderId, userId, totalAmount, orderStatus, deliveryPartnerId
FROM orders;

UPDATE orders
SET deliveryPartnerId = 1
WHERE orderId = 1;

UPDATE orders
SET deliveryPartnerId = 2
WHERE orderId = 2;

UPDATE orders
SET deliveryPartnerId = 3
WHERE orderId = 3;

SELECT orderId, userId, totalAmount, orderStatus, deliveryPartnerId
FROM orders;

CALL GetDeliveryPartnerOrders(1);

USE zeptodb;

DELIMITER //

CREATE PROCEDURE GetOrdersByStatus(IN p_orderStatus VARCHAR(50))
BEGIN
    SELECT
        o.orderId,
        o.userId,
        o.storeId,
        o.orderDate,
        o.totalAmount,
        o.orderStatus,
        o.deliveryPartnerId
    FROM orders o
    WHERE o.orderStatus = p_orderStatus;
END //

DELIMITER ;

CALL GetOrdersByStatus('Delivered');

USE zeptodb;

DELIMITER //

CREATE PROCEDURE GetUserOrderSummary(IN p_userId INT)
BEGIN
    SELECT
        o.userId,
        COUNT(o.orderId) AS totalOrders,
        SUM(o.totalAmount) AS totalSpent
    FROM orders o
    WHERE o.userId = p_userId
    GROUP BY o.userId;
END //

DELIMITER ;

CALL GetUserOrderSummary(1);

USE zeptodb;

DELIMITER //

CREATE FUNCTION GetOrderTotal(p_orderId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT totalAmount
    INTO v_total
    FROM orders
    WHERE orderId = p_orderId;

    RETURN v_total;
END //

DELIMITER ;

SELECT GetOrderTotal(1);

USE zeptodb;

DELIMITER //

CREATE FUNCTION GetUserOrderCount(p_userId INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM orders
    WHERE userId = p_userId;

    RETURN v_count;
END //

DELIMITER ;

SELECT GetUserOrderCount(1);

USE zeptodb;

DELIMITER //

CREATE FUNCTION GetUserTotalSpent(p_userId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(totalAmount), 0)
    INTO v_total
    FROM orders
    WHERE userId = p_userId;

    RETURN v_total;
END //

DELIMITER ;

SELECT GetUserTotalSpent(1);

USE zeptodb;

DELIMITER //

CREATE FUNCTION GetOrderStatus(p_orderId INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_status VARCHAR(50);

    SELECT orderStatus
    INTO v_status
    FROM orders
    WHERE orderId = p_orderId;

    RETURN v_status;
END //

DELIMITER ;

SELECT GetOrderStatus(1);

USE zeptodb;

DELIMITER //

CREATE FUNCTION GetStoreTotalSales(p_storeId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(totalAmount), 0)
    INTO v_total
    FROM orders
    WHERE storeId = p_storeId;

    RETURN v_total;
END //

DELIMITER ;

SELECT GetStoreTotalSales(1);

DESCRIBE orders;


USE zeptodb;

DELIMITER //

CREATE TRIGGER BeforeOrderInsert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.orderStatus IS NULL OR NEW.orderStatus = '' THEN
        SET NEW.orderStatus = 'Pending';
    END IF;
END //

DELIMITER ;

USE zeptodb;

DELIMITER //

CREATE TRIGGER BeforeOrderUpdate
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.orderStatus IS NULL OR NEW.orderStatus = '' THEN
        SET NEW.orderStatus = 'Pending';
    END IF;
END //

DELIMITER ;

USE zeptodb;

DELIMITER //

CREATE TRIGGER BeforeOrderDelete
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    IF OLD.orderStatus = 'Delivered' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Delivered orders cannot be deleted';
    END IF;
END //

DELIMITER ;

DESCRIBE delivery_partners;

DROP TRIGGER IF EXISTS BeforeOrderInsert;

DELIMITER //

CREATE TRIGGER BeforeOrderInsert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.orderStatus IS NULL OR NEW.orderStatus = '' THEN
        SET NEW.orderStatus = 'Pending';
    END IF;

    IF NEW.deliveryPartnerId IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM delivery_partners
            WHERE deliveryPartnerId = NEW.deliveryPartnerId
        ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid delivery partner ID';
        END IF;
    END IF;
END //

DELIMITER ;

USE zeptodb;

DELIMITER //

CREATE TRIGGER BeforeOrderUpdatePartnerCheck
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.deliveryPartnerId IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM delivery_partners
            WHERE deliveryPartnerId = NEW.deliveryPartnerId
        ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid delivery partner ID';
        END IF;
    END IF;
END //

DELIMITER ;

SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

SELECT * FROM available_products_view;
SELECT * FROM customer_payment_view;
SELECT * FROM delivery_partner_view;
SELECT * FROM order_details_view;
SELECT * FROM store_sales_view;

SHOW PROCEDURE STATUS
WHERE Db = 'zeptodb';

SHOW FUNCTION STATUS
WHERE Db = 'zeptodb';
SHOW TRIGGERS FROM zeptodb;