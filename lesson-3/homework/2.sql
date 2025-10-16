1️⃣ Define and explain the purpose of BULK INSERT in SQL Server.

Definition:
BULK INSERT is a command in SQL Server used to import large amounts of data from an external file (like .txt or .csv) into a database table quickly and efficiently.

Example:

BULK INSERT dbo.Products
FROM 'C:\Data\products.txt'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);

2️⃣ List four file formats that can be imported into SQL Server.

✅ .csv (Comma-separated values)
✅ .txt (Text file)
✅ .xml (XML file)
✅ .json (JSON file)

3️⃣ Create a table Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

4️⃣ Insert three records into the Products table
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Mouse', 25.50),
(3, 'Keyboard', 45.00);

5️⃣ Explain the difference between NULL and NOT NULL

NULL means no value / unknown value can be stored.

NOT NULL means the column must always have a value (cannot be empty).

6️⃣ Add a UNIQUE constraint to the ProductName column
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

7️⃣ Write a comment in a SQL query
-- This query retrieves all products from the Products table
SELECT * FROM Products;

8️⃣ Add CategoryID column to the Products table
ALTER TABLE Products
ADD CategoryID INT;

9️⃣ Create a Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

🔟 Explain the purpose of the IDENTITY column

An IDENTITY column automatically generates incremental numbers for each new row — commonly used for primary keys.

Example:

ProductID INT IDENTITY(1,1) PRIMARY KEY

🟠 MEDIUM-LEVEL TASKS (10)
1️⃣ Use BULK INSERT to import data from a text file
BULK INSERT dbo.Products
FROM 'C:\Data\products_data.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

2️⃣ Create a FOREIGN KEY referencing Categories
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

3️⃣ Explain differences between PRIMARY KEY and UNIQUE KEY
Feature	PRIMARY KEY	UNIQUE KEY
Nulls allowed?	❌ No	✅ Yes (one null allowed)
Number per table	Only 1	Many possible
Purpose	Uniquely identifies each row	Ensures uniqueness of values
Index type	Clustered (by default)	Non-clustered
4️⃣ Add CHECK constraint ensuring Price > 0
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

5️⃣ Modify Products table to add column Stock (NOT NULL)
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

6️⃣ Use ISNULL function to replace NULL values in Price column
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

7️⃣ Describe the purpose and usage of FOREIGN KEY constraints

A FOREIGN KEY establishes a relationship between two tables — it ensures that the value in one table (child) matches a value in another table (parent).
It enforces referential integrity.

🔴 HARD-LEVEL TASKS (10)
1️⃣ Create a Customers table with CHECK constraint (Age ≥ 18)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Age INT CHECK (Age >= 18)
);

2️⃣ Create a table with IDENTITY (start=100, increment=10)
CREATE TABLE Orders (
    OrderID INT IDENTITY(100,10) PRIMARY KEY,
    OrderDate DATE
);

3️⃣ Create a table with composite PRIMARY KEY
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

4️⃣ Explain COALESCE vs ISNULL
Function	Description	Example
ISNULL(expr, replacement)	Replaces NULL with a given value	ISNULL(Price, 0)
COALESCE(expr1, expr2, …)	Returns first non-null value from list	COALESCE(Price, DiscountPrice, 0)

Difference: COALESCE can handle multiple expressions; ISNULL only two.

5️⃣ Create Employees table with PRIMARY KEY and UNIQUE KEY
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

6️⃣ Create FOREIGN KEY with ON DELETE/UPDATE CASCADE
ALTER TABLE Orders
ADD CustomerID INT;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE;
