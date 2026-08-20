-- Electro World Relational Database
-- Portfolio implementation for MySQL 8.0+

DROP DATABASE IF EXISTS electro_world;
CREATE DATABASE electro_world
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE electro_world;

CREATE TABLE suppliers (
    Supplier_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact_Person VARCHAR(100),
    Email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE locations (
    Location_ID VARCHAR(10) PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Region VARCHAR(100) NOT NULL
);

CREATE TABLE customers (
    Customer_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Phone_Number VARCHAR(20) NOT NULL,
    Membership_Status VARCHAR(20),
    Address VARCHAR(255),
    CONSTRAINT chk_membership_status CHECK (
        Membership_Status IS NULL OR Membership_Status IN ('Bronze', 'Silver', 'Gold', 'Premium')
    )
);

CREATE TABLE products (
    Product_ID VARCHAR(10) PRIMARY KEY,
    Supplier_ID VARCHAR(10) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    Brand VARCHAR(100),
    Model_Number VARCHAR(50),
    CONSTRAINT chk_product_price CHECK (Price >= 0),
    CONSTRAINT chk_product_quantity CHECK (Quantity >= 0),
    CONSTRAINT fk_products_supplier
        FOREIGN KEY (Supplier_ID) REFERENCES suppliers(Supplier_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE promotions (
    Promotion_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Start_Date DATETIME NOT NULL,
    End_Date DATETIME NOT NULL,
    Discount_Rate DECIMAL(5,4) NOT NULL DEFAULT 0,
    CONSTRAINT chk_promotion_dates CHECK (End_Date > Start_Date),
    CONSTRAINT chk_discount_rate CHECK (Discount_Rate BETWEEN 0 AND 1)
);

CREATE TABLE inventory (
    Inventory_ID VARCHAR(10) PRIMARY KEY,
    Product_ID VARCHAR(10) NOT NULL,
    Location_ID VARCHAR(10) NOT NULL,
    Quantity_Available INT NOT NULL,
    Reorder_Level INT NOT NULL,
    Last_Restock_Date DATETIME,
    CONSTRAINT uq_inventory_product_location UNIQUE (Product_ID, Location_ID),
    CONSTRAINT chk_inventory_quantity CHECK (Quantity_Available >= 0),
    CONSTRAINT chk_reorder_level CHECK (Reorder_Level >= 0),
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_inventory_location
        FOREIGN KEY (Location_ID) REFERENCES locations(Location_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE sales (
    Sales_Transaction_ID VARCHAR(10) PRIMARY KEY,
    Product_ID VARCHAR(10) NOT NULL,
    Customer_ID VARCHAR(10) NOT NULL,
    Location_ID VARCHAR(10) NOT NULL,
    Promotion_ID VARCHAR(10),
    Sale_Date DATETIME NOT NULL,
    Quantity_Sold INT NOT NULL,
    Sale_Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_sales_quantity CHECK (Quantity_Sold > 0),
    CONSTRAINT chk_sales_price CHECK (Sale_Price >= 0),
    CONSTRAINT fk_sales_product FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_sales_customer FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_sales_location FOREIGN KEY (Location_ID) REFERENCES locations(Location_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_sales_promotion FOREIGN KEY (Promotion_ID) REFERENCES promotions(Promotion_ID)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE purchases (
    Purchase_Transaction_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID VARCHAR(10) NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    Purchase_Date DATE NOT NULL,
    Quantity_Purchased INT NOT NULL,
    Total_Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_purchase_quantity CHECK (Quantity_Purchased > 0),
    CONSTRAINT chk_purchase_total CHECK (Total_Price >= 0),
    CONSTRAINT fk_purchases_customer FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_purchases_product FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE returns (
    Return_ID VARCHAR(10) PRIMARY KEY,
    Sales_Transaction_ID VARCHAR(10) NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    Customer_ID VARCHAR(10) NOT NULL,
    Return_Reason TEXT,
    Return_Date DATETIME NOT NULL,
    CONSTRAINT fk_returns_sale FOREIGN KEY (Sales_Transaction_ID) REFERENCES sales(Sales_Transaction_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_returns_product FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_returns_customer FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE reviews (
    Review_ID VARCHAR(10) PRIMARY KEY,
    Product_ID VARCHAR(10) NOT NULL,
    Customer_ID VARCHAR(10) NOT NULL,
    Rating DECIMAL(2,1) NOT NULL,
    Comment TEXT,
    Review_Date DATETIME NOT NULL,
    CONSTRAINT uq_customer_product_review UNIQUE (Customer_ID, Product_ID),
    CONSTRAINT chk_review_rating CHECK (Rating BETWEEN 0 AND 5),
    CONSTRAINT fk_reviews_product FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_reviews_customer FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE warranties (
    Warranty_ID VARCHAR(10) PRIMARY KEY,
    Product_ID VARCHAR(10) NOT NULL,
    Start_Date DATETIME NOT NULL,
    End_Date DATETIME NOT NULL,
    Coverage_Details TEXT,
    CONSTRAINT chk_warranty_dates CHECK (End_Date > Start_Date),
    CONSTRAINT fk_warranties_product FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE transactions (
    Transaction_ID VARCHAR(10) PRIMARY KEY,
    Sales_Transaction_ID VARCHAR(10),
    Purchase_Transaction_ID VARCHAR(10),
    Promotion_ID VARCHAR(10),
    Transaction_Type VARCHAR(20) NOT NULL,
    Transaction_Date DATETIME NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_transaction_type CHECK (Transaction_Type IN ('Sale', 'Purchase')),
    CONSTRAINT chk_transaction_amount CHECK (Amount >= 0),
    CONSTRAINT chk_transaction_reference CHECK (
        (Transaction_Type = 'Sale' AND Sales_Transaction_ID IS NOT NULL AND Purchase_Transaction_ID IS NULL)
        OR
        (Transaction_Type = 'Purchase' AND Purchase_Transaction_ID IS NOT NULL AND Sales_Transaction_ID IS NULL)
    ),
    CONSTRAINT fk_transactions_sale FOREIGN KEY (Sales_Transaction_ID) REFERENCES sales(Sales_Transaction_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_transactions_purchase FOREIGN KEY (Purchase_Transaction_ID) REFERENCES purchases(Purchase_Transaction_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_transactions_promotion FOREIGN KEY (Promotion_ID) REFERENCES promotions(Promotion_ID)
        ON UPDATE CASCADE ON DELETE SET NULL
);
