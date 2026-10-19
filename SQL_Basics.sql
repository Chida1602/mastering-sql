---retrive all the customer data From Mydatabase

SELECT * FROM customers;

SELECT * FROM orders;


--- retrive Few colums data from a table

SELECT order_id, sales FROM orders;

SELECT first_name ,country ,score from customers;


--- retrive data based on WHERE cond

SELECT * FROM customers WHERE score != 0;

SELECT * FROM customers WHERE country ='germany';

SELECT first_name,country FROM customers WHERE country ='germany';


--- retrive data using ORDER BY 

SELECT * FROM customers 
ORDER BY score;  -- by default ascending order

SELECT * FROM customers 
ORDER BY score ASC;

SELECT * FROM customers  
ORDER BY score DESC;

-- retrive data using  (Nested) ORDER BY

SELECT * FROM customers
ORDER BY first_name ASC,score DESC ,country ASC ;

-- Group By

SELECT country ,SUM(score) AS Total_score 
FROM customers GROUP BY country ;

SELECT country ,first_name,SUM(score) AS Total_score 
FROM customers GROUP BY country ; --error bcoz first name is not included
--either group By or aggregate


SELECT country ,first_name,SUM(score) AS Total_score 
FROM customers GROUP BY country,first_name ; 

--find the total score and total no. of customer 
-- for each country using group by

SELECT 
	country ,
	COUNT(id) as total_customers,
	SUM(score) AS Total_score 
FROM customers GROUP BY country ;

-- HAVING 

SELECT 
	country,
	SUM(score) AS Total_score
FROM customers 
GROUP BY country
HAVING SUM(score) > 800;

SELECT 
	country,
	SUM(score) AS Total_score
FROM customers 
where Score > 400
GROUP BY country 
HAVING SUM(score) > 800;

/* Find the avg score for each country
considering only customers with a score not equal to 0
and return only those countries with avg score > 430 */

SELECT 
	country,
	AVG(score) as Avg_score 
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG (score) > 430; 

--Distinct 

SELECT DISTINCT
country 
FROM customers;


-- TOP

SELECT TOP 3 * FROM customers;

-- retrive the top 3 customers with highest score 

SELECT TOP 3 * FROM customers 
ORDER BY score DESC;

-- retrive the lowest 2 customers based on score 

SELECT TOP 2 * FROM customers 
ORDER BY score ASC;

-- retrive the two most recent offers 

SELECT TOP 2 * FROM orders
ORDER BY order_date DESC;

-- static Fixed values 

SELECT 123;

SELECT 123 AS Static_number;

SELECT 'Hello' AS Static_String;

-- static fixed values along with the data of the table

SELECT id,first_name,
'new customers' AS Customer_type
FROM customers;

-- Data Defintion language

--create 

/* creare a new table called persons with columns : 
id ,person_name, birth_date and Phone */

CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR (50) NOT NULL ,
	birth_date  DATE ,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pK_persons PRIMARY KEY (id)
);

SELECT * FROM persons;

-- ALTER 

/* add a new column called email to the persons table */

ALTER TABLE persons 
	add email VARCHAR(50) NOT NULL;

SELECT * FROM persons;

/* remove the column phone from the persons table */

ALTER TABLE persons 
	DROP COLUMN phone;

-- DROP

/* Delete the table persons from the database */

-- DROP TABLE persons;

--INSERT

SELECT * FROM customers;

INSERT INTO customers (id, first_name,country,score)
VALUES (7, 'kohli' ,'UK',973),
(8, 'tarun' ,'USA',100);

INSERT INTO customers 
VALUES (9, 'rohit' ,'UK',973);

/* INSERT INTO customers (id, first_name)
VALUES (12, 'rahul'); */

SELECT id,first_name,null,'Unknown'
FROM customers;


-- Insert data from 'customers' to 'persons'
SELECT * FROM persons;

INSERT INTO persons (id,person_name,birth_date,phone)
SELECT id,first_name,null,'Unknown'
FROM customers;

--UPDATE

SELECT * FROM customers;

UPDATE customers
SET score = 0
WHERE id = 6;

-- change the score of customer with ID 10 to 0 and 
--update the country to 'UK'

UPDATE customers
SET score = 0,
 country = 'UK'
WHERE id = 10; 

SELECT * FROM customers;

/* update all customers with a null score by setting 
their score to 0 */

UPDATE customers
SET score= 0
Where score Is null;

SELECT * FROM customers;

SELECT * FROM customers
WHERE country Is null;

UPDATE customers
SET country = 'India'
Where country Is null

--DELETE 

--Delete all the customers with id greater than 10 

DELETE FROM customers
WHERE id =12;

SELECT * FROM customers;

-- Delete all the data from table persons