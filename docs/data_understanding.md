# Data Understanding

## Project Description
This project analyzes about 100,000 orders from Olist, a Brazilian
e-commerce marketplace (2016-2018). I use PostgreSQL to clean and
analyze the data and Power BI to build a dashboard.

## Tables
| Table | One row represents | Rows |
|---|---|---|
| customers | one customer record per order | 99,441 |
| orders | one order | 99,441 |
| order_items | one item line inside an order | 112,650 |
| order_payments | one payment for an order | 103,886 |
| order_reviews | one review of an order | 99,224 |
| products | one product | 32,951 |
| sellers | one seller | 3,095 |
| geolocation | one zip-code coordinate record | 1,000,163 |
| category_translation | one category name translation | 71 |

## Relationships
customers --(customer_id)--> orders
orders --(order_id)--> order_items, order_payments, order_reviews
order_items --(product_id)--> products
order_items --(seller_id)--> sellers

## Key Learnings
1. customer_unique_id identifies a real person; customer_id is
   generated per order.
2. order_item_id is a line number inside an order, not an item ID.
3. payment_sequential is a payment counter inside one order.
4. Joining items and payments directly multiplies rows (fan-out)
   and inflates revenue, so I aggregate before joining.

## Business Questions
1. How does monthly revenue change over time?
2. Which product categories earn the most revenue?
3. Which states have the most customers?
4. What percentage of orders are delivered late?
5. Do late deliveries get lower review scores?
6. What share of customers buy more than once?
7. Which sellers bring in the most revenue?
8. Which payment methods do customers use most?