

						/* TEMPORARY TABLES */


-- Create a temporary tables

SELECT *
INTO #Orders
FROM Sales.Orders;

-- Retrieve an Temporary table

SELECT * FROM #Orders;

-- DELETE ROWS from Temporary table

DELETE FROM #Orders
WHERE OrderStatus = 'Delivered';

SELECT * FROM #Orders; -- result 

-- now making an result of an temporary table into CTAS

SELECT *
INTO Sales.OrdersShipped
FROM #Orders;

-- now if u close the session and comeback the particular 
-- temporary table doesn't exist