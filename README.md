# 📦 E-Commerce Architecture & Database Design

This repository contains the **system architecture**, **database design**, and **SQL queries** for a sample E-Commerce application.
The goal is to build a **clean, scalable, and well-documented foundation** for an E-Commerce system.

---

## 📁 Repository Structure

docs/
│
├── erd/ # Entity Relationship Diagrams
│ └── ERD.png
│
├── db-schema/ # SQL scripts for table creation
│ └── schema.sql
│
├── queries/ # All SQL reporting queries
│ ├── daily_revenue.sql
│ ├── monthly_top_products.sql
│ └── customers_over_500.sql
│
├── diagrams/ # Future architectural diagrams
│
└── notes.md # Additional notes & design thoughts

---

## 🧩 Entities Included

1. **Category**
2. **Product**
3. **Customer**
4. **Order**
5. **Order_details**

Each entity includes its primary attributes, keys, and constraints.

---

## 🔗 Entity Relationships

| Entity A       | Relationship | Entity B        |
|----------------|--------------|-----------------|
| Category       | 1 → Many     | Product         |
| Customer       | 1 → Many     | Order           |
| Order          | 1 → Many     | Order_details   |
| Product        | 1 → Many     | Order_details   |

> All relationships have been implemented using proper **Primary Keys (PK)** and **Foreign Keys (FK)**.

---

## 🗂 ERD Diagram

The complete ERD can be found here:

➡️ `docs/erd/ERD.png`

---

## 🧱 Database Schema

The SQL script for building the full schema exists at:

➡️ `docs/db-schema/schema.sql`

It includes:

- Table definitions
- Primary keys
- Foreign key constraints
- Data types
- Recommended indexes

---

## 📊 Analytical SQL Queries (Reporting)

All reporting queries are included in `docs/queries/`.

### ✔ Daily Revenue Report
Generates total revenue for a specific day.

File: `daily_revenue.sql`

### ✔ Monthly Top-Selling Products
Identifies the best-selling products in a given month.

File: `monthly_top_products.sql`

### ✔ Customers Who Spent More Than $500
Retrieves customers whose total spending exceeded $500 in the last month.

File: `customers_over_500.sql`

---
