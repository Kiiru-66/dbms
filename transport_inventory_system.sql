-- Drop existing tables
DROP TABLE IF EXISTS Maintenance;
DROP TABLE IF EXISTS Stock_Transactions;
DROP TABLE IF EXISTS Purchases;
DROP TABLE IF EXISTS Vehicles;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Warehouses;
DROP TABLE IF EXISTS Vendors;

-- Warehouses
CREATE TABLE Warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL
);

-- Vendors
CREATE TABLE Vendors (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

-- Categories
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Items
CREATE TABLE Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    category_id INT,
    unit VARCHAR(50) NOT NULL,
    min_stock_level INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Vehicles
CREATE TABLE Vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_number VARCHAR(20) NOT NULL UNIQUE,
    model VARCHAR(100),
    manufacturer VARCHAR(100),
    year_of_manufacture INT
);

-- Purchases
CREATE TABLE Purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_id INT NOT NULL,
    item_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_date DATE NOT NULL,
    unit_cost DECIMAL(10, 2),
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- Stock Transactions (for item usage or restocking)
CREATE TABLE Stock_Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    transaction_type ENUM('IN', 'OUT') NOT NULL,
    quantity INT NOT NULL,
    transaction_date DATETIME NOT NULL,
    remarks TEXT,
    FOREIGN KEY (item_id) REFERENCES Items(item_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- Maintenance Logs (linking items to vehicle maintenance)
CREATE TABLE Maintenance (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity_used INT NOT NULL,
    maintenance_date DATE NOT NULL,
    remarks TEXT,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);
