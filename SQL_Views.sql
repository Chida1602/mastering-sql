
				/*	VIEWS  */

-- USECASE-01 : Central Logic

/* CREATE, ALTER, DROP Views */

-- Task-01 :Find the running Total of sales for each month

-- normal query
SELECT	
	DATETRUNC(month,OrderDate) AS OrderMonth,
	SUM(Sales) AS TotalSales 
FROM Sales.Orders
GROUP BY DATETRUNC(month,OrderDate);

--CTE Query
WITH CTE_monthly_salary AS 
(
	SELECT	
		DATETRUNC(month,OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) TotalOders,
		SUM(Quantity) AS Totalquantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
)
SELECT 
	OrderMonth,
	TotalSales,
	SUM(totalSales) OVER(ORDER BY OrderMonth) AS Runningtotal 
FROM CTE_monthly_salary;

/* Create a VIEW */

--view will be created with Default schema dbo  
GO
CREATE VIEW V_Monthly_Summary AS
(
	SELECT	
		DATETRUNC(month,OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) TotalOders,
		SUM(Quantity) AS Totalquantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
);
GO
/* GO is a batch separator used by SQL Server client tools (like SSMS, Visual Studio, and Azure Data Studio) 
to split a single SQL script into separate execution blocks. */

-- to view all the columns existing in the view
SELECT * FROM V_Monthly_Summary;

SELECT 
	OrderMonth,
	TotalSales,
	SUM(totalSales) OVER(ORDER BY OrderMonth) AS Runningtotal 
FROM V_Monthly_Summary;

--view will be created with sales schema  
GO
CREATE VIEW Sales.V_Monthly_Summary AS
(
	SELECT	
		DATETRUNC(month,OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) TotalOders,
		SUM(Quantity) AS Totalquantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
);
GO
/* Drop a VIEW */

DROP VIEW V_Monthly_Summary;

/* UPDATE a VIEW */

/*
CREATE OR REPLACE VIEW Sales.V_Monthly_Summary AS
(
	SELECT	
		DATETRUNC(month,OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) TotalOders,
		SUM(Quantity) AS Totalquantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
);
*/

-- drop and recreate
GO
DROP VIEW IF EXISTS V_Monthly_Summary;
GO
CREATE VIEW V_Monthly_Summary AS
(
	SELECT	
		DATETRUNC(month,OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) TotalOders
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
);
GO
-- T-SQL

IF OBJECT_ID( 'V_Monthly_Summary','V') IS NOT NULL
	DROP VIEW V_Monthly_Summary;
GO 
CREATE VIEW V_Monthly_Summary AS
(
	SELECT	
		DATETRUNC(month,OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) TotalOders
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
);
GO

-- USECASE-02 : Hide Complexity

-- TASK-01 : Provide the views that combines details
-- from orders,products,cusotmers and employee tables

SELECT * FROM sales.Customers;
SELECT * FROM Sales.Employees;
SELECT * FROM sales.Products;
SELECT * FROM sales.Orders;
GO
CREATE VIEW Sales.V_Order_details AS
(
	SELECT 
		o.OrderID,
		o.OrderDate,
		p.Product,
		p.Category,
		COALESCE(c.FirstName,'') + ' ' + COALESCE(c.LastName,'') AS CustomerName,
		c.Country AS customerCountry,
		COALESCE(e.FirstName,'') + ' ' + COALESCE(e.LastName,'') AS SalesPerson,
		e.Department,
		o.sales,
		o.Quantity
	FROM Sales.Orders As o
	LEFT JOIN sales.Products AS p
	ON p.ProductID =o.ProductID
	LEFT JOIN sales.Customers as c
	ON c.CustomerID =o.CustomerID
	LEFT JOIN sales.Employees as e
	ON e.EmployeeID=o.SalesPersonID
);
GO
SELECT * FROM Sales.V_Order_details;
