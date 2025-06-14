
CREATE DATABASE cotton_management_system;
USE cotton_management_system;

-- 1. Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    mobile_number VARCHAR(15),
    user_type ENUM('buyer', 'seller') NOT NULL,
    address TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from users;



-- 2. Admins Table
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'approver'
);
INSERT INTO admins (name, email, password, role) VALUES ('admin', 'admin@gmail.com', 'admin', 'approver');




select * from admins;

-- 3. Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id INT NOT NULL,
    cotton_type VARCHAR(100) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL, -- in kg or quintal
    quality_grade VARCHAR(50),
    price_per_unit DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    listing_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(user_id) ON DELETE CASCADE
);

SELECT * FROM products;

-- 4. Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id INT NOT NULL,
    seller_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_requested DECIMAL(10,2),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('pending', 'confirmed', 'cancelled', 'delivered') DEFAULT 'pending',
    remarks TEXT,
    FOREIGN KEY (buyer_id) REFERENCES users(user_id),
    FOREIGN KEY (seller_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Payments Table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    payment_status ENUM('pending', 'confirmed', 'rejected') DEFAULT 'pending',
    confirmation_by_admin_id INT,
    confirmation_date TIMESTAMP NULL,
    payment_note TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (confirmation_by_admin_id) REFERENCES admins(admin_id)
);


INSERT INTO users (name, email, password, mobile_number, user_type, address, is_verified)
VALUES
('Alice', 'alice@example.com', 'password1', '9876543210', 'buyer', '1234 Elm St, Springfield', TRUE),
('Bob', 'bob@example.com', 'password2', '9876543211', 'seller', '5678 Oak St, Springfield', TRUE),
('Charlie', 'charlie@example.com', 'password3', '9876543212', 'buyer', '9101 Pine St, Springfield', FALSE),
('David', 'david@example.com', 'password4', '9876543213', 'seller', '1122 Maple St, Springfield', TRUE),
('Eve', 'eve@example.com', 'password5', '9876543214', 'buyer', '3344 Birch St, Springfield', TRUE),
('Frank', 'frank@example.com', 'password6', '9876543215', 'seller', '5566 Cedar St, Springfield', FALSE),
('Grace', 'grace@example.com', 'password7', '9876543216', 'buyer', '7788 Willow St, Springfield', TRUE),
('Hank', 'hank@example.com', 'password8', '9876543217', 'seller', '9900 Ash St, Springfield', TRUE),
('Ivy', 'ivy@example.com', 'password9', '9876543218', 'buyer', '2233 Poplar St, Springfield', TRUE),
('Jack', 'jack@example.com', 'password10', '9876543219', 'seller', '4455 Fir St, Springfield', FALSE),
('Karen', 'karen@example.com', 'password11', '9876543220', 'buyer', '6677 Cypress St, Springfield', TRUE),
('Louis', 'louis@example.com', 'password12', '9876543221', 'seller', '8899 Redwood St, Springfield', TRUE),
('Mona', 'mona@example.com', 'password13', '9876543222', 'buyer', '1111 Maplewood St, Springfield', FALSE),
('Nina', 'nina@example.com', 'password14', '9876543223', 'seller', '3333 Elmwood St, Springfield', TRUE),
('Oscar', 'oscar@example.com', 'password15', '9876543224', 'buyer', '5555 Oakwood St, Springfield', TRUE);


INSERT INTO admins (name, email, password, role)
VALUES
('Admin 1', 'admin1@example.com', 'adminpassword1', 'approver'),
('Admin 2', 'admin2@example.com', 'adminpassword2', 'approver'),
('Admin 3', 'admin3@example.com', 'adminpassword3', 'approver'),
('Admin 4', 'admin4@example.com', 'adminpassword4', 'approver'),
('Admin 5', 'admin5@example.com', 'adminpassword5', 'approver'),
('Admin 6', 'admin6@example.com', 'adminpassword6', 'approver'),
('Admin 7', 'admin7@example.com', 'adminpassword7', 'approver'),
('Admin 8', 'admin8@example.com', 'adminpassword8', 'approver'),
('Admin 9', 'admin9@example.com', 'adminpassword9', 'approver'),
('Admin 10', 'admin10@example.com', 'adminpassword10', 'approver'),
('Admin 11', 'admin11@example.com', 'adminpassword11', 'approver'),
('Admin 12', 'admin12@example.com', 'adminpassword12', 'approver'),
('Admin 13', 'admin13@example.com', 'adminpassword13', 'approver'),
('Admin 14', 'admin14@example.com', 'adminpassword14', 'approver'),
('Admin 15', 'admin15@example.com', 'adminpassword15', 'approver');

select * from admins;

INSERT INTO products (seller_id, cotton_type, quantity, quality_grade, price_per_unit)
VALUES
(1, 'Cotton A', 1000.00, 'Grade A', 50.00),
(3, 'Cotton B', 1500.00, 'Grade B', 45.00),
(4, 'Cotton C', 1200.00, 'Grade A', 55.00),
(5, 'Cotton D', 1300.00, 'Grade A', 60.00),
(6, 'Cotton E', 800.00, 'Grade B', 48.00),
(7, 'Cotton F', 1400.00, 'Grade A', 65.00),
(8, 'Cotton G', 1100.00, 'Grade C', 40.00),
(9, 'Cotton H', 900.00, 'Grade A', 70.00),
(10, 'Cotton I', 950.00, 'Grade B', 42.00),
(11, 'Cotton J', 1000.00, 'Grade A', 60.00),
(12, 'Cotton K', 1300.00, 'Grade C', 38.00),
(13, 'Cotton L', 1100.00, 'Grade A', 75.00),
(14, 'Cotton M', 1400.00, 'Grade B', 50.00),
(15, 'Cotton N', 1500.00, 'Grade A', 68.00);



