			
			/* COMMON TABLE EXPRESSION */

/* standalone CTE */

-- Step :1 Find the total sales per customer

-- CTE query
WITH CTE_total_sales AS
(
SELECT 
	CustomerID,
	SUM(sales) AS totalSales
FROM Sales.Orders
GROUP BY CustomerID
)
-- main query
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.totalSales
FROM sales.Customers AS c
LEFT JOIN CTE_total_sales AS cts
ON cts.CustomerID = c.CustomerID
ORDER BY CustomerID;

/* multiples standalone CTE */

-- Step :1 Find the total sales per customer
-- step :2 find the last orderdate for each customer

-- CTE query 1
WITH CTE_total_sales AS
(
SELECT 
	CustomerID,
	SUM(sales) AS totalSales
FROM Sales.Orders
GROUP BY CustomerID
)
-- CTE query 2
,CTE_Last_order AS(
SELECT
	CustomerID,
	MAX(OrderDate) AS last_order
FROM sales.Orders
GROUP BY CustomerID
)
-- main query
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.totalSales,
	clo.last_order
FROM sales.Customers AS c
LEFT JOIN CTE_total_sales AS cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_order As clo
ON clo.CustomerID = c.CustomerID;

/* NESTED CTE */

-- Step :1 Find the total sales per customer
WITH CTE_Total_sales AS 
(
SELECT 
	customerID,
	SUM(sales) AS totalSales
FROM sales.Orders
GROUP BY CustomerID
)

-- step :2 find the last orderdate for each customer

,CTE_Last_order AS 
(
SELECT 
	CustomerID,
	MAX(orderDate) AS last_order
FROM Sales.Orders
GROUP BY CustomerID
)

-- step :3 Rank the customers based on total sales per customer

,CTE_Customer_rank AS 
(
SELECT
	CustomerID,
	totalSales,
	RANK() OVER( ORDER BY totalSales DESC) AS customer_rank
From CTE_Total_sales
)

-- step :4 segment customers based on their total sales

, CTE_customer_segments AS (
SELECT 
	customerID,
	totalSales,
	CASE
		WHEN totalSales > 100 THEN 'High'
		WHEN totalSales > 80 THEN 'Medium'
		ELSE 'Low'
	END AS CustomerSegments
FROM CTE_Total_sales
)

-- main query
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.totalSales,
	clo.last_order,
	cr.customer_rank,
	cs.CustomerSegments
FROM sales.Customers AS c
LEFT JOIN CTE_total_sales AS cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_order As clo
ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_rank AS cr
ON cr.CustomerID = c.CustomerID
LEFT JOIN CTE_customer_segments As cs
ON cs.CustomerID = c.CustomerID;


/* Rescursive CTE */

-- Task :01 Generate a sequence of numbers from 1 to 20 

WITH series AS(
	-- anchor query
	SELECT 
	1 As mynumber
	UNION ALL
	-- recursive Query
	SELECT 
	mynumber + 1
	FROM series
	WHERE mynumber <20
)
-- main query 
SELECT * 
FROM series
OPTION (MAXRECURSION 100);

-- Task :02 Generate a * pattern of of 5 rows increasing

WITH Row_pattern AS (
	-- anchor query
	SELECT 
	1 AS n
	UNION ALL
	-- recursive query
	SELECT 
		n+1
	FROM Row_pattern
	WHERE n<5
)
-- main query 
SELECT REPLICATE('*',n) As pattern
FROM Row_pattern;

-- Task :03 Generate a * pattern of of 10 rows decreasing

WITH Row_pattern AS (
	-- anchor query
	SELECT 
	5 AS n
	UNION ALL
	-- recursive query
	SELECT 
		n-1
	FROM Row_pattern
	WHERE n>1
)
-- main query 
SELECT REPLICATE('*',n) As pattern
FROM Row_pattern;

-- Task-04 : show the employee hirarechy by displaying each employee's level
-- within the organisation

WITH CTE_emp_hierarchy AS
(
	-- anchor query
	SELECT 
		EmployeeID,
		FirstName,
		ManagerId,
		1 AS Level
	FROM sales.Employees
	WHERE ManagerID IS NULL
	UNION ALL
	-- Recursive query 
	SELECT 
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level + 1
	FROM sales.Employees AS e
	INNER JOIN CTE_emp_hierarchy AS ceh
	ON e.ManagerID = ceh.EmployeeID
)
-- main query 
SELECT * FROM CTE_emp_hierarchy;