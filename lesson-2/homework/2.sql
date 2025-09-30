Q1. Find customers who purchased at least one item in March 2024 using EXISTS
SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1
    FROM #Sales sub
    WHERE sub.CustomerName = s.CustomerName
      AND sub.SaleDate BETWEEN '2024-03-01' AND '2024-03-31'
);

✅ Q2. Product with the highest total sales revenue (Quantity × Price)
SELECT Product
FROM (
    SELECT Product, SUM(Quantity * Price) AS TotalRevenue
    FROM #Sales
    GROUP BY Product
) t
WHERE TotalRevenue = (
    SELECT MAX(SUM(Quantity * Price))
    FROM #Sales
    GROUP BY Product
);

✅ Q3. Second highest sale amount
SELECT MAX(SaleAmount) AS SecondHighest
FROM (
    SELECT DISTINCT Quantity * Price AS SaleAmount
    FROM #Sales
) t
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price) FROM #Sales
);

✅ Q4. Total quantity per month using a subquery
SELECT MONTH(SaleDate) AS SaleMonth, SUM(Quantity) AS TotalQty
FROM #Sales
GROUP BY MONTH(SaleDate);

✅ Q5. Customers who bought same products as another customer using EXISTS
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName <> s2.CustomerName
      AND s1.Product = s2.Product
);

✅ Q6. Fruit count pivot
SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

✅ Q7. Family hierarchy (transitive closure)
WITH CTE AS (
    SELECT ParentId, ChildID
    FROM Family
    UNION ALL
    SELECT f.ParentId, c.ChildID
    FROM Family f
    JOIN CTE c ON f.ChildID = c.ParentId
)
SELECT ParentId AS PID, ChildID AS CHID
FROM CTE
ORDER BY PID, CHID;

✅ Q8. Customers with CA delivery → show their TX orders
SELECT o.*
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders c
      WHERE c.CustomerID = o.CustomerID
        AND c.DeliveryState = 'CA'
  );

✅ Q9. Insert missing names into residents
UPDATE r
SET fullname = PARSENAME(REPLACE(address,'name=','.'),1)
FROM #residents r
WHERE fullname IS NULL
   OR fullname = ''
   OR r.address LIKE '%name=%' AND fullname NOT IN (r.address);


(Alternative: use CHARINDEX + SUBSTRING to extract after name= if stricter parsing is needed.)

✅ Q10. Route Tashkent → Khorezm (cheapest & most expensive)
WITH Paths AS (
    SELECT DepartureCity, ArrivalCity, Cost, 
           CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(200)) AS Route
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT p.DepartureCity, r.ArrivalCity, p.Cost + r.Cost,
           CAST(p.Route + ' - ' + r.ArrivalCity AS VARCHAR(200))
    FROM Paths p
    JOIN #Routes r ON p.ArrivalCity = r.DepartureCity
)
SELECT Route, Cost
FROM Paths
WHERE ArrivalCity = 'Khorezm';

✅ Q11. Rank products by insertion sequence
SELECT ID, Vals,
       SUM(CASE WHEN Vals='Product' THEN 1 ELSE 0 END) 
           OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS GroupNo
FROM #RankingPuzzle;

✅ Q12. Employees with sales > average in their department
SELECT e.EmployeeName, e.Department, e.SalesAmount
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
      AND SalesMonth = e.SalesMonth
      AND SalesYear = e.SalesYear
);

✅ Q13. Employees with highest sales in a month using EXISTS
SELECT e.EmployeeName, e.Department, e.SalesAmount, e.SalesMonth
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales sub
    WHERE sub.SalesMonth = e.SalesMonth
      AND sub.SalesYear = e.SalesYear
    GROUP BY sub.SalesMonth, sub.SalesYear
    HAVING e.SalesAmount = MAX(sub.SalesAmount)
);

✅ Q14. Employees who made sales in every month (NOT EXISTS)
SELECT e.EmployeeName
FROM #EmployeeSales e
GROUP BY e.EmployeeName
HAVING NOT EXISTS (
    SELECT DISTINCT SalesMonth
    FROM #EmployeeSales
    WHERE SalesYear = 2024
    EXCEPT
    SELECT SalesMonth
    FROM #EmployeeSales sub
    WHERE sub.EmployeeName = e.EmployeeName
      AND sub.SalesYear = 2024
);

✅ Q15. Products more expensive than average price
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

✅ Q16. Products with stock < max stock
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

✅ Q17. Products in same category as Laptop
SELECT Name
FROM Products
WHERE Category = (
    SELECT Category FROM Products WHERE Name = 'Laptop'
);

✅ Q18. Products > min price in Electronics
SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);

✅ Q19. Products priced above category average
SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE p.Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);

✅ Q20. Products ordered at least once
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

✅ Q21. Products ordered more than avg qty
SELECT p.Name, SUM(o.Quantity) AS TotalQty
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(Quantity) FROM Orders
);

✅ Q22. Products never ordered
SELECT p.Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID
);

✅ Q23. Product with highest total quantity ordered
SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQty
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalQty DESC;
