🟢 EASY-LEVEL TASKS
1️⃣ Minimum price of a product
SELECT MIN(Price) AS MinPrice
FROM Products;

2️⃣ Maximum salary from Employees
SELECT MAX(Salary) AS MaxSalary
FROM Employees;

3️⃣ Count of rows in Customers
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

4️⃣ Count of unique product categories
SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

5️⃣ Total sales amount for product with ID 7
SELECT SUM(SaleAmount) AS TotalSales
FROM Sales
WHERE ProductID = 7;

6️⃣ Average age of employees
SELECT AVG(Age) AS AvgAge
FROM Employees;

7️⃣ Number of employees in each department
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

8️⃣ Min and max price grouped by category
SELECT Category,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

9️⃣ Total sales per customer
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

🔟 Departments with more than 5 employees
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

🟠 MEDIUM-LEVEL TASKS
1️⃣ Total & average sales per product category
SELECT p.Category,
       SUM(s.SaleAmount) AS TotalSales,
       AVG(s.SaleAmount) AS AvgSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

2️⃣ Count employees from HR department
SELECT COUNT(*) AS HR_Employees
FROM Employees
WHERE DepartmentName = 'HR';

3️⃣ Highest & lowest salary by department
SELECT DepartmentName,
       MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

4️⃣ Average salary per department
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

5️⃣ AVG salary and COUNT employees per department
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary,
       COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

6️⃣ Product categories with average price > 400
SELECT Category,
       AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

7️⃣ Total sales for each year
SELECT YEAR(SaleDate) AS SaleYear,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY SaleYear;

8️⃣ Customers who placed ≥ 3 orders
SELECT CustomerID,
       COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

9️⃣ Departments with average salary > 60000
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

🔴 HARD-LEVEL TASKS
1️⃣ Avg price per category > 150
SELECT Category,
       AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

2️⃣ Customers with total sales > 1500
SELECT CustomerID,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

3️⃣ Departments with avg salary > 65000
SELECT DepartmentName,
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

4️⃣ Total amount for orders > $50 freight per customer (TSQL2012 example)

(Assuming table TSQL2012.Sales.Orders with CustomerID, Freight, TotalDue):

SELECT CustomerID,
       SUM(TotalDue) AS TotalAmount,
       MIN(TotalDue) AS LeastPurchase
FROM TSQL2012.Sales.Orders
WHERE Freight > 50
GROUP BY CustomerID;

5️⃣ Total sales + unique products per month/year (Orders)
SELECT YEAR(OrderDate) AS OrderYear,
       MONTH(OrderDate) AS OrderMonth,
       SUM(TotalAmount) AS TotalSales,
       COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2
ORDER BY OrderYear, OrderMonth;

6️⃣ Min and Max order quantity per year
SELECT YEAR(OrderDate) AS OrderYear,
       MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
