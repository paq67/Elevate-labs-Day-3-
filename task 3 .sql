-- Categories
CREATE TABLE Category (
    CategoryID INTEGER PRIMARY KEY AUTOINCREMENT,
    CategoryName TEXT NOT NULL
);

-- Products
CREATE TABLE Product (
    ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductName TEXT NOT NULL,
    CategoryID INTEGER NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Customers
CREATE TABLE Customer (
    CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    DOB DATE NOT NULL,
    Email TEXT NOT NULL,
    Password TEXT NOT NULL,
    Contact TEXT NOT NULL
);

-- Orders
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
    OrderDate DATE NOT NULL,
    CustomerID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    TrackingNumber TEXT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Reviews
CREATE TABLE Review (
    ReviewID INTEGER PRIMARY KEY AUTOINCREMENT,
    Rating INTEGER NOT NULL,
    Comment TEXT NOT NULL,
    ProductID INTEGER NOT NULL,
    CustomerID INTEGER NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
-- Categories
INSERT INTO Category (CategoryName) VALUES 
('Electronics'),
('Home Appliances'),
('Fashion'),
('Books');

-- Products
INSERT INTO Product (ProductName, CategoryID) VALUES 
('Air Mouse C120 for Android and Smart TV', 1),
('LED Desk Lamp', 2),
('Men''s Running Shoes', 3),
('The Alchemist - Paulo Coelho', 4);

-- Customers
INSERT INTO Customer (FirstName, LastName, DOB, Email, Password, Contact) VALUES
('Ali', 'Khan', '1990-05-14', 'ali.khan@email.com', 'pass123', '03001234567'),
('Sara', 'Ahmed', '1988-11-02', 'sara.ahmed@email.com', 'secure456', '03007654321');

-- Orders
INSERT INTO Orders (OrderDate, CustomerID, ProductID, TrackingNumber) VALUES
('2024-04-01', 1, 1, 'TRK123456'),
('2024-04-03', 2, 2, 'TRK987654'),
('2024-04-04', 1, 4, 'TRK222333');

-- Reviews
INSERT INTO Review (Rating, Comment, ProductID, CustomerID) VALUES
(5, 'Works perfectly with my Smart TV!', 1, 1),
(4, 'Nice lighting, but plug is a bit loose.', 2, 2),
(3, 'Book arrived late, but story was inspiring.', 4, 1);
SELECT ProductName, ProductID
FROM Product 
WHERE CategoryID=1;
SELECT FirstName, LastName, DOB 
FROM Customer 
ORDER BY DOB DESC;
SELECT CustomerID, COUNT(*) AS TotalOrders 
FROM Orders 
GROUP BY CustomerID;
SELECT o.OrderID, c.FirstName, p.ProductName
FROM Orders o
INNER JOIN Customer c ON o.CustomerID = c.CustomerID
INNER JOIN Product p ON o.ProductID = p.ProductID;
SELECT c.FirstName, o.OrderID
FROM Customer c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;
-- Customers who ordered 'Air Mouse C120 for Android and Smart TV'
SELECT FirstName, LastName 
FROM Customer 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Orders 
    WHERE ProductID = (
        SELECT ProductID 
        FROM Product 
        WHERE ProductName = 'Air Mouse C120 for Android and Smart TV'
    )
);
-- Total orders per product
SELECT ProductID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY ProductID;

-- Average rating per product
SELECT ProductID, ROUND(AVG(Rating), 2) AS AvgRating
FROM Review
GROUP BY ProductID;
CREATE VIEW ProductPerformance AS
SELECT 
    p.ProductName,
    COUNT(o.OrderID) AS TotalOrders,
    ROUND(AVG(r.Rating), 2) AS AvgRating
FROM Product p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
LEFT JOIN Review r ON p.ProductID = r.ProductID
GROUP BY p.ProductID;
SELECT * FROM ProductPerformance ORDER BY TotalOrders DESC;



