-- Create data base
CREATE DATABASE warehouse_db;

-- Define structure for employee table
CREATE TABLE IF NOT EXISTS employees (
    picker_id CHAR(7) PRIMARY KEY,
    employee_name VARCHAR(20),
    shift VARCHAR(7)
);

-- Inserting data into employee table
COPY employees
FROM
    'E:\Data Analytics Projects\warehouse_optimization_analytics\data\raw\employees.csv'
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Define sturcture for employee performance table
CREATE TABLE IF NOT EXISTS employee_performance (
    picker_id CHAR(7),
    record_date DATE,
    orders_picked SMALLINT,
    errors SMALLINT,
    hours_worked NUMERIC(3, 1),
    FOREIGN KEY (picker_id) REFERENCES employees (picker_id)
);

-- Insert data into employee Performance table
COPY employee_performance
FROM
    'E:\Data Analytics Projects\warehouse_optimization_analytics\data\raw\employee_performance.csv'
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Define structure for products table
CREATE TABLE IF NOT EXISTS products (
    sku_id CHAR(8) PRIMARY KEY,
    category VARCHAR(15),
    weight_kg NUMERIC(5, 2),
    dimension_cm VARCHAR(9),
    supplier VARCHAR(35)
);

-- Insert data into products table
COPY products
FROM
    'E:\Data Analytics Projects\warehouse_optimization_analytics\data\raw\products.csv'
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Define structure for inventory table
CREATE TABLE IF NOT EXISTS inventory (
    sku_id CHAR(8),
    record_date DATE,
    opening_stock INTEGER,
    closing_stock INTEGER,
    reorder_level SMALLINT,
    replenishment_lead_time SMALLINT,
    unit_cost NUMERIC(7, 2),
    FOREIGN KEY (sku_id) REFERENCES products (sku_id)
);

-- Insert data into inventory table
COPY inventory
FROM
    'E:\Data Analytics Projects\warehouse_optimization_analytics\data\raw\inventory.csv'
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Define structure for orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id CHAR(9) PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    sku_id CHAR(8),
    quantity SMALLINT,
    order_zone CHAR(1),
    picker_id CHAR(7),
    process_time_min SMALLINT,
    order_value NUMERIC(10, 2),
    on_time_flag CHAR(1),
    order_priority VARCHAR(6),
    FOREIGN KEY (sku_id) REFERENCES products (sku_id),
    FOREIGN KEY (picker_id) REFERENCES employees (picker_id)
);

-- Insert data into orders table
COPY orders
FROM
    'E:\Data Analytics Projects\warehouse_optimization_analytics\data\raw\orders.csv'
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');

-- Define structure for shipments table
CREATE TABLE IF NOT EXISTS shipments (
    shipment_id CHAR(13) PRIMARY KEY,
    order_id CHAR(9),
    carrier VARCHAR(10),
    distance_km NUMERIC(7, 2),
    shipping_cost NUMERIC(7, 2),
    delivery_time_days SMALLINT,
    promised_days SMALLINT,
    delivery_status VARCHAR(10),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- Insert data into shipments table
COPY shipments
FROM
    'E:\Data Analytics Projects\warehouse_optimization_analytics\data\raw\shipments.csv'
WITH
    (FORMAT CSV, HEADER TRUE, DELIMITER ',');