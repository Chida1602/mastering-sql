

					/* STORED PROCEDURES */


/* Task-01: For Us Customers Find the total Number of Customers 
And the Average Score */

-- step 01: Write a Query 

SELECT 
	COUNT(*) AS TotalCustomers,
	AVG(Score) AS AvgScore
FROM Sales.Customers
WHERE Country='USA';

-- Step 02: Turning the Query into a stored Procedure

GO
ALTER PROCEDURE GetCustomerSummary AS
BEGIN
	SELECT 
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgScore
	FROM Sales.Customers
	WHERE Country='USA';
END

-- Step 03 : Execute the Stored Procedure

EXEC GetCustomerSummary;

					/* Parameters */

-- For German Customers find the total number of customers and the average
GO
CREATE PROCEDURE GetCustomerSummaryGermany AS
BEGIN
	SELECT 
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgScore
	FROM Sales.Customers
	WHERE Country='Germany';
END

-- Step 03 : Execute the Stored Procedure

EXEC GetCustomerSummaryGermany; -- repetation


-- Define Stored Procedure

GO
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50)
AS 
BEGIN 
	SELECT 
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgScore
	FROM Sales.Customers
	WHERE Country= @Country
END

-- Execute the Stored Procedure using parameter

EXEC GetCustomerSummary @Country ='Germany';

EXEC GetCustomerSummary @Country ='USA';

-- Drop a stored procedure 

DROP PROCEDURE GetCustomerSummaryGermany;

-- Define Stored Procedure with default value in paramater
GO
ALTER PROCEDURE GetCustomerSummaryDefault @Country NVARCHAR(50) ='USA'
AS 
BEGIN 
	SELECT 
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgScore
	FROM Sales.Customers
	WHERE Country= @Country
END

-- Execute the Stored Procedure which returns default parameter 'USA'

EXEC GetCustomerSummaryDefault;

-- Execute the Stored Procedure using parameter 'Germany'

EXEC GetCustomerSummaryDefault @Country = 'Germany';

				/* Multi-Queries in stored Procedures */

-- Define Stored Procedure with multiple queries

GO
ALTER PROCEDURE GetCustomerSummarymulti @Country NVARCHAR(50) ='USA'
AS 
BEGIN 
	SELECT 
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgScore
	FROM Sales.Customers
	WHERE Country= @Country;

	-- find the total number of orders and Total sales
	SELECT 
		COUNT(OrderID) AS TotalOrders,
		SUM(Sales) AS TotalSales
	FROM Sales.Orders AS o
	JOIN Sales.Customers AS c
	ON c.CustomerID = o.CustomerID
	WHERE c.Country = @Country;
END

-- Execute the stored Procedure of mutli queries of country 'USA'

EXEC GetCustomerSummarymulti;

-- Execute the stored Procedure of mutli queries of country 'Germany'

EXEC GetCustomerSummarymulti @Country ='Germany';
