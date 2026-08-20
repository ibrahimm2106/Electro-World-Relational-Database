USE electro_world;

INSERT INTO suppliers (Supplier_ID, Name, Contact_Person, Email) VALUES
('SUP001', 'NovaTech Distribution', 'James Carter', 'sales@novatech.example'),
('SUP002', 'Vertex Mobile Supply', 'Aisha Khan', 'orders@vertexmobile.example'),
('SUP003', 'AudioSphere Wholesale', 'Daniel Evans', 'trade@audiosphere.example'),
('SUP004', 'Pulse Wearables', 'Sofia Martin', 'supply@pulsewearables.example'),
('SUP005', 'Optix Imaging', 'Oliver Lewis', 'business@optiximaging.example');

INSERT INTO locations (Location_ID, Address, City, Region) VALUES
('LOC001', '10 Oxford Street', 'London', 'Greater London'),
('LOC002', '25 New Street', 'Birmingham', 'West Midlands'),
('LOC003', '42 Market Street', 'Manchester', 'Greater Manchester'),
('LOC004', '18 Briggate', 'Leeds', 'West Yorkshire'),
('LOC005', '30 Broadmead', 'Bristol', 'Bristol');

INSERT INTO customers (Customer_ID, Name, Email, Phone_Number, Membership_Status, Address) VALUES
('CUST001', 'John Doe', 'john.doe@example.com', '07111 111111', 'Premium', 'London'),
('CUST002', 'Jane Smith', 'jane.smith@example.com', '07222 222222', 'Gold', 'Birmingham'),
('CUST003', 'Alice Johnson', 'alice.johnson@example.com', '07333 333333', 'Silver', 'Manchester'),
('CUST004', 'Bob Wilson', 'bob.wilson@example.com', '07444 444444', 'Bronze', 'Leeds'),
('CUST005', 'Emily Brown', 'emily.brown@example.com', '07555 555555', NULL, 'Bristol');

INSERT INTO products (Product_ID, Supplier_ID, Name, Description, Price, Quantity, Brand, Model_Number) VALUES
('PROD001', 'SUP001', 'Laptop', '15.6-inch Full HD laptop, Intel Core i7, 16GB RAM, 512GB SSD', 999.99, 50, 'Nova', 'N15-PRO'),
('PROD002', 'SUP002', 'Smartphone', '6.5-inch AMOLED smartphone, 256GB storage', 699.99, 100, 'Vertex', 'VX-256'),
('PROD003', 'SUP003', 'Noise-Cancelling Headphones', 'Wireless over-ear headphones with active noise cancellation', 149.99, 200, 'AudioSphere', 'AS-NC7'),
('PROD004', 'SUP004', 'Smartwatch', 'Water-resistant fitness smartwatch with heart-rate monitoring', 199.99, 75, 'Pulse', 'PW-FIT'),
('PROD005', 'SUP005', 'Digital Camera', '24MP camera with 4K video recording', 799.99, 30, 'Optix', 'OX-24K');

INSERT INTO promotions (Promotion_ID, Name, Description, Start_Date, End_Date, Discount_Rate) VALUES
('PROMO001', 'Summer Tech Sale', 'Seasonal discounts across selected electronics', '2024-06-01 00:00:00', '2024-08-31 23:59:59', 0.20),
('PROMO002', 'Student Tech Month', 'Back-to-study offers on laptops and accessories', '2024-09-01 00:00:00', '2024-09-30 23:59:59', 0.15),
('PROMO003', 'Holiday Electronics Event', 'Festive discounts on selected devices', '2024-11-01 00:00:00', '2024-12-31 23:59:59', 0.25),
('PROMO004', 'Spring Clearance', 'Clearance discounts on selected stock', '2024-03-01 00:00:00', '2024-04-30 23:59:59', 0.30),
('PROMO005', 'Wearables Week', 'Promotional event for smartwatches and accessories', '2024-10-01 00:00:00', '2024-10-15 23:59:59', 0.10);

INSERT INTO inventory (Inventory_ID, Product_ID, Location_ID, Quantity_Available, Reorder_Level, Last_Restock_Date) VALUES
('INV001', 'PROD001', 'LOC001', 18, 20, '2024-04-01 09:00:00'),
('INV002', 'PROD002', 'LOC002', 75, 15, '2024-03-25 10:30:00'),
('INV003', 'PROD003', 'LOC003', 50, 10, '2024-04-05 11:45:00'),
('INV004', 'PROD004', 'LOC004', 22, 25, '2024-03-20 14:00:00'),
('INV005', 'PROD005', 'LOC005', 12, 20, '2024-04-10 16:30:00');

INSERT INTO sales (Sales_Transaction_ID, Product_ID, Customer_ID, Location_ID, Promotion_ID, Sale_Date, Quantity_Sold, Sale_Price) VALUES
('SALE001', 'PROD001', 'CUST001', 'LOC001', 'PROMO004', '2024-04-01 12:00:00', 2, 899.99),
('SALE002', 'PROD002', 'CUST002', 'LOC002', 'PROMO004', '2024-04-05 13:00:00', 1, 649.99),
('SALE003', 'PROD003', 'CUST003', 'LOC003', NULL, '2024-04-10 14:00:00', 3, 149.99),
('SALE004', 'PROD004', 'CUST004', 'LOC004', NULL, '2024-04-15 15:00:00', 1, 199.99),
('SALE005', 'PROD005', 'CUST005', 'LOC005', 'PROMO004', '2024-04-20 16:00:00', 2, 749.99);

INSERT INTO purchases (Purchase_Transaction_ID, Customer_ID, Product_ID, Purchase_Date, Quantity_Purchased, Total_Price) VALUES
('PURC001', 'CUST001', 'PROD001', '2024-04-01', 2, 1799.98),
('PURC002', 'CUST002', 'PROD002', '2024-04-05', 1, 649.99),
('PURC003', 'CUST003', 'PROD003', '2024-04-10', 3, 449.97),
('PURC004', 'CUST004', 'PROD004', '2024-04-15', 1, 199.99),
('PURC005', 'CUST005', 'PROD005', '2024-04-20', 2, 1499.98);

INSERT INTO returns (Return_ID, Sales_Transaction_ID, Product_ID, Customer_ID, Return_Reason, Return_Date) VALUES
('RETURN001', 'SALE001', 'PROD001', 'CUST001', 'Defective product', '2024-04-03 10:00:00'),
('RETURN002', 'SALE002', 'PROD002', 'CUST002', 'Changed device preference', '2024-04-07 11:00:00'),
('RETURN003', 'SALE003', 'PROD003', 'CUST003', 'Change of mind', '2024-04-12 12:00:00'),
('RETURN004', 'SALE004', 'PROD004', 'CUST004', 'Not as described', '2024-04-17 13:00:00'),
('RETURN005', 'SALE005', 'PROD005', 'CUST005', 'Damaged during delivery', '2024-04-22 14:00:00');

INSERT INTO reviews (Review_ID, Product_ID, Customer_ID, Rating, Comment, Review_Date) VALUES
('REV001', 'PROD001', 'CUST001', 4.5, 'Powerful laptop and good overall performance.', '2024-04-02 12:30:00'),
('REV002', 'PROD002', 'CUST002', 3.8, 'Good display and storage capacity.', '2024-04-06 15:45:00'),
('REV003', 'PROD003', 'CUST003', 5.0, 'Excellent sound quality and noise cancellation.', '2024-04-11 10:00:00'),
('REV004', 'PROD004', 'CUST004', 2.5, 'Useful features but battery life could improve.', '2024-04-16 09:15:00'),
('REV005', 'PROD005', 'CUST005', 4.0, 'Strong image quality and straightforward controls.', '2024-04-21 14:00:00');

INSERT INTO warranties (Warranty_ID, Product_ID, Start_Date, End_Date, Coverage_Details) VALUES
('WRTY001', 'PROD001', '2024-04-01 00:00:00', '2025-04-01 23:59:59', 'One-year manufacturing-defect warranty'),
('WRTY002', 'PROD002', '2024-04-05 00:00:00', '2025-04-05 23:59:59', 'One-year parts and labour warranty'),
('WRTY003', 'PROD003', '2024-04-10 00:00:00', '2025-04-10 23:59:59', 'One-year electronic-components warranty'),
('WRTY004', 'PROD004', '2024-04-15 00:00:00', '2025-04-15 23:59:59', 'One-year mechanical-failure warranty'),
('WRTY005', 'PROD005', '2024-04-20 00:00:00', '2026-04-20 23:59:59', 'Two-year manufacturing-defect warranty');

INSERT INTO transactions (Transaction_ID, Sales_Transaction_ID, Purchase_Transaction_ID, Promotion_ID, Transaction_Type, Transaction_Date, Amount) VALUES
('TRX001', 'SALE001', NULL, 'PROMO004', 'Sale', '2024-04-01 12:00:00', 1799.98),
('TRX002', 'SALE002', NULL, 'PROMO004', 'Sale', '2024-04-05 13:00:00', 649.99),
('TRX003', NULL, 'PURC003', NULL, 'Purchase', '2024-04-10 14:05:00', 449.97),
('TRX004', NULL, 'PURC004', NULL, 'Purchase', '2024-04-15 15:05:00', 199.99),
('TRX005', 'SALE005', NULL, 'PROMO004', 'Sale', '2024-04-20 16:00:00', 1499.98);
