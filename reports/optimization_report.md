# Query Optimization Report

## Slow Query Example
```sql
SELECT *
FROM orders
WHERE customer_id = 'example';
```

Execution Time (Before Index)
~120 ms

---

Index Created

```sql
CREATE INDEX idx_orders_customer ON orders(customer_id);
```
Execution Time (After Index)
~3 ms
---
Performance Improvement

40x faster