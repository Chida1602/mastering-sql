				
				/* Stirng Functions */

--CONCAT()
/* Show a list of customers firstname together with their 
country in one column */

SELECT * FROM customers;

SELECT 
	first_name,
	country,
	CONCAT(first_name,' - ' ,country) AS name_country
FROM customers;

--LOWER()
--Transform the customer's firstname to Lowercase

SELECT 
	first_name,
	country,
	CONCAT(first_name,' - ' ,country) AS name_country,
	LOWER(first_name) AS low_name
FROM customers;

SELECT 
	LOWER(first_name) as First_name,
	country
FROM customers;

--UPPER()
--Transform the customer's firstname to Uppercase

SELECT 
	first_name,
	country,
	CONCAT(first_name,' - ' ,country) AS name_country,
	LOWER(first_name) AS low_name,
	UPPER(first_name) AS up_name
FROM customers;

SELECT 
	UPPER(first_name) as First_name,
	country
FROM customers;

-- TRIM()
-- Find customers whose firstname contain leading or trailing spaces

SELECT 
	first_name
FROM customers
WHERE first_name != TRIM(first_name);


SELECT TOP(5)
	first_name,
	LEN(first_name) len_name,
	LEN(TRIM(first_name)) AS Len_Trim_name,
	LEN(first_name) - LEN(TRIM(first_name)) flag
FROM customers;

SELECT 
	first_name,
	LEN(first_name) len_name,
	LEN(TRIM(first_name)) AS Len_Trim_name,
	LEN(first_name) - LEN(TRIM(first_name)) flag
FROM customers
WHERE LEN(first_name) != LEN(TRIM(first_name));


-- REPLACE()
-- Remove Dashes (-) from a phone number

SELECT 
	'123-456-7890' AS number,
	REPLACE('123-456-7890', '-','') AS phone_Number;

SELECT 
	'123-456-7890' AS number,
	REPLACE('123-456-7890', '-','/') AS phone_Number;


-- Replace file extence form txt to csv

SELECT 
	'report.txt' AS old_File_type,
	REPLACE('report.txt','.txt','.csv') AS file_type;

-- LEN()
-- calculate the length of each customers firstname

SELECT 
	first_name,
	LEN(first_name) AS len_name
FROM customers;

-- LEFT()
--Retrieve the first two charcters of each first name 

SELECT 
	first_name,
	LEFT(first_name,2) AS First_2_char
FROM customers;

SELECT 
	first_name,
	LEFT(TRIM(first_name),2) AS First_2_char
FROM customers;

-- RIGHT()
--Retrieve the last two charcters of each first name 

SELECT 
	first_name,
	RIGHT(first_name,2) AS Last_2_char
FROM customers;


-- SUBSTRING()
/* Retriev2 a list of customers first name after 
removing the first character */

SELECT 
	first_name,
	SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS Last_2_char
FROM customers;

				/* Number Functions */

--ROUND()  

SELECT 
	3.516 AS Initial_value,
	ROUND(3.516,2) AS Round_2,
	ROUND(3.516,1) AS Round_1,
	ROUND(3.516,0) AS Round_0
	

--ABS

SELECT 
	-10 AS Initial_value,
	ABS(-10) As ABS_value,
	ABS(10) as ABS_check;