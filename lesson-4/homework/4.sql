EASY LEVEL (10 TASKS)
1️⃣ Top 5 employees
SELECT TOP 5 * FROM Employees;

2️⃣ Unique Category values from Products
SELECT DISTINCT Category FROM Products;

3️⃣ Products with Price > 100
SELECT * FROM Products
WHERE Price > 100;

4️⃣ Customers whose FirstName starts with 'A'
SELECT * FROM Customers
WHERE FirstName LIKE 'A%';

5️⃣ Order Products by Price ascending
SELECT * FROM Products
ORDER BY Price ASC;

6️⃣ Employees with Salary >= 60000 and DepartmentName = 'HR'
SELECT * FROM Employees
WHERE Salary >= 60000 AND DepartmentName = 'HR';

7️⃣ Replace NULL Email with default text
SELECT EmployeeID,
       FirstName,
       LastName,
       ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;

8️⃣ Products with Price BETWEEN 50 AND 100
SELECT * FROM Products
WHERE Price BETWEEN 50 AND 100;

9️⃣ DISTINCT Category and ProductName
SELECT DISTINCT Category, ProductName
FROM Products;

🔟 DISTINCT on two columns + order by ProductName DESC
SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;

🟠 MEDIUM LEVEL (10 TASKS)
1️⃣ Top 10 products ordered by Price DESC
SELECT TOP 10 * FROM Products
ORDER BY Price DESC;

2️⃣ COALESCE FirstName or LastName
SELECT EmployeeID,
       COALESCE(FirstName, LastName) AS DisplayName
FROM Employees;

3️⃣ Distinct Category and Price
SELECT DISTINCT Category, Price
FROM Products;

4️⃣ Employees Age between 30–40 or Department = 'Marketing'
SELECT * FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing';

5️⃣ OFFSET-FETCH rows 11–20 ordered by Salary DESC
SELECT * FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

6️⃣ Products Price <= 1000 and StockQuantity > 50, sort by Stock
SELECT * FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC;

7️⃣ Products where ProductName contains letter 'e'
SELECT * FROM Products
WHERE ProductName LIKE '%e%';

8️⃣ Employees in HR, IT, or Finance
SELECT * FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');

9️⃣ Customers ordered by City ASC, PostalCode DESC
SELECT * FROM Customers
ORDER BY City ASC, PostalCode DESC;

🔴 HARD LEVEL (8 TASKS)
1️⃣ Top 5 products with highest sales (by SaleAmount)
SELECT TOP 5 ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID
ORDER BY TotalSales DESC;

2️⃣ Combine FirstName and LastName into FullName
SELECT EmployeeID,
       (COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '')) AS FullName
FROM Employees;

3️⃣ DISTINCT Category, ProductName, Price where Price > 50
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;

4️⃣ Products where Price < 10% of average price
SELECT * FROM Products
WHERE Price < (0.1 * (SELECT AVG(Price) FROM Products));

5️⃣ Employees Age < 30 and Department = HR or IT
SELECT * FROM Employees
WHERE Age < 30 AND DepartmentName IN ('HR', 'IT');

6️⃣ Customers whose Email contains '@gmail.com'
SELECT * FROM Customers
WHERE Email LIKE '%@gmail.com%';

7️⃣ Employees with salary > ALL employees in 'Sales'
SELECT * FROM Employees
WHERE Salary > ALL (
    SELECT Salary FROM Employees WHERE DepartmentName = 'Sales'
);

8️⃣ Orders placed in the last 180 days
SELECT * FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
