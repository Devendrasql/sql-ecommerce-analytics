# Data Dictionary

This document describes all tables and columns used in the ShopHub E-Commerce Analytics Database.

The dataset is based on the **Brazilian E-Commerce Public Dataset by Olist**.

---

# 1 Customers Table

Stores information about customers who place orders.

| Column | Data Type | Description |
|------|------|------|
customer_id | TEXT | Unique identifier for each customer |
customer_unique_id | TEXT | Anonymized unique identifier across orders |
customer_zip_code_prefix | INT | First five digits of customer's zip code |
customer_city | TEXT | Customer city |
customer_state | TEXT | Customer state |

---

# 2 Sellers Table

Stores information about sellers who provide products.

| Column | Data Type | Description |
|------|------|------|
seller_id | TEXT | Unique identifier for seller |
seller_zip_code_prefix | INT | Seller zip code prefix |
seller_city | TEXT | Seller city |
seller_state | TEXT | Seller state |

---

# 3 Products Table

Contains information about products sold on the platform.

| Column | Data Type | Description |
|------|------|------|
product_id | TEXT | Unique identifier for product |
product_category_name | TEXT | Category of the product |
product_name_length | INT | Length of product name |
product_description_length | INT | Length of product description |
product_photos_qty | INT | Number of product photos |
product_weight_g | INT | Weight of product in grams |
product_length_cm | INT | Product length in centimeters |
product_height_cm | INT | Product height in centimeters |
product_width_cm | INT | Product width in centimeters |

---

# 4 Orders Table

Stores order transaction details.

| Column | Data Type | Description |
|------|------|------|
order_id | TEXT | Unique identifier for order |
customer_id | TEXT | Customer who placed the order |
order_status | TEXT | Current status of the order |
order_purchase_timestamp | TIMESTAMP | Timestamp when order was placed |
order_approved_at | TIMESTAMP | Timestamp when payment was approved |
order_delivered_carrier_date | TIMESTAMP | Date order was handed to carrier |
order_delivered_customer_date | TIMESTAMP | Date order delivered to customer |
order_estimated_delivery_date | TIMESTAMP | Estimated delivery date |

---

# 5 Order Items Table

Contains detailed information about products within an order.

| Column | Data Type | Description |
|------|------|------|
order_id | TEXT | Order identifier |
order_item_id | INT | Item number within the order |
product_id | TEXT | Product purchased |
seller_id | TEXT | Seller providing the product |
shipping_limit_date | TIMESTAMP | Shipping deadline |
price | NUMERIC | Price of product |
freight_value | NUMERIC | Shipping cost |

Primary Key: `(order_id, order_item_id)`

---

# 6 Order Payments Table

Contains payment details for each order.

| Column | Data Type | Description |
|------|------|------|
order_id | TEXT | Order identifier |
payment_sequential | INT | Payment sequence number |
payment_type | TEXT | Type of payment (credit card, boleto, etc.) |
payment_installments | INT | Number of installments |
payment_value | NUMERIC | Amount paid |

Primary Key: `(order_id, payment_sequential)`

---

# 7 Order Reviews Table

Stores customer feedback and ratings for orders.

| Column | Data Type | Description |
|------|------|------|
review_id | TEXT | Unique review identifier |
order_id | TEXT | Order being reviewed |
review_score | INT | Rating score given by customer |
review_comment_title | TEXT | Title of review |
review_comment_message | TEXT | Review message |
review_creation_date | TIMESTAMP | Date review was created |
review_answer_timestamp | TIMESTAMP | Timestamp of seller response |

---

# 8 Geolocation Table

Stores geographic information related to zip codes.

| Column | Data Type | Description |
|------|------|------|
geolocation_zip_code_prefix | INT | Zip code prefix |
geolocation_lat | NUMERIC | Latitude coordinate |
geolocation_lng | NUMERIC | Longitude coordinate |
geolocation_city | TEXT | City name |
geolocation_state | TEXT | State abbreviation |

---

# Summary

Total Tables: **8**

- customers
- sellers
- products
- orders
- order_items
- order_payments
- order_reviews
- geolocation

The schema supports transactional analysis, customer behavior insights, and operational analytics for the ShopHub e-commerce platform.