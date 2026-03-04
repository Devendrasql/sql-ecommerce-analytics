DELETE FROM customers
WHERE customer_id IN (
SELECT customer_id
FROM (
SELECT customer_id,
ROW_NUMBER() OVER(
PARTITION BY customer_unique_id
ORDER BY customer_id
) AS rn
FROM customers
) t
WHERE rn > 1
);