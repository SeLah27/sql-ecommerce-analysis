-- =====================================
-- E-commerce Sales Analysis
-- =====================================

-- 1. Total Revenue
SELECT SUM(price) AS total_revenue
FROM order_items;

-- 2. Top 5 Products by Revenue
SELECT product_id, SUM(price) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC
Limit 5;
-- 3. Revenue by State
SELECT c.customer_state, SUM(oi.price) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- 4. Monthly Revenue Trend
SELECT 
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS month,
    SUM(oi.price) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY month;

-- 5. Top Customers
SELECT c.customer_id, SUM(oi.price) AS total_spent
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

--Customer Lifetime Value (CLV)
SELECT 
    c.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

--Average Order Value (AOV)
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(oi.price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
) sub;
