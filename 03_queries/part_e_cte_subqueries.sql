-- 21 Customers spending more than state average

SELECT *
FROM (
SELECT
o.customer_id,
c.customer_state,
SUM(op.payment_value) total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY o.customer_id, c.customer_state
) t
WHERE total_spent >
(
SELECT AVG(total_spent)
FROM (
SELECT
o.customer_id,
SUM(op.payment_value) total_spent
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY o.customer_id
) avg_table
);



-- 22 Second highest revenue product per category

SELECT *
FROM (
SELECT
p.product_category_name,
oi.product_id,
SUM(oi.price) revenue,
DENSE_RANK() OVER(
PARTITION BY p.product_category_name
ORDER BY SUM(oi.price) DESC
) rank
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name,oi.product_id
) t
WHERE rank = 2;



-- 23 Recursive CTE example

WITH RECURSIVE numbers AS (
SELECT 1 n
UNION ALL
SELECT n+1
FROM numbers
WHERE n < 10
)
SELECT * FROM numbers;



-- 24 Customers purchasing 3 consecutive months

WITH monthly_orders AS (

SELECT
customer_id,
DATE_TRUNC('month',order_purchase_timestamp)month
FROM orders

),

ranked AS (

SELECT
customer_id,
month,
ROW_NUMBER() OVER(
PARTITION BY customer_id
ORDER BY month
) rn
FROM monthly_orders

)

SELECT customer_id
FROM ranked
GROUP BY customer_id
HAVING COUNT(*) >= 3;