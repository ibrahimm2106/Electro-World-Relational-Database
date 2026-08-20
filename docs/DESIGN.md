# Database Design Notes

## Purpose

Electro World is modelled as a relational database because its data contains clear, repeatable relationships among customers, products, suppliers, sales, stock, locations and after-sales processes.

The schema supports operational retrieval and analytical reporting without storing the same descriptive information repeatedly in every transaction.

## Main Design Principles

### 1. Clear identifiers

Every table has a descriptive primary key such as `Product_ID`, `Customer_ID` or `Sales_Transaction_ID`.

### 2. Referential integrity

Foreign keys connect operational records back to their parent entities. For example:

- inventory → products and locations;
- sales → products, customers, locations and optional promotions;
- returns → original sales, products and customers;
- reviews → products and customers;
- warranties → products;
- transactions → either sales or purchases.

### 3. Domain validation

`CHECK` constraints are used for values that have a known valid range or domain:

- non-negative prices and quantities;
- positive sale/purchase quantities;
- ratings between 0 and 5;
- promotion discounts between 0 and 1;
- end dates later than start dates;
- valid membership tiers;
- valid transaction types.

### 4. Reduced ambiguity

The original coursework implementation used a transaction relationship where a field named `Sales_Transaction_ID` referenced a promotion. In the portfolio version, the relationships are separated into:

- `Sales_Transaction_ID` → `sales`;
- `Purchase_Transaction_ID` → `purchases`;
- `Promotion_ID` → `promotions`.

### 5. Review traceability

Reviews include `Product_ID` and `Customer_ID`, allowing the database to answer questions such as:

- Which product has the highest rating?
- Which customer submitted a review?
- How many reviews does each product have?

### 6. Supplier traceability

Products include a supplier relationship so catalogue sourcing and supplier-related analysis can be performed directly.

## Normalisation Perspective

The design separates major business concepts into their own tables rather than repeating customer, supplier, product and location details inside transaction rows.

This portfolio version demonstrates a clean relational design rather than claiming a production-ready retail architecture. A larger commercial implementation could further separate line items, supplier orders, payments, users/roles and audit events.
