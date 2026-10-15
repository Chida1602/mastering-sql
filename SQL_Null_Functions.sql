	     /* NULL FUNCTIONS */

-- ISNULL()

SELECT 
	ShipAddress,
	BillAddress,
	ISNULL(shipAddress,BillAddress) 
FROM Sales.Orders;

SELECT 
	ShipAddress,
	BillAddress,
	ISNULL(shipAddress,'N/A') 
FROM Sales.Orders;

-- COALESCE ()

SELECT 
	ShipAddress,
	BillAddress,
	COALESCE(shipAddress,BillAddress) as coalesce_values
FROM Sales.Orders;

SELECT 
	ShipAddress,
	BillAddress,
	COALESCE(shipAddress,BillAddress,'unknown') as colaesce_values
FROM Sales.Orders;

-- handling null :Data aggregations

--Find the avg score of the customers

SELECT
	customerID,
	Score,
	AVG(score) Over() As avg_score,
	ISNULL(score,0) as null_score,
	COALESCE(score,0) AS coalesce_score,
	AVG(ISNULL(score,0)) Over() As avg_score_using_null,
	AVG(COALESCE(score,0)) Over() As avg_score_using_coalesce
FROM sales.Customers

-- handling null : Mathematical operations

/* Display the full name of customers in a single field
by merging their first and last names and add 10 
bonus point to each customers score */

SELECT 
	CustomerID,
	FirstName,
	LastName,
	FirstName+' '+LastName AS Full_name,
	COALESCE(LastName, '') AS Lastname_2,
	FirstName+' '+COALESCE(LastName,'') AS Full_name1,
	CONCAT(FirstName,' ',LastName) AS Full_name_concat,
	score,
	score +10 AS score_with_Bonus,
	ISNULL(score,0) +10 AS Final_score_with_Bonus
FROM sales.Customers;

-- Handling NULL : Sorting Data 

/* Sort the customers from the lowest to highest scores 
with nulls appearing last */

SELECT	
	CustomerID,
	score
FROM Sales.Customers
ORDER BY Score;

--1st Method assigning the largest value (lazy way)

SELECT	
	CustomerID,
	score,
	COALESCE(Score,99999) AS sorted_score
FROM Sales.Customers
ORDER BY COALESCE(Score,99999);

-- 2nd method using CASE WHEN () 

SELECT	
	CustomerID,
	Score,
	COALESCE(Score,99999) AS sorted_score,
	CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END,Score;


-- NULLIF ()

SELECT 
	ShipAddress,
	BillAddress,
	NULLIF(shipAddress,BillAddress) AS NULLIF_result
FROM Sales.Orders;

-- Find the sales price for each order by dividing sales by quantity


SELECT 
	OrderID,
	Sales,
	Quantity,
	Sales/Quantity AS Price
FROM Sales.Orders;

SELECT 
	OrderID,
	Sales,
	Quantity,
	Sales/NULLIF(Quantity,0) AS Price
FROM Sales.Orders;

-- IS NULL() and IS NOT NULL()

/* UseCase - Filtering data */

-- identify the customers who have no scores

SELECT 
	*
FROM Sales.customers
WHERE Score IS NULL;

-- List all the customers who have scores

SELECT 
	*
FROM Sales.customers
WHERE Score IS NOT NULL;

/* UseCase - ANTI JOINS */

-- List all Details for customers who have not places any orders

SELECT	
	c.*,
	o.OrderID
FROM sales.customers AS c
LEFT JOIN sales.Orders AS o
ON c.CustomerID=o.CustomerID
WHERE o.CustomerID IS NULL;  -- LEFT ANTI JOIN

-- List all Details for customers who have placed orders

SELECT	
	c.*,
	o.OrderID
FROM sales.customers AS c
LEFT JOIN sales.Orders AS o
ON c.CustomerID=o.CustomerID
WHERE o.CustomerID IS NOT NULL; 

-- NULL Vs Empty Vs Blank Space

WITH Orders AS ( 
SELECT 1 ID, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '   ' 
)
SELECT *,
	LEN(Category) category_len,
	DATALENGTH(Category) Category_length
FROM ORDERS;

-- Handling Null use cases

/* Only use NULL's and empty string but avoid blank spaces */

WITH Orders AS ( 
SELECT 1 ID, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '   ' 
)
SELECT *,
	DATALENGTH(Category) Category_length,
	DATALENGTH(TRIM(Category)) policy1
FROM ORDERS;

/* Only use NULL's avoid both empty string and  blank spaces */

WITH Orders AS ( 
SELECT 1 ID, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '   ' 
)
SELECT *,
	TRIM(Category) AS policy1,
	NULLIF(TRIM(Category),'') AS policy2,
	COALESCE(NULLIF(TRIM(Category),''),'Unknown') AS Policy3
FROM ORDERS;