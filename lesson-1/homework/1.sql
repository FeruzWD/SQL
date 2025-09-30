CREATE DATABASE SchoolDB;
5. Create Students table
sql
Копировать код
USE SchoolDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
6. Differences between SQL Server, SSMS, and SQL:
SQL Server: A relational database management system (RDBMS) developed by Microsoft to store and manage data.

SSMS (SQL Server Management Studio): A tool (IDE) for managing SQL Server databases, running queries, and performing administrative tasks.

SQL (Structured Query Language): A programming language used to interact with relational databases (e.g., querying, updating, creating tables).

✅ Hard
7. Different SQL Commands:
DQL (Data Query Language) – Used to query data.
Example:

sql
Копировать код
SELECT * FROM Students;
DML (Data Manipulation Language) – Used to manipulate data.
Example:

sql
Копировать код
INSERT INTO Students VALUES (1, 'Ali', 20);
UPDATE Students SET Age = 21 WHERE StudentID = 1;
DELETE FROM Students WHERE StudentID = 1;
DDL (Data Definition Language) – Used to define database objects.
Example:

sql
Копировать код
CREATE TABLE Courses (CourseID INT PRIMARY KEY, CourseName VARCHAR(50));
ALTER TABLE Students ADD Grade VARCHAR(10);
DROP TABLE Courses;
DCL (Data Control Language) – Used to control permissions.
Example:

sql
Копировать код
GRANT SELECT ON Students TO User1;
REVOKE INSERT ON Students FROM User1;
TCL (Transaction Control Language) – Used to manage transactions.
Example:

sql
Копировать код
BEGIN TRANSACTION;
UPDATE Students SET Age = 22 WHERE StudentID = 1;
COMMIT;
-- or ROLLBACK if error occurs
8. Insert three records into Students
sql
Копировать код
INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Ali', 20),
(2, 'Dilshod', 21),
(3, 'Malika', 19);
