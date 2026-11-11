					
					/* -- SUBQUERY -- */

/* SubQuery in FROM */

/* Task-01:  Find the products that have a price higher than the 
average price of all products */

-- main query 
SELECT
	*
FROM 
	-- subquery
	(SELECT
		productID,
		price,
		AVG(price) OVER() AS avgprice
	FROM Sales.Products)t
WHERE price > avgprice;

/* Task-02:  rank the customers based on their total amount of sales */

SELECT
	*,
	RANK() OVER(ORDER BY totalSales DESC) AS customerRank
FROM
	(-- subquesry
	SELECT 
		CustomerID,
		SUM(Sales) AS totalSales
	FROM Sales.Orders
	GROUP BY CustomerID )t;

/* SubQuery in SELECT */

/* Task-01 : show the productIDs , productnames ,prices and the 
 total number of orders */

 -- main query
 SELECT 
	productID,
	Product,
	price,
	-- subquery
	(SELECT COUNT(*) FROM Sales.Orders)AS total_no_of_orders,
	(SELECT SUM(sales) FROM Sales.Orders)AS total_no_of_orders,
	(SELECT SUM(price) FROM Sales.Products)AS total_no_of_orders
FROM sales.Products;

SELECT * FROM Sales.Products

/* SubQuery in JOIN */

/* Task-01 : show all customer details and find the total orders
 of each customer */

--main query
SELECT 
	c.*,
	t.TotalOrders
FROM sales.Customers AS c
LEFT JOIN 
	-- subquery
	(SELECT
		CustomerID,
		COUNT(*) TotalOrders
	FROM sales.Orders
	GROUP BY CustomerID)t
ON t.CustomerID = c.CustomerID


/* SubQuery in WHERE */

-- SubQuery in WHERE (comparison operators)

/* Task-01 : Find the products that a price higher than 
the average price of all products */

-- main query
SELECT 
	productID,
	Product,
	price,
	(SELECT AVG(price) FROM Sales.Products) avgprice
FROM sales.Products
--subquery
WHERE price > (SELECT AVG(price) FROM Sales.Products);

-- SubQuery in WHERE (IN operator)

/* Task-01 : show the details of orders made by
 customers in germany */

 -- customers in germany 
SELECT * FROM sales.Customers
WHERE country = 'Germany';

SELECT 
	* 
FROM sales.Orders
WHERE CustomerID IN(1,4);


-- main query
SELECT 
	* 
FROM sales.Orders
WHERE CustomerID IN
				-- subquery 
				(SELECT 
					CustomerID 
				FROM sales.Customers
				WHERE country = 'Germany');

/* Task-01 : show the details of orders made by
 customers not in germany */

-- main query
SELECT 
	* 
FROM sales.Orders
WHERE CustomerID NOT IN
				-- subquery 
				(SELECT 
					CustomerID 
				FROM sales.Customers
				WHERE country = 'Germany');
 


 -- SubQuery in WHERE (ANY operator)

/* Task-01 : find the female employees whose salaries are greater
than the salaries of any male employee */

-- main query
SELECT 
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM sales.Employees	
WHERE Gender = 'F' AND 
-- subquery
salary > ANY(SELECT Salary FROM sales.Employees WHERE Gender = 'M');

SELECT FirstName ,Salary FROM sales.Employees WHERE Gender = 'M'

 -- SubQuery in WHERE (ANY operator)

/* Task-01 : find the female employees whose salaries are greater
than the salaries of all male employees */

-- main query
SELECT 
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM sales.Employees	
WHERE Gender = 'F' AND 
-- subquery
salary > ALL(SELECT Salary FROM sales.Employees WHERE Gender = 'M');

SELECT FirstName ,Salary FROM sales.Employees WHERE Gender = 'M'

/* correlated SubQuery */

/* Task-01 : show all customer details and find the total orders
 of each customer */

-- main query
SELECT 
	*,
	-- subquery
	(SELECT COUNT(*) FROM sales.Orders as o WHERE o.CustomerID = c.CustomerID) As totalOders
FROM sales.Customers As c

-- SubQuery in WHERE (EXISTS)

/* Task-01 : show the details of orders made by
 customers in germany */

-- main query
SELECT 
	*
FROM sales.Orders AS o
WHERE EXISTS 
			 -- subquery
			 (SELECT 1
			  FROM sales.Customers AS c
			  WHERE country = 'Germany'
			  AND c.CustomerID = o.CustomerID);

/* Task-02 : show the details of orders made by
 customers not in germany */

SELECT 
	*
FROM sales.Orders AS o
WHERE NOT EXISTS 
			 -- subquery
			 (SELECT 1
			  FROM sales.Customers AS c
			  WHERE country = 'Germany'
			  AND c.CustomerID = o.CustomerID);