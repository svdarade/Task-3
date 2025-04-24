Task 3: SQL for Data Analysis
Database: ecommerce

1.for View all customers
SELECT * FROM Customers;

2. for View all orders with customer names
SELECT o.OrderID, c.CustomerName, o.OrderDate
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

3.View all products ordered in each order
SELECT od.OrderID, p.ProductName, od.Quantity
FROM OrderDetails od
INNER JOIN Products p ON od.ProductID = p.ProductID;

4.Total order amount per customer
SELECT c.CustomerName, SUM(p.Price * od.Quantity) AS TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerName;

5.Customers who placed more than 1 order (using subquery)
SELECT CustomerName FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(*) > 1
);

6.Products with price greater than average price
SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

7.Create a view for customer order summary
CREATE VIEW CustomerOrderSummary AS
SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

8.Optimize: Create index on Orders.CustomerID
CREATE INDEX idx_orders_customerid ON Orders(CustomerID);
