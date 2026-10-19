		/* Window Aggregation */

-- COUNT()

--find the total no. of orders 
SELECT 
COUNT(*) AS total_no_orders
FROM Sales.Orders;

--SUM()
--find the total sales of all orders 

SELECT 
SUM(Sales) AS total_sales
FROM Sales.Orders;

--AVG ()
--Find the average sales of all orders

SELECT 
AVG(Sales) AS avg_sales
FROM Sales.Orders;

--MAX()
-- Find the Higest sales of all orders

SELECT 
MAX(Sales) AS Highest_sales
FROM Sales.Orders;

-- MIN()
-- Find the lowest sales of all orders

SELECT 
MIN(Sales) AS Lowest_sales
FROM Sales.Orders;


-- ALL aggregate

SELECT 
	COUNT(*) AS total_no_orders,
	SUM(Sales) AS total_sales,
	AVG(Sales) AS avg_sales,
	MAX(Sales) AS Highest_sales,
	MIN(Sales) AS Lowest_sales
FROM Sales.Orders
GROUP BY CustomerID	;

-- Find the total sales Across all orders

SELECT 
	SUM(Sales) AS Total_sales
FROM Sales.Orders;

-- Find the total sales For Each product 

SELECT 
	SUM(Sales) AS Total_sales
FROM Sales.Orders
GROUP BY ProductID;

-- Find the total sales For Each product
-- additionaly provide details such orderId and OrderDate

--using GROUP BY
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) AS Total_sales
FROM Sales.Orders
GROUP BY ProductID,OrderID,OrderDate;

-- Using  Window Function

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) AS Total_salesByProdcut 
FROM Sales.Orders;

-- PARTITION BY ()

/* Find the total sales For Each product
additionaly provide details such orderId and OrderDate */

--without using partition By
SELECT 
	OrderID,
	OrderDate,
	SUM(Sales) OVER () AS Total_sales 
FROM Sales.Orders;

-- using Partition BY

SELECT * FROM Sales.Orders;

/* Find the total sales across all orders. Find the total sales 
For Each product additionaly provide details such orderId and OrderDate */

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS Total_salesByProdcut 
FROM Sales.Orders;

/* Find the total sales across all orders. 
Find the total sales For Each product .
Find the total sales For Each combination of Product and Order Status
additionaly provide details such orderId and OrderDate */

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS Total_salesByProdcut ,
	SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) AS salesByProductAndStaus 
FROM Sales.Orders;

-- Window Function ORDER BY ()

/* Rank each order based on their sales from highest to lowest
additionaly provide details such orderId and OrderDate */

SELECT 
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER( ORDER BY Sales DESC) AS ranksales
FROM Sales.Orders;


--Window FRAME 

-- CURRENT ROW AND CURRENT ROW :
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN CURRENT ROW AND CURRENT ROW ) AS TotalSales
FROM Sales.Orders;

-- CURRENT ROW AND N-FOLLOWING :
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS TotalSales
FROM Sales.Orders;

-- CURRENT ROW AND UNBOUNDED-FOLLOWING :
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS TotalSales
FROM Sales.Orders;

-- N-PRECEDING AND CURRENT ROW:
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS TotalSales
FROM Sales.Orders;

-- N-PRECEDING AND N-FOLLOWING:
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS TotalSales
FROM Sales.Orders;

-- N-PRECEDING AND UNBOUNDED FOLLOWING:
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING) AS TotalSales
FROM Sales.Orders;

-- UNBOUNDED-PRECEDING AND CURRENT ROW:
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS TotalSales
FROM Sales.Orders;

-- UNBOUNDED-PRECEDING AND UNBOUNDED FOLLOWING:
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS TotalSales
FROM Sales.Orders;

-- UNBOUNDED-PRECEDING AND N-FOLLOWING:
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING) AS TotalSales
FROM Sales.Orders;


-- COMPACT FRAME 

SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS 2 FOLLOWING ) AS TotalSales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS 2 PRECEDING) AS TotalSales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS UNBOUNDED PRECEDING) AS TotalSales
FROM Sales.Orders;


-- DEFAULT FRAME 

SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate) AS Default_one,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS DefaulT_Frame,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Default_Total_Frame
FROM Sales.Orders;

-- Window Function rules

--only used in SELECT And ORDER BY
SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus) AS TotalSales
FROM Sales.Orders
ORDER BY SUM(Sales) OVER(PARTITION BY OrderStatus) DESC;

-- SQl Execute window funtion after where Clause

/* Find the total sales for each order status only for two products 101 and 102 */

SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	ProductID,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus) AS TotalSales
FROM Sales.Orders
WHERE ProductID IN(101,102);

-- Window functions can be used together with group bybin same query only if
-- same columns are used 
/* Rank customers based on their total sales */

SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) AS Rank_customers
FROM Sales.Orders
GROUP BY CustomerID

SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales,
	RANK() OVER(ORDER BY CustomerID DESC) AS Rank_customers
FROM Sales.Orders
GROUP BY CustomerID