-- 25 7 day moving average orders

SELECT
DATE(order_purchase_timestamp) order_date,
COUNT(order_id) orders,
AVG(COUNT(order_id)) OVER(
ORDER BY DATE(order_purchase_timestamp)
ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
) moving_avg
FROM orders
GROUP BY order_date;



-- 26 Gap between orders

SELECT
customer_id,
order_id,
order_purchase_timestamp,
LAG(order_purchase_timestamp)
OVER (PARTITION BY customer_id ORDER BY order_purchase_timestamp) prev_order,
order_purchase_timestamp -
LAG(order_purchase_timestamp)
OVER (PARTITION BY customer_id ORDER BY order_purchase_timestamp) gap
FROM orders;



-- 27 Top 3 sellers per state

SELECT *
FROM (

SELECT
s.seller_state,
s.seller_id,
SUM(oi.price) revenue,
RANK() OVER(
PARTITION BY s.seller_state
ORDER BY SUM(oi.price) DESC
) rank
FROM sellers s
JOIN order_items oi
ON s.seller_id = oi.seller_id
GROUP BY s.seller_state, s.seller_id

) t
WHERE rank <= 3;



-- 28 Running revenue total

SELECT
DATE(o.order_purchase_timestamp) date,
SUM(op.payment_value) revenue,
SUM(SUM(op.payment_value)) OVER(
ORDER BY DATE(o.order_purchase_timestamp)
) running_total
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY date;