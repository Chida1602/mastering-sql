--SET OPERATOR

SELECT 
	FirstName,
	LastName 
FROM sales.customers

UNION

SELECT 
	FirstName,
	LastName
FROM sales.Employees;


--UNION 
-- combine the data from employees and customers into one table

SELECT * FROM sales.Customers
SELECT * FROM sales.employees

SELECT FirstName,LastName
FROM sales.Customers
UNION
SELECT FirstName,LastName
FROM sales.employees

--UNION ALL 
-- combine the data from employees and customers into one table,including duplicates

SELECT FirstName,LastName
FROM sales.Customers
UNION ALL
SELECT FirstName,LastName
FROM sales.employees

--EXCEPT 
-- Find the employees who are not customers at the same time

SELECT FirstName,LastName
FROM sales.Employees
EXCEPT
SELECT FirstName,LastName
FROM sales.Customers;

--INTERSECT 
-- Find the EMployees,who are also customers

SELECT FirstName,LastName
FROM sales.Employees
INTERSECT
SELECT FirstName,LastName
FROM sales.Customers;


-- combine Information
/* orders data are store in seprate tables(orders and OrdersArchieve)
combine all orders data into report without duplicates */

SELECT * FROM sales.Orders;
SELECT * FROM sales.OrdersArchive;

SELECT * FROM sales.Orders
UNION
SELECT * FROM sales.OrdersArchive;


SELECT 
       'Orders' AS SourceTable,
       [OrderID],
       [ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM sales.Orders
UNION
SELECT
       'OrdersAechieve' AS SourceTable,
       [OrderID],
       [ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM sales.OrdersArchive
ORDER BY OrderID