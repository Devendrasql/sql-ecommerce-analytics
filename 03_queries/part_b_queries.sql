-- 7 Customers with same email but different names
-- (dataset has no email column, using customer_unique_id)

SELECT customer_unique_id, COUNT(*)
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1;

-- 8 Orphan order_items referencing non existing products

SELECT oi.*
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


-- Orphan order_items referencing non existing orders

SELECT oi.*
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- 9 Customers who registered but never ordered

SELECT c.customer_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- 10 Fraud detection
-- Payment value != total order items

SELECT
o.order_id,
SUM(oi.price + oi.freight_value) AS calculated_total,
SUM(op.payment_value) AS payment_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY o.order_id
HAVING SUM(oi.price + oi.freight_value) <> SUM(op.payment_value);