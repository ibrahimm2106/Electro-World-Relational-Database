USE electro_world;

CREATE OR REPLACE VIEW vw_inventory_status AS
SELECT
    i.Inventory_ID,
    p.Product_ID,
    p.Name AS Product_Name,
    l.Location_ID,
    l.City,
    i.Quantity_Available,
    i.Reorder_Level,
    i.Last_Restock_Date,
    CASE
        WHEN i.Quantity_Available <= i.Reorder_Level THEN 'REORDER'
        ELSE 'OK'
    END AS Stock_Status
FROM inventory AS i
JOIN products AS p ON p.Product_ID = i.Product_ID
JOIN locations AS l ON l.Location_ID = i.Location_ID;

CREATE OR REPLACE VIEW vw_customer_spend AS
SELECT
    c.Customer_ID,
    c.Name AS Customer_Name,
    c.Membership_Status,
    COUNT(pu.Purchase_Transaction_ID) AS Purchase_Count,
    COALESCE(SUM(pu.Total_Price), 0) AS Total_Spend
FROM customers AS c
LEFT JOIN purchases AS pu ON pu.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name, c.Membership_Status;

CREATE OR REPLACE VIEW vw_product_sales_summary AS
SELECT
    p.Product_ID,
    p.Name AS Product_Name,
    COUNT(s.Sales_Transaction_ID) AS Sales_Transactions,
    COALESCE(SUM(s.Quantity_Sold), 0) AS Units_Sold,
    COALESCE(SUM(s.Quantity_Sold * s.Sale_Price), 0) AS Revenue
FROM products AS p
LEFT JOIN sales AS s ON s.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Name;

CREATE OR REPLACE VIEW vw_product_review_summary AS
SELECT
    p.Product_ID,
    p.Name AS Product_Name,
    COUNT(r.Review_ID) AS Review_Count,
    ROUND(AVG(r.Rating), 2) AS Average_Rating
FROM products AS p
LEFT JOIN reviews AS r ON r.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Name;
