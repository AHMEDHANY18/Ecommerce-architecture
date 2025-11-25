# 📦 E-Commerce Architecture & Database Design

A clean, scalable **database-first foundation** for a sample E-Commerce system.
This repository contains the **ERD**, **full SQL schema**, and a set of **ready-to-run analytical queries** used in real products.

---

## ✅ Contents

- **ERD Diagram** showing entities & relationships
- **SQL Schema** for creating all tables with keys, constraints, and indexes
- **Reporting Queries** for common business metrics (revenue, top products, high‑value customers)

---

## 📁 Structure

```
docs/
├── erd/
│   └── ERD.png
├── db-schema/
│   └── schema.sql
├── queries/
│   ├── daily_revenue.sql
│   ├── monthly_top_products.sql
│   └── customers_over_500.sql
├── diagrams/
└── notes.md
```

---

## 🧩 Entities

- **Category**
- **Product**
- **Customer**
- **Order**
- **Order_details**

---

## 🔗 Relationships (Summary)

- **Category (1) → (Many) Product**
- **Customer (1) → (Many) Order**
- **Order (1) → (Many) Order_details**
- **Product (1) → (Many) Order_details**

---

## 🗂 ERD

Full ERD image: **`docs/erd/ERD.png`**

---

## 🧱 Database Schema

Schema file: **`docs/db-schema/schema.sql`**

<details>
<summary><strong>View Full Schema</strong></summary>

```sql
-- ============================================================
-- E-COMMERCE DATABASE SCHEMA
-- Entities:
--   Category, Product, Customer, Order, Order_details
-- ============================================================

-- ======================
-- 1. CATEGORY TABLE
-- ======================
CREATE TABLE Category (
    category_id     INT PRIMARY KEY,
    category_name   VARCHAR(100) NOT NULL
);

-- ======================
-- 2. PRODUCT TABLE
-- ======================
CREATE TABLE Product (
    product_id      INT PRIMARY KEY,
    category_id     INT NOT NULL,
    name            VARCHAR(150) NOT NULL,
    description     TEXT,
    price           DECIMAL(10,2) NOT NULL,
    stock_quantity  INT NOT NULL,

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES Category(category_id)
        ON DELETE CASCADE
);

-- ======================
-- 3. CUSTOMER TABLE
-- ======================
CREATE TABLE Customer (
    customer_id     INT PRIMARY KEY,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL
);

-- ======================
-- 4. ORDER TABLE
-- ======================
CREATE TABLE `Order` (
    order_id        INT PRIMARY KEY,
    customer_id     INT NOT NULL,
    order_date      DATE NOT NULL,
    total_amount    DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON DELETE CASCADE
);

-- ======================
-- 5. ORDER_DETAILS TABLE
-- ======================
CREATE TABLE Order_details (
    order_detail_id INT PRIMARY KEY,
    order_id        INT NOT NULL,
    product_id      INT NOT NULL,
    quantity        INT NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_orderdetails_order
        FOREIGN KEY (order_id)
        REFERENCES `Order`(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_orderdetails_product
        FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON DELETE CASCADE
);

-- ======================
-- RECOMMENDED INDEXES
-- ======================
CREATE INDEX idx_product_category
    ON Product(category_id);

CREATE INDEX idx_order_customer
    ON `Order`(customer_id);

CREATE INDEX idx_orderdetails_order
    ON Order_details(order_id);

CREATE INDEX idx_orderdetails_product
    ON Order_details(product_id);
```
</details>

---

## 📊 Reporting Queries

All queries are in **`docs/queries/`**.
Each one is written to be directly reusable for dashboards / reports.

### 1) Daily Revenue
**File:** `docs/queries/daily_revenue.sql`
**Goal:** Get total revenue for a specific day.

<details>
<summary><strong>Preview (structure)</strong></summary>

```sql
-- Total revenue per day
SELECT
  o.order_date,
  SUM(od.quantity * od.unit_price) AS daily_revenue
FROM `Order` o
JOIN Order_details od ON od.order_id = o.order_id
WHERE o.order_date = :target_date
GROUP BY o.order_date;
```
</details>

---

### 2) Monthly Top-Selling Products
**File:** `docs/queries/monthly_top_products.sql`
**Goal:** Best‑selling products within a given month.

<details>
<summary><strong>Preview (structure)</strong></summary>

```sql
SELECT
  p.product_id,
  p.name,
  SUM(od.quantity) AS total_sold,
  SUM(od.quantity * od.unit_price) AS total_revenue
FROM `Order` o
JOIN Order_details od ON od.order_id = o.order_id
JOIN Product p ON p.product_id = od.product_id
WHERE EXTRACT(MONTH FROM o.order_date) = :month
  AND EXTRACT(YEAR  FROM o.order_date) = :year
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC;
```
</details>

---

### 3) Customers Over $500
**File:** `docs/queries/customers_over_500.sql`
**Goal:** High‑value customers in the last month.

<details>
<summary><strong>Preview (structure)</strong></summary>

```sql
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  SUM(o.total_amount) AS total_spent
FROM Customer c
JOIN `Order` o ON o.customer_id = c.customer_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '1 month'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > 500
ORDER BY total_spent DESC;
```
</details>

> **Note:** Previews show the intended logic; full versions are in the query files.

---

