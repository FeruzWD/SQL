Puzzle 1: Finding Distinct Values Based on Two Columns

Goal: Find distinct pairs (col1, col2) where order doesn’t matter (i.e., (a,b) and (b,a) should be considered the same).

✅ Way 1: Use CASE and DISTINCT
SELECT DISTINCT
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;


Explanation:
This approach orders each pair alphabetically before applying DISTINCT, ensuring (a,b) and (b,a) are treated as one.

✅ Way 2: Use GROUP BY with MIN() and MAX()
SELECT 
    MIN(col1) AS col1,
    MAX(col2) AS col2
FROM InputTbl
GROUP BY 
    CASE 
        WHEN col1 < col2 THEN col1 + col2 
        ELSE col2 + col1 
    END;


Explanation:
We group by a normalized form of the pair and pick one representative using aggregate functions.

✅ Expected Output

col1	col2
a	b
c	d
m	n
🧩 Puzzle 2: Removing Rows with All Zeroes

Goal: Exclude rows where all columns are zero.

SELECT * 
FROM TestMultipleZero
WHERE (A + B + C + D) <> 0;


Alternative (for NULL-safe check):

SELECT * 
FROM TestMultipleZero
WHERE COALESCE(A,0) + COALESCE(B,0) + COALESCE(C,0) + COALESCE(D,0) <> 0;


✅ Explanation:
If all values are 0, their sum is 0. Excluding those rows removes the all-zero record.

✅ Expected Output

A	B	C	D
0	0	0	1
0	0	1	0
0	1	0	0
1	0	0	0
1	1	1	0
🧩 Puzzle 3: Find Those with Odd IDs
SELECT * 
FROM section1
WHERE id % 2 <> 0;


✅ Output

id	name
1	Been
3	Steven
5	Genryh
7	Fred
🧩 Puzzle 4: Person with the Smallest ID
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;


✅ Output

id	name
1	Been
🧩 Puzzle 5: Person with the Highest ID
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;


✅ Output

id	name
8	Andro
🧩 Puzzle 6: People Whose Name Starts with 'b'

(Case-insensitive because SQL Server ignores case by default)

SELECT * 
FROM section1
WHERE name LIKE 'b%';


✅ Output

id	name
6	Bruno
🧩 Puzzle 7: Rows Where Code Contains Literal Underscore _

👉 In SQL Server, the underscore _ is a wildcard in LIKE,
so we must escape it using square brackets [ ] or an escape clause.

✅ Option 1 — Using [ ]
SELECT * 
FROM ProductCodes
WHERE Code LIKE '%[_]%';

✅ Option 2 — Using ESCAPE
SELECT * 
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';


✅ Output

Code
X_456
X_ABC
✅ Summary of Techniques Used
Puzzle	Concept Practiced
1	DISTINCT, CASE, GROUP BY
2	Conditional filtering with arithmetic
3	Modulo operator %
4	Sorting + TOP 1
5	Sorting + descending order
6	Pattern matching (LIKE)
7	Escaping wildcards ([_] or ESCAPE)
