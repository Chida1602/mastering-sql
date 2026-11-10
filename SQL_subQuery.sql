					
					
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
WHERE price > (SELECT AVG(price) FROM Sales.Products)
