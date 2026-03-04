### 1 Missing product categories

```sql
SELECT COUNT(*)
FROM products
WHERE product_category_name IS NULL;
```
**Query Result**

![Missing Product Categories](images/missing_product_categories.png)

**Observation**

Some products have NULL category values, indicating incomplete product metadata.

---

### 2 Orders without delivery date

```sql
SELECT COUNT(*)
FROM orders
WHERE order_delivered_customer_date IS NULL;
```
**Query Result**

![orders_without_delivery_date.png](images/orders_without_delivery_date.png)

**Observation**

2965 orders found without delivery date

---

### 3 Duplicate geolocation rows

```sql
SELECT geolocation_zip_code_prefix, COUNT(*)
FROM geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1;
```
**Query Result**

![duplicate_geolocation_rows.png](images/duplicate_geolocation_rows.png)

**Observation**

Around 17000 duplicate rows found in geolocation on the bases of zip_code_prefix 

---

### 4 Duplicate review IDs

```sql
SELECT review_id, COUNT(*)
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;
```
**Query Result**

![duplicate_review_ids.png](images/duplicate_review_ids.png)

**Observation**

There are no duplicated value found in order review because this was not inserted while data inserted 

---

### 5 Orders with multiple payments

```sql
SELECT order_id, COUNT(*)
FROM order_payments
GROUP BY order_id
HAVING COUNT(*) > 1;
```
**Query Result**

![orders_with_multiple_payments.png](images/orders_with_multiple_payments.png)

**Observation**

There are many duplicate order payment found on the bases of order id

---

### 6 Customers without orders

```sql
SELECT COUNT(*)
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```
**Query Result**

![customers_without_orders.png](images/customers_without_orders.png)

**Observation**

No customer found without order using above query

---

### 7 Orders without reviews

```sql
SELECT COUNT(*)
FROM orders o
LEFT JOIN order_reviews r
ON o.order_id = r.order_id
WHERE r.review_id IS NULL;
```

**Query Result**

![orders_without_reviews.png](images/orders_without_reviews.png)

**Observation**

1274 Order found which not have any review it means many customer dose not want to give any review

---

### 8 Products never sold

```sql
SELECT COUNT(*)
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
```
**Query Result**

![products_never_sold.png](images/products_never_sold.png)

**Observation**

This mean what data available in products that all are sold

---

### 9 Sellers without orders

```sql
SELECT COUNT(*)
FROM sellers s
LEFT JOIN order_items oi
ON s.seller_id = oi.seller_id
WHERE oi.seller_id IS NULL;
```
**Query Result**

![sellers_without_orders.png](images/sellers_without_orders.png)

**Observation**

There are no seller without order  

---

### 10 Payment mismatch possibility

```sql
SELECT order_id
FROM order_payments
GROUP BY order_id
HAVING SUM(payment_value) <= 0;
```
**Query Result**

![payment_mismatch_possibility.png](images/payment_mismatch_possibility.png)

**Observation**

Some orders payment less then zero found 