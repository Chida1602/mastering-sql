

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
CREATE PROCEDURE GetCustomerSummary AS
BEGIN
	SELECT 
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgScore
	FROM Sales.Customers
	WHERE Country='USA';
END

-- Step 03 : Execute the Stored Procedure

EXEC GetCustomerSummary;
