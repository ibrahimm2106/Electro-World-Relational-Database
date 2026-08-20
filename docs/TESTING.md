# Testing Guide

## Automated Test

The repository includes `.github/workflows/mysql-ci.yml`.

The workflow:

1. starts MySQL 8.0;
2. creates the Electro World schema;
3. inserts all sample records;
4. creates the reporting views;
5. executes the example query file;
6. verifies key table counts.

## Manual Smoke Test

After loading the SQL files, run:

```sql
USE electro_world;

SELECT COUNT(*) AS Products FROM products;
SELECT COUNT(*) AS Customers FROM customers;
SELECT COUNT(*) AS Sales FROM sales;
SELECT COUNT(*) AS Purchases FROM purchases;

SELECT *
FROM vw_inventory_status
WHERE Stock_Status = 'REORDER';

SELECT *
FROM vw_product_sales_summary
ORDER BY Revenue DESC;
```

Expected minimum sample counts:

- 5 suppliers
- 5 locations
- 5 customers
- 5 products
- 5 promotions
- 5 inventory rows
- 5 sales
- 5 purchases
- 5 returns
- 5 reviews
- 5 warranties
- 5 transactions

## Integrity Checks

Useful negative tests:

```sql
-- Should fail: rating is outside 0-5.
INSERT INTO reviews
    (Review_ID, Product_ID, Customer_ID, Rating, Comment, Review_Date)
VALUES
    ('BAD001', 'PROD001', 'CUST002', 7.0, 'Invalid rating', NOW());

-- Should fail: unknown supplier.
INSERT INTO products
    (Product_ID, Supplier_ID, Name, Price, Quantity)
VALUES
    ('BAD002', 'SUP999', 'Invalid Product', 10.00, 1);

-- Should fail: a Sale transaction must reference a sale, not a purchase.
INSERT INTO transactions
    (Transaction_ID, Purchase_Transaction_ID, Transaction_Type, Transaction_Date, Amount)
VALUES
    ('BAD003', 'PURC001', 'Sale', NOW(), 100.00);
```
