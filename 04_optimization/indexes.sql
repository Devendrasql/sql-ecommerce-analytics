CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

CREATE INDEX idx_order_items_seller
ON order_items(seller_id);

CREATE INDEX idx_orders_purchase_time
ON orders(order_purchase_timestamp);

CREATE INDEX idx_payments_order
ON order_payments(order_id);