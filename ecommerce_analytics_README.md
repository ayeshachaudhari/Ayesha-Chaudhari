# E-commerce Analytics SQL Project

## Project Overview

This project is an **E-commerce Analytics Database** created using MySQL. It contains customer, category, product, order, order-item, and payment data and includes SQL queries for exploratory data analysis (EDA), sales analysis, customer analysis, product/category performance, and RFM customer segmentation.

## Database

```sql
CREATE DATABASE ecommerce_analytics;
USE ecommerce_analytics;
```

## Database Tables

### 1. customers
Stores customer information such as customer ID, name, email, gender, city, state, and signup date.

### 2. categories
Stores product category information.

### 3. products
Stores product details including product name, category, and price.

### 4. orders
Stores customer orders, order dates, and order status.

### 5. order_items
Stores products included in each order, quantity, and unit price.

### 6. payments
Stores payment method, payment status, payment amount, and payment date.

## Relationships

- `products.category_id` → `categories.category_id`
- `orders.customer_id` → `customers.customer_id`
- `order_items.order_id` → `orders.order_id`
- `order_items.product_id` → `products.product_id`
- `payments.order_id` → `orders.order_id`

## Sample Data

The database contains:

- **10 product categories**
- **20 products**
- **100 customers**
- **500 orders**
- **1000 order items**

The orders are generated across 2023–2024 with statuses such as:

- Completed
- Cancelled
- Returned

## Analysis Covered

### Customer Analysis
- Total customers
- Gender-wise customer count and percentage
- City-wise customer analysis
- State-wise customer analysis
- Customer registration trends
- Customer order count
- Top customers by number of orders
- Average customer spending
- Repeat customers
- One-time vs repeat customers
- City-wise revenue
- Gender-wise revenue

### Order Analysis
- Total orders
- Order status distribution
- Monthly order trends
- Orders by customer
- Top 10 customers by orders

### Sales & Revenue Analysis
- Total revenue
- Total units sold
- Average Order Value (AOV)
- Monthly revenue
- Product revenue
- Product quantity sold
- Product performance
- Highest-priced products

### Category Analysis
- Category-wise revenue
- Category revenue contribution percentage
- Category-wise average selling price
- Minimum and maximum selling price by category
- Products per category

### Product Analysis
- Top 10 products by revenue
- Top 10 products by quantity sold
- Product revenue and units sold
- Average selling price

## RFM Customer Segmentation

The project also performs **RFM Analysis**:

- **R — Recency:** How recently the customer placed an order.
- **F — Frequency:** How many orders the customer placed.
- **M — Monetary:** How much the customer spent.

Customers are assigned RFM scores using `NTILE(5)` and categorized into:

- VIP Customer
- Loyal Customer
- New Customer
- At Risk Customer
- Regular Customer

## SQL Concepts Used

This project demonstrates:

- Database and table creation
- Primary keys
- Foreign keys
- INSERT statements
- SELECT queries
- Aggregate functions
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `ROUND()`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- `JOIN`
- `LEFT JOIN`
- Subqueries
- Common Table Expressions (CTEs)
- Recursive CTEs
- Date functions
- `YEAR()`
- `MONTH()`
- `MONTHNAME()`
- `DATEDIFF()`
- `DATE_ADD()`
- Window functions
- `NTILE()`
- `CASE` statements

## Project Purpose

The main purpose of this project is to analyze e-commerce data and generate business insights related to:

- Customer behavior
- Sales performance
- Revenue trends
- Product performance
- Category performance
- Customer loyalty
- Customer segmentation

## Source SQL

The complete SQL script used to create the database, insert data, and perform all analysis is included in the original project SQL file.
