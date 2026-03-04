-- 16 Customer 360 view

SELECT
c.customer_id,
c.customer_city,
COUNT(DISTINCT o.order_id) total_orders,
SUM(op.payment_value) total_spent,
AVG(r.review_score) avg_review
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_payments op ON o.order_id = op.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
GROUP BY c.customer_id, c.customer_city;



-- 17 Customers who bought electronics but never music
SELECT DISTINCT o.customer_id
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_category_name ilike '%eletronicos%'
AND o.customer_id NOT IN (

SELECT o.customer_id
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_category_name ilike '%musica%'

);



-- 18 Sellers best selling product per category

SELECT *
FROM (
SELECT
s.seller_id,
p.product_category_name,
oi.product_id,
SUM(oi.price) revenue,
RANK() OVER(
PARTITION BY s.seller_id, p.product_category_name
ORDER BY SUM(oi.price) DESC
) rnk
FROM order_items oi
JOIN sellers s ON oi.seller_id = s.seller_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY s.seller_id,p.product_category_name,oi.product_id
) t
WHERE rnk = 1;



-- 19 Products frequently bought together

SELECT
a.product_id product1,
b.product_id product2,
COUNT(*) frequency
FROM order_items a
JOIN order_items b
ON a.order_id = b.order_id
AND a.product_id < b.product_id
GROUP BY a.product_id, b.product_id
ORDER BY frequency DESC;



-- 20 Shipping delay orders

SELECT
o.order_id,
c.customer_city,
s.seller_city,
o.order_estimated_delivery_date,
o.order_delivered_customer_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN sellers s ON oi.seller_id = s.seller_id
WHERE o.order_delivered_customer_date > o.order_estimated_delivery_date;