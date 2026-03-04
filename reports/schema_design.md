# Database Schema Design (3NF)

The ShopHub analytics database is designed following **Third Normal Form (3NF)** to ensure data integrity, eliminate redundancy, and support efficient analytical queries.

Each table represents a distinct business entity such as customers, orders, products, sellers, and payments.

The schema is derived from the **Brazilian E-Commerce Public Dataset by Olist**.

---

## Design Principles

The database follows these normalization principles:

1. **Each table represents a single entity**
   - customers
   - sellers
   - products
   - orders
   - order_items
   - order_payments
   - order_reviews
   - geolocation

2. **Primary Keys**
   - Each table has a unique primary key to identify records.

3. **Foreign Keys**
   - Relationships between entities are maintained using foreign keys.

4. **No Partial Dependencies**
   - Non-key attributes depend entirely on the primary key.

5. **No Transitive Dependencies**
   - Attributes depend only on the key and not on other non-key attributes.

---

## Table Relationships

Key relationships between tables:

- **customers → orders**
  - One customer can place multiple orders.

- **orders → order_items**
  - One order can contain multiple products.

- **products → order_items**
  - Products can appear in multiple order items.

- **sellers → order_items**
  - Sellers provide products for order items.

- **orders → order_payments**
  - Orders may have multiple payment records.

- **orders → order_reviews**
  - Customers can leave reviews for orders.

---

## Entity Relationship Diagram (ERD)

The ERD illustrates how the tables are connected using primary and foreign keys.

Main relationships:

customers(customer_id)
    ↓
orders(customer_id)

orders(order_id)
    ↓
order_items(order_id)

products(product_id)
    ↓
order_items(product_id)

sellers(seller_id)
    ↓
order_items(seller_id)

orders(order_id)
    ↓
order_payments(order_id)

orders(order_id)
    ↓
order_reviews(order_id)

---

## Benefits of This Schema

- Eliminates redundant data
- Maintains referential integrity
- Improves query performance
- Enables complex analytical queries
- Supports scalable data analytics
