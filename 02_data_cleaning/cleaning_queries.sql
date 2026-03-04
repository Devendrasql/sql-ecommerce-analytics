-- 1 Missing product categories
SELECT COUNT(*)
FROM products
WHERE product_category_name IS NULL;

-- 2 Orders without delivery date
SELECT COUNT(*)
FROM orders
WHERE order_delivered_customer_date IS NULL;

-- 3 Duplicate geolocation rows
SELECT geolocation_zip_code_prefix, COUNT(*)
FROM geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1;

--4 Duplicate review IDs
SELECT review_id, COUNT(*)
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

--5 Orders with multiple payments
SELECT order_id, COUNT(*)
FROM order_payments
GROUP BY order_id
HAVING COUNT(*) > 1;

--6 Customers without orders
SELECT COUNT(*)
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--7 Orders without reviews
SELECT COUNT(*)
FROM orders o
LEFT JOIN order_reviews r
ON o.order_id = r.order_id
WHERE r.review_id IS NULL;

--8 Products never sold
SELECT COUNT(*)
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 9 Sellers without orders
SELECT COUNT(*)
FROM sellers s
LEFT JOIN order_items oi
ON s.seller_id = oi.seller_id
WHERE oi.seller_id IS NULL;

--10 Payment mismatch possibility
SELECT order_id
FROM order_payments
GROUP BY order_id
HAVING SUM(payment_value) <= 0;





































SELECT * FROM orders WHERE order_purchase_timestamp IS NULL;

SELECT order_purchase_timestamp FROM orders WHERE order_purchase_timestamp::text = '';

SELECT review_id, COUNT(*) FROM order_reviews GROUP BY review_id HAVING COUNT(*) > 1;

SELECT COUNT(*)
FROM (SELECT review_id FROM order_reviews GROUP BY review_id HAVING COUNT(*) > 1) duplicates;

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM sellers;
SELECT COUNT(*) FROM order_payments;
SELECT COUNT(*) FROM order_reviews;
SELECT COUNT(*) FROM geolocation;

SELECT * FROM products WHERE product_category_name IS NULL;

SELECT COUNT(*) FROM products WHERE product_category_name IS NULL;

SELECT COUNT(*) FROM orders WHERE order_delivered_customer_date IS NULL;

SELECT geolocation_zip_code_prefix, COUNT(*) FROM geolocation
GROUP BY geolocation_zip_code_prefix HAVING COUNT(*) > 1;

SELECT COUNT(*)
FROM products
WHERE product_category_name IS NULL;