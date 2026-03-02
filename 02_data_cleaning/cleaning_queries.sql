
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
