🟢 EASY LEVEL
1️⃣ Total number of products available in each category
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

2️⃣ Average price of products in 'Electronics' category
SELECT AVG(Price) AS AvgPrice
FROM Products
WHERE Category = 'Electronics';

3️⃣ List all customers from cities that start with 'L'
SELECT *
FROM Customers
WHERE City LIKE 'L%';

4️⃣ Get all product names that end with 'er'
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

5️⃣ List all customers from countries ending in 'A'
SELECT *
FROM Customers
WHERE Country LIKE '%A';

6️⃣ Show the highest price among all products
SELECT MAX(Price) AS HighestPrice
FROM Products;

7️⃣ Label stock as 'Low Stock' if quantity < 30, else 'Sufficient'
SELECT ProductName,
       StockQuantity,
       CASE
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

8️⃣ Total number of customers in each country
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

9️⃣ Find the minimum and maximum quantity ordered
SELECT MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders;

🟠 MEDIUM LEVEL
1️⃣ Customer IDs who placed orders in Jan 2023 but had no invoices
SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE YEAR(o.OrderDate) = 2023 AND MONTH(o.OrderDate) = 1
  AND o.CustomerID NOT IN (
      SELECT DISTINCT CustomerID
      FROM Invoices
      WHERE YEAR(InvoiceDate) = 2023 AND MONTH(InvoiceDate) = 1
  );

2️⃣ Combine all product names from Products and Products_Discounted (including duplicates)
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

3️⃣ Combine all product names without duplicates
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

4️⃣ Find average order amount by year
SELECT YEAR(OrderDate) AS OrderYear,
       AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);

5️⃣ Group products based on price
SELECT ProductName,
       CASE
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;

6️⃣ Pivot Year values → new columns ([2012], [2013])
SELECT *
INTO Population_Each_Year
FROM (
    SELECT district_name, year, population
    FROM city_population
) AS src
PIVOT (
    SUM(population) FOR year IN ([2012], [2013])
) AS pvt;

7️⃣ Total sales per product
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

8️⃣ Find products that contain 'oo' in the name
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

9️⃣ Pivot City values → new columns
SELECT *
INTO Population_Each_City
FROM (
    SELECT year, district_name, population
    FROM city_population
) AS src
PIVOT (
    SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS pvt;

🔴 HARD LEVEL
1️⃣ Top 3 customers with highest total invoice amount
SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

2️⃣ Transform Population_Each_Year back to City_Population
SELECT district_name, '2012' AS Year, [2012] AS Population FROM Population_Each_Year
UNION ALL
SELECT district_name, '2013' AS Year, [2013] AS Population FROM Population_Each_Year;

3️⃣ List product names and number of times each has been sold
SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;

4️⃣ Transform Population_Each_City back to City_Population
SELECT 'Bektemir' AS City, year, [Bektemir] AS Population FROM Population_Each_City
UNION ALL
SELECT 'Chilonzor', year, [Chilonzor] FROM Population_Each_City
UNION ALL
SELECT 'Yakkasaroy', year, [Yakkasaroy] FROM Population_Each_City
