-- Create database
CREATE DATABASE IF NOT EXISTS web_commerce;
USE web_commerce;

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Passwords should be hashed
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create cart_items table
CREATE TABLE IF NOT EXISTS cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create order_items table
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Insert sample data into products table

INSERT INTO products (name, description, price, image) VALUES
('In Cold Blood by Truman Capote', 'Description for Product 2', 29.99, 'https://m.media-amazon.com/images/I/613Du3aDx8L._AC_UF1000,1000_QL80_.jpg'),
('Waves By Virginia Woolf', 'Description for Product 2', 49.99, 'https://m.media-amazon.com/images/I/91id4AcpMIL._AC_UF1000,1000_QL80_.jpg'),
("Sylvia's Lovers by Elizabeth Gaskell", 'Description for Product 3', 19.99, 'https://m.media-amazon.com/images/I/51YPwNp7L9L._AC_UF1000,1000_QL80_.jpg'),
("Giovanni's Room by James Baldwin", 'Description for Product 4', 99.99, 'https://m.media-amazon.com/images/I/716uKfXNajL._AC_UF1000,1000_QL80_.jpg'),
('Jude The Obscure by Thomas Hardy', 'Description for Product 1', 29.99, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFZvH-WMB-Y4Hl4bDXjNcI17nBuFyTzHrCZA&s'),
('Wuthering Heights by Emily Bronte', 'Description for Product 2', 49.99, 'https://m.media-amazon.com/images/I/81T34Sem-tL._AC_UF1000,1000_QL80_.jpg'),
('Emma by Jane Austen', 'Description for Product 3', 19.99, 'https://m.media-amazon.com/images/I/81f8oZxrEzL._AC_UF1000,1000_QL80_.jpg'),
('Maurice by E. M. Forster', 'Description for Product 4', 99.99, 'https://m.media-amazon.com/images/I/91ZXcY6d4vL._AC_UF1000,1000_QL80_.jpg'),
('Bleak House by Charles Dickens', 'Description for Product 1', 29.99, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwjpfZMiXcPTfV06tdCUhdvxm1ioReaL6Cgg&s'),
('Lincoln In The Bardo', 'Description for Product 2', 49.99, 'https://m.media-amazon.com/images/I/71GZMdD0BrL._UX250_.jpg'),
('The Picture Of Dorian Gray ', 'Description for Product 3', 19.99, 'https://m.media-amazon.com/images/I/51s2vr6DhWL._AC_UF1000,1000_QL80_.jpg'),
('The Divine Comedy by Dante Alighieri', 'Description for Product 4', 99.99, 'https://m.media-amazon.com/images/I/71wUmvbK6VL._AC_UF1000,1000_QL80_.jpg');

-- Insert sample user into users table
-- Password is "password" hashed using a basic MD5 hash for simplicity. 
-- In a real application, use a stronger hashing algorithm like bcrypt.
INSERT INTO users (username, password, email) VALUES
('testuser', MD5('password'), 'testuser@example.com');
