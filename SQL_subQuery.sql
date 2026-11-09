					
					
					/* -- SUBQUERY -- */

/* SubQuery in FROM */

/* Task-01:  Find the products that have a price higher than the 
average price of all products */

SELECT *
FROM (
SELECT
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