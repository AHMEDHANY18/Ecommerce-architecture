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
