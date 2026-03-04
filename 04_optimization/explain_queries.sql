EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = '123';


EXPLAIN ANALYZE
SELECT *
FROM order_items
WHERE product_id = 'abc';


EXPLAIN ANALYZE
SELECT *
FROM order_payments
WHERE order_id = 'xyz';