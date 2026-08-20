USE electro_world;

-- 1. Comparison operator + ordering: products that need restocking.
SELECT Product_Name, City, Quantity_Available, Reorder_Level, Stock_Status
FROM vw_inventory_status
WHERE Quantity_Available <= Reorder_Level
ORDER BY Quantity_Available ASC;

-- 2. LIKE operator: search the catalogue.
SELECT Product_ID, Name, Brand, Price
FROM products
WHERE Name LIKE '%Smart%'
ORDER BY Price DESC;

-- 3. BETWEEN + logical operator.
SELECT Sales_Transaction_ID, Product_ID, Customer_ID, Sale_Date, Sale_Price
FROM sales
WHERE Sale_Date BETWEEN '2024-04-01' AND '2024-04-15 23:59:59'
  AND Sale_Price > 150
ORDER BY Sale_Date;

-- 4. IN operator: higher membership tiers.
SELECT Customer_ID, Name, Membership_Status
FROM customers
WHERE Membership_Status IN ('Gold', 'Premium');

-- 5. INNER JOIN: sale with customer, product and location.
SELECT
    s.Sales_Transaction_ID,
    c.Name AS Customer_Name,
    p.Name AS Product_Name,
    l.City,
    s.Quantity_Sold,
    s.Sale_Price
FROM sales AS s
JOIN customers AS c ON c.Customer_ID = s.Customer_ID
JOIN products AS p ON p.Product_ID = s.Product_ID
JOIN locations AS l ON l.Location_ID = s.Location_ID
ORDER BY s.Sale_Date;

-- 6. LEFT JOIN: all products and associated promotions where available.
SELECT DISTINCT
    p.Product_ID,
    p.Name AS Product_Name,
    pr.Name AS Promotion_Name
FROM products AS p
LEFT JOIN sales AS s ON s.Product_ID = p.Product_ID
LEFT JOIN promotions AS pr ON pr.Promotion_ID = s.Promotion_ID
ORDER BY p.Name;

-- 7. Aggregation + GROUP BY: revenue by product.
SELECT
    p.Product_ID,
    p.Name AS Product_Name,
    SUM(s.Quantity_Sold) AS Units_Sold,
    ROUND(SUM(s.Quantity_Sold * s.Sale_Price), 2) AS Revenue
FROM sales AS s
JOIN products AS p ON p.Product_ID = s.Product_ID
GROUP BY p.Product_ID, p.Name
ORDER BY Revenue DESC;

-- 8. Aggregate ratings.
SELECT
    p.Product_ID,
    p.Name AS Product_Name,
    ROUND(AVG(r.Rating), 2) AS Average_Rating,
    COUNT(r.Review_ID) AS Review_Count
FROM products AS p
LEFT JOIN reviews AS r ON r.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Name
ORDER BY Average_Rating DESC;

-- 9. Nested query: above-average product prices.
SELECT Product_ID, Name, Price
FROM products
WHERE Price > (SELECT AVG(Price) FROM products)
ORDER BY Price DESC;

-- 10. Nested aggregation: customers spending above the average customer total.
SELECT
    c.Customer_ID,
    c.Name,
    SUM(pu.Total_Price) AS Total_Spend
FROM customers AS c
JOIN purchases AS pu ON pu.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING SUM(pu.Total_Price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(Total_Price) AS customer_total
        FROM purchases
        GROUP BY Customer_ID
    ) AS customer_totals
)
ORDER BY Total_Spend DESC;

-- 11. Return analysis joined back to the original sale.
SELECT
    r.Return_ID,
    p.Name AS Product_Name,
    c.Name AS Customer_Name,
    r.Return_Reason,
    s.Sale_Date,
    r.Return_Date
FROM returns AS r
JOIN sales AS s ON s.Sales_Transaction_ID = r.Sales_Transaction_ID
JOIN products AS p ON p.Product_ID = r.Product_ID
JOIN customers AS c ON c.Customer_ID = r.Customer_ID
ORDER BY r.Return_Date;

-- 12. View retrieval.
SELECT *
FROM vw_customer_spend
ORDER BY Total_Spend DESC;
