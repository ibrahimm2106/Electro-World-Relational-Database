# Data Dictionary

| Table | Purpose | Primary Key | Important Foreign Keys |
|---|---|---|---|
| `suppliers` | Supplier contact information | `Supplier_ID` | — |
| `locations` | Store / stock locations | `Location_ID` | — |
| `customers` | Customer account information | `Customer_ID` | — |
| `products` | Electronics catalogue | `Product_ID` | `Supplier_ID` |
| `promotions` | Promotional campaigns | `Promotion_ID` | — |
| `inventory` | Product stock by location | `Inventory_ID` | `Product_ID`, `Location_ID` |
| `sales` | Location-specific sales | `Sales_Transaction_ID` | `Product_ID`, `Customer_ID`, `Location_ID`, `Promotion_ID` |
| `purchases` | Customer purchase records | `Purchase_Transaction_ID` | `Customer_ID`, `Product_ID` |
| `returns` | Product returns | `Return_ID` | `Sales_Transaction_ID`, `Product_ID`, `Customer_ID` |
| `reviews` | Product ratings and comments | `Review_ID` | `Product_ID`, `Customer_ID` |
| `warranties` | Product warranty periods | `Warranty_ID` | `Product_ID` |
| `transactions` | Financial transaction record | `Transaction_ID` | `Sales_Transaction_ID`, `Purchase_Transaction_ID`, `Promotion_ID` |

## Naming Convention

- Table names are plural and lowercase.
- Identifier columns use descriptive `_ID` suffixes.
- Date columns use names such as `Sale_Date`, `Return_Date` and `Last_Restock_Date`.
- Money columns use `DECIMAL` rather than floating-point types.
- Foreign-key names explicitly describe the relationship they enforce.
