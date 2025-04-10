# 🛒 Online Shopping SQL Database

This project is a sample relational database for an online shopping platform. It includes tables for products, customers, orders, categories, and reviews, along with sample data to practice SQL queries, joins, subqueries, aggregations, views, and indexing.

---

## 📂 Database Structure

### 🧱 Tables

- **Customer** – Stores customer details
- **Product** – Product listings linked to categories
- **Category** – Product categories
- **Orders** – Customer purchase records
- **Review** – Customer product reviews

---

## 🔢 Sample Data Included

Prebuilt values are inserted into each table, including:

- 4 Products
- 2 Customers
- 3 Orders
- 3 Reviews
- 4 Categories

---

## 🧪 SQL Features Demonstrated

### ✅ Basic Queries

```sql
SELECT * FROM Product WHERE CategoryID = 1;
SELECT c.FirstName, p.ProductName
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Product p ON o.ProductID = p.ProductID;
✅ Subqueries
sql
Copy
Edit
SELECT FirstName FROM Customer 
WHERE CustomerID IN (
  SELECT CustomerID FROM Orders WHERE ProductID = 1
);
✅ Aggregations
sql
Copy
Edit
SELECT ProductID, AVG(Rating) AS AvgRating 
FROM Review 
GROUP BY ProductID;
✅ Views
sql
Copy
Edit
CREATE VIEW ProductPerformance AS
SELECT p.ProductName, COUNT(o.OrderID) AS TotalOrders, AVG(r.Rating) AS AvgRating
FROM Product p
LEFT JOIN Orders o ON o.ProductID = p.ProductID
LEFT JOIN Review r ON r.ProductID = p.ProductID
GROUP BY p.ProductID;
✅ Indexing for Optimization
sql
Copy
Edit
CREATE INDEX idx_orders_customer ON Orders(CustomerID);
