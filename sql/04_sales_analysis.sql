-- Query 1: Monthly revenue (Question 1)
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp)::date AS month,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.price), 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;


-- Query 2: Top 10 categories (Question 2)
SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name, 'unknown') AS category,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY revenue DESC
LIMIT 10;


-- Query 3: Top 10 sellers (Question 7)
SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY revenue DESC
LIMIT 10;


-- Query 4: Payment methods (Question 8)
SELECT
    p.payment_type,
    COUNT(DISTINCT p.order_id) AS orders,
    ROUND(SUM(p.payment_value), 2) AS total_paid
FROM order_payments p
JOIN orders o ON p.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.payment_type
ORDER BY orders DESC;
