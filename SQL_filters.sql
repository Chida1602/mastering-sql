--- WHERE OPERATORS

--COMPARISION OPERATORS

-- = operator (equal)
--Retrieve all customers are from usa 

SELECT * FROM customers
WHERE country = 'USA';

-- != ,<> operator (not equal)
--Retrieve all customers are not from Germany
SELECT * FROM customers
WHERE country != 'Germany';

SELECT * FROM customers
WHERE country <> 'india';

-- > operator (Greater than)
--retrieve all the customers with a score greater than 500
SELECT * FROM customers
WHERE score > 500;

-- >= operator (greater than or equal to)
--retrieve all the customers with a score of 500 or more 
SELECT * FROM customers
WHERE score >= 500;

-- <  Operator (less than)
-- retrieve all the customers with a score less than 500
SELECT * FROM customers
WHERE score < 500 ;

-- <= Operator (less than or equal to )
-- retrieve all the customers with a score less than 500
SELECT * FROM customers
WHERE score <= 500 ;


-- LOGICAL OPERATORS 

-- AND Operator
-- Retrieve all customers who are from the USA 
-- AND have a score greater than 500 
SELECT * FROM customers
WHERE score >=500 AND country = 'usa';

-- OR operator
/* Retrieve all customers who are either from the USA 
OR have a score greater than 500 */
SELECT * FROM customers
WHERE score >=500 OR country = 'usa';

-- NOT operator
/* Retrieve all customers with a score not lessthan 500 */
SELECT * FROM customers
WHERE NOT score <500;


--RANGE OPERATOR 
-- BETWEEN operator
/* Retrieve all customers whose score falls in the range 
between 100 and 500 */
SELECT * FROM customers
WHERE score  BETWEEN 100 AND 500;

SELECT * FROM customers
WHERE score>=100 AND score <=500;

--MEMEMBERSHIP OPERATOR 
-- IN operator
/* Retrieve all customers from either germany or USA */
SELECT * FROM customers
WHERE country = 'Germany' OR country = 'USA';

SELECT * FROM customers
WHERE country IN( 'Germany', 'USA');


SELECT * FROM customers
WHERE country NOT IN( 'Germany', 'USA');


--SEARCH OPERATOR 
-- LIKE operator
/* Retrieve all customers whose first name starts with 'M' */

SELECT * FROM customers
WHERE first_name LIKE 'M%';

/* Retrieve all customers whose last name starts with 'n' */
SELECT * FROM customers
WHERE first_name LIKE '%n';

/* Retrieve all customers whose first name contains 'r' */
SELECT * FROM customers
WHERE first_name LIKE '%r%';

/* find all customers whose first name has 'r' in the third position */
SELECT * FROM customers
WHERE first_name LIKE '__r%';
