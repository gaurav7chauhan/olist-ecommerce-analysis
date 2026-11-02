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


-- Query 5: How much revenue comes from the top 10 sellers?
WITH seller_sales AS (
	SELECT
		oi.seller_id,
		COUNT(oi.order_item_id) AS total_items_sold,
		COUNT(DISTINCT oi.order_id) AS total_orders,
		ROUND(SUM(oi.price), 2) AS total_revenue
	FROM order_items oi
	JOIN orders o ON o.order_id = oi.order_id
	WHERE o.order_status = 'delivered'
	GROUP BY oi.seller_id
),
ranked AS (
	SELECT *,
			RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
	FROM seller_sales
)
SELECT *
FROM ranked
WHERE revenue_rank <= 10
ORDER BY revenue_rank;


-- Query 6: Month-over-month growth (shows whether Nov 2017 was really a spike)
WITH monthly AS (
		SELECT DATE_TRUNC('month', o.order_purchase_timestamp)::date AS month,
				SUM(oi.price) AS revenue
		FROM orders o
		JOIN order_items oi ON oi.order_id = o.order_id
		WHERE o.order_status = 'delivered'
		GROUP BY 1
)
SELECT month,
		ROUND(revenue, 2) AS revenue,
		ROUND(100.0 * (revenue - LAG(revenue) OVER(ORDER BY month))
					/ LAG(revenue) OVER (ORDER BY month), 1) AS growth_pct
FROM monthly
ORDER BY month;


-- Query 7: Revenue per item by category (volume vs price)
SELECT
    COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(AVG(oi.price), 2) AS avg_price
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY revenue DESC
LIMIT 10;
