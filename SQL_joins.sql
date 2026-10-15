               /* JOINS */


-- NO JOIN
/* Retrieve all data from customers and orders in two different results */
SELECT * FROM customers;

SELECT * FROM orders;


--INNER JOIN
/* Get all customers along with their orders, but only for 
customers who have placed an order */

SELECT * FROM  Customers JOIN orders  ON id=customer_id;

-- add a table name before the column to avoid confusion in joins
SELECT 
    customers.id,
    customers.first_name,
    orders.order_id,
    orders.sales
FROM  Customers 
INNER JOIN orders
ON customers.id=orders.customer_id;

SELECT * FROM  Customers as c INNER JOIN orders as o ON c.id=o.customer_id

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM Customers as c 
INNER JOIN orders as o
ON c.id=o.customer_id

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders as o 
INNER JOIN Customers as c 
ON c.id=o.customer_id

-- LEFT JOIN
/* Get all customers along with their orders
including those without orders */

SELECT * FROM customers;

SELECT * FROM orders;

SELECT * FROM customers as c
LEFT JOIN orders as o
ON c.id =o.customer_id

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM Customers as c 
LEFT JOIN orders as o
ON c.id=o.customer_id

--RIGHT JOIN 
/* Get all customers along with their orders including
orders without matching customers */


SELECT * FROM customers;
SELECT * FROM orders;

SELECT * 
FROM customers as c
RIGHT JOIN orders as o
ON c.id =o.customer_id

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM Customers as c 
RIGHT JOIN orders as o
ON c.id=o.customer_id

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders as o 
LEFT JOIN Customers as c
ON c.id=o.customer_id 
-- will get the same result as the abouve right join query 


--FULL JOIN
/* GET all customers and all orders ,even if there is no match  */

SELECT * FROM customers;
SELECT * FROM orders;

SELECT * 
FROM customers as c
FULL JOIN orders as o
ON c.id =o.customer_id

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders as o 
FULL JOIN Customers as c
ON c.id=o.customer_id 


SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM Customers as c 
FULL JOIN orders as o
ON c.id=o.customer_id


--LEFT ANTI JOIN 
/* Get all the customers who havent placed any order */

SELECT * FROM customers;

Select * FROM orders;

SELECT * 
FROM customers as c
FULL JOIN orders as o
ON c.id =o.customer_id
WHERE o.customer_id IS NULL

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM Customers as c 
LEFT JOIN orders as o
ON c.id=o.customer_id


--RIGHT ANTI JOIN 
/* Get all the Orders without matching cutomers */


SELECT * 
FROM customers as c
RIGHT JOIN orders as o
ON c.id= o.customer_id
WHERE c.id IS NULL


SELECT * 
FROM orders as o
LEFT JOIN customers as c
ON c.id= o.customer_id
WHERE c.id IS NULL


--FULL ANTI JOIN 
/* Find customers withiut orders and orders without customers */

SELECT * 
FROM customers as c
FULL JOIN orders as o
ON c.id=o.customer_id --FULL join

SELECT * 
FROM customers as c
FULL JOIN orders as o
ON c.id=o.customer_id
WHERE c.id Is NULL OR o.customer_id IS NULL;

SELECT * 
FROM orders as o
FULL JOIN customers as c
ON c.id=o.customer_id
WHERE c.id Is NULL OR o.customer_id IS NULL;

/* GET all the cutomers along with their orders ,
but only for customers who have placed an order without inner join */

SELECT * 
FROM customers as c
LEFT JOIN orders as o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;

SELECT * 
FROM orders as o
FULL JOIN customers as c
ON c.id=o.customer_id
WHERE c.id Is NULL AND o.customer_id IS NULL;

--CROSS JOIN
/* Generate all possible combinations of customers and orders */

SELECT * FROM customers;
Select * FROM orders;

SELECT * 
FROM customers
CROSS JOIN orders;



