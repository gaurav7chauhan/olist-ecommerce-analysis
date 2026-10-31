-- Check 1: Duplicates
-- Are order_ids unique in orders?
SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Are customer_ids unique in customers?
SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Are product_ids unique in products?
SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Does any order have more than one review?
SELECT order_id, COUNT(*)
FROM order_reviews
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Check 2: Order status
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Check 3: Missing values (NULLs)
SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS no_approval_date,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS no_carrier_date,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS no_delivery_date
FROM orders;


-- Check 4: Dates that don’t make sense
-- Delivered orders with no delivery date
SELECT COUNT(*)
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NULL;

-- Delivered to the customer before the purchase date
SELECT COUNT(*)
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;


-- Check 5: Products with no category
-- Products with a missing category
SELECT COUNT(*)
FROM products
WHERE product_category_name IS NULL;

-- Categories with no English translation
SELECT DISTINCT p.product_category_name
FROM products p
LEFT JOIN category_translation t
  ON p.product_category_name = t.product_category_name
WHERE t.product_category_name IS NULL
  AND p.product_category_name IS NOT NULL;
