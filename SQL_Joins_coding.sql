--Multiple table joins

/* task : using the salesDB, Retrieve a list of all orders ,
along the related customer ,product and employee details.for 
each order,display: 
Order ID, customers name, Product name, sales, Price, sales Persons'name */

use SalesDB;

SELECT * FROM sales.Customers;
SELECT * FROM sales.Employees;
SELECT * FROM sales.Orders;
SELECT * FROM sales.OrdersArchive;
SELECT * FROM sales.Products;

SELECT 
	o.OrderID,
	c.FirstName AS CustomerFirstName,
	c.LastName AS CustomerLastName,
	p.Product AS ProductName,
	p.Price,
	o.sales,
	e.FirstName AS EmployeeFirstName,
	e.LastName AS EmployeeLastName
FROM sales.Orders AS o
LEFT JOIN sales.Customers as c ON o.CustomerID=c.CustomerID
LEFT JOIN sales.Products as p ON o.ProductID=p.ProductID
LEFT JOIN sales.Employees as e ON o.SalesPersonID=e.EmployeeID;


