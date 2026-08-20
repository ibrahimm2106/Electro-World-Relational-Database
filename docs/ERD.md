# Entity Relationship Design

The portfolio schema contains **12 principal entity sets**, reflecting the scale of the original database-design coursework.

```mermaid
erDiagram
    SUPPLIERS {
        varchar Supplier_ID PK
        varchar Name
        varchar Contact_Person
        varchar Email UK
    }
    PRODUCTS {
        varchar Product_ID PK
        varchar Supplier_ID FK
        varchar Name
        decimal Price
        int Quantity
        varchar Brand
        varchar Model_Number
    }
    LOCATIONS {
        varchar Location_ID PK
        varchar Address
        varchar City
        varchar Region
    }
    CUSTOMERS {
        varchar Customer_ID PK
        varchar Name
        varchar Email UK
        varchar Phone_Number
        varchar Membership_Status
    }
    INVENTORY {
        varchar Inventory_ID PK
        varchar Product_ID FK
        varchar Location_ID FK
        int Quantity_Available
        int Reorder_Level
        datetime Last_Restock_Date
    }
    PROMOTIONS {
        varchar Promotion_ID PK
        varchar Name
        datetime Start_Date
        datetime End_Date
        decimal Discount_Rate
    }
    SALES {
        varchar Sales_Transaction_ID PK
        varchar Product_ID FK
        varchar Customer_ID FK
        varchar Location_ID FK
        varchar Promotion_ID FK
        datetime Sale_Date
        int Quantity_Sold
        decimal Sale_Price
    }
    PURCHASES {
        varchar Purchase_Transaction_ID PK
        varchar Customer_ID FK
        varchar Product_ID FK
        date Purchase_Date
        int Quantity_Purchased
        decimal Total_Price
    }
    RETURNS {
        varchar Return_ID PK
        varchar Sales_Transaction_ID FK
        varchar Product_ID FK
        varchar Customer_ID FK
        datetime Return_Date
    }
    REVIEWS {
        varchar Review_ID PK
        varchar Product_ID FK
        varchar Customer_ID FK
        decimal Rating
        datetime Review_Date
    }
    WARRANTIES {
        varchar Warranty_ID PK
        varchar Product_ID FK
        datetime Start_Date
        datetime End_Date
    }
    TRANSACTIONS {
        varchar Transaction_ID PK
        varchar Sales_Transaction_ID FK
        varchar Purchase_Transaction_ID FK
        varchar Promotion_ID FK
        varchar Transaction_Type
        datetime Transaction_Date
        decimal Amount
    }

    SUPPLIERS ||--o{ PRODUCTS : supplies
    PRODUCTS ||--o{ INVENTORY : stocked_as
    LOCATIONS ||--o{ INVENTORY : stores
    CUSTOMERS ||--o{ SALES : places
    PRODUCTS ||--o{ SALES : sold_in
    LOCATIONS ||--o{ SALES : occurs_at
    PROMOTIONS o|--o{ SALES : applied_to
    CUSTOMERS ||--o{ PURCHASES : makes
    PRODUCTS ||--o{ PURCHASES : contains
    SALES ||--o{ RETURNS : may_have
    PRODUCTS ||--o{ RETURNS : returned_product
    CUSTOMERS ||--o{ RETURNS : requests
    PRODUCTS ||--o{ REVIEWS : receives
    CUSTOMERS ||--o{ REVIEWS : writes
    PRODUCTS ||--o{ WARRANTIES : covered_by
    SALES o|--o{ TRANSACTIONS : recorded_as
    PURCHASES o|--o{ TRANSACTIONS : recorded_as
    PROMOTIONS o|--o{ TRANSACTIONS : references
```

## Relationship Notes

- A supplier can supply many products; each product has one supplier in this portfolio model.
- A product can be stocked at many locations through inventory records.
- A customer can place many sales and purchase records.
- A sale references one product, one customer and one store location, with an optional promotion.
- Returns point back to the sale that generated them.
- Reviews are linked to both the reviewing customer and reviewed product.
- Warranties are attached to products.
- A transaction records either a sale or a purchase, enforced by a `CHECK` constraint.
