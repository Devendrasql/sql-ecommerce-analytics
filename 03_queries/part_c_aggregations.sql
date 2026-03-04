-- 11 Monthly revenue + MoM growth

WITH monthly_revenue AS (
SELECT
DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
SUM(op.payment_value) AS revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY 1
)

SELECT
month,
revenue,
LAG(revenue) OVER (ORDER BY month) AS previous_month,
ROUND(
(revenue - LAG(revenue) OVER (ORDER BY month))
* 100.0 /
LAG(revenue) OVER (ORDER BY month),2
) AS mom_growth_percent
FROM monthly_revenue;



-- 12 Top 10 products per category

SELECT *
FROM (
SELECT
p.product_category_name,
oi.product_id,
SUM(oi.price) revenue,
RANK() OVER(
PARTITION BY p.product_category_name
ORDER BY SUM(oi.price) DESC
) rank
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name, oi.product_id
) t
WHERE rank <= 10;



-- 13 Customer Lifetime Value

SELECT
o.customer_id,
SUM(op.payment_value) AS clv,
CASE
WHEN SUM(op.payment_value) < 100 THEN 'Bronze'
WHEN SUM(op.payment_value) < 500 THEN 'Silver'
ELSE 'Gold'
END AS segment
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY o.customer_id;



-- 14 Sales report using ROLLUP

SELECT
DATE(o.order_purchase_timestamp) AS order_date,
SUM(op.payment_value) AS revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY ROLLUP(order_date);



-- 15 Seasonal category sales

SELECT
EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
p.product_category_name,
SUM(oi.price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month, p.product_category_name
ORDER BY month, revenue DESC;