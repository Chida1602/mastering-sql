					
					/*  Window Aggregate Functions */
/*  COUNT() */

SELECT
ProductID,
Sales,
COUNT(*) OVER( PARTITION BY ProductID) As Total_count,
COUNT(1) OVER( PARTITION BY ProductID) As Total_count1
FROM Sales.Orders

-- #1-USECASE : OVERALL ANALYSIS
 
-- TASK-1 : FInd the total number of Orders 
 
SELECT 
COUNT (*) AS TotalOrders
FROM Sales.Orders

-- TASK-2 : FInd the total number of Orders 
-- Additonally Provide Details Such as OrderId ,Orderdate

SELECT 
	OrderId,
	OrderDate,
	COUNT(*) OVER () TotalOrders
FROM Sales.Orders;

-- #2-USECASE: TOTAL PER GROUPS: Group-ise Analaysis to understand pattern within diff categories

-- TASK-3 : FInd the total number of Orders 
-- Find the Total number of order for each customers
-- Additonally Provide Details Such as OrderId ,Orderdate

SELECT 
	OrderId,
	OrderDate,
	COUNT(*) OVER () TotalOrders,
	COUNT(*) OVER (PARTITION BY CustomerID) OrdersByCustomers
FROM Sales.Orders;


-- TASk- 4: Find the total number of Orders 
-- Additonaly provide all customers deatials

SELECT 
	*,
	COUNT(*) OVER () AS Total_Customers
FROM Sales.Customers

-- #3-USECASE- DATA QUALITY CHECK : Detecting no. of null by comparing
--  to total number of rows


-- TASk- 5: Find the total number of Customers 
-- Find the total number of scores for the customers
-- Additonaly provide all customers deatials

SELECT 
	*,
	COUNT(*) OVER () AS Total_Customers,
	COUNT(1) OVER () AS Total_Customers1,
	COUNT(Score) OVER() AS totalScores ,
	COUNT(Country) OVER() AS totalCountries
FROM Sales.Customers

--Task-6: Check whether the table 'Orders' Contains any duplicate rows
-- max no. of rows in each window should be 1 

SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
FROM Sales.Orders;

SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
FROM Sales.OrdersArchive;

-- #4-USECASE : IDENTIFY DUPLICATES : Identify the duplicate
-- rows to improve data quality
--Task-7: Check whether the table 'OrdersArchieve' Contains any duplicate rows

SELECT
	*
FROM (
	SELECT 
		OrderID,
		COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
	FROM Sales.OrdersArchive )w
WHERE CheckPK >1

/*  SUM() */s

/* #1-USECASE : OVERALL ANALYSIS */

-- TASK-1 : FInd the total sales across all Orders 
-- Additonally Provide Details Such as OrderId ,Orderdate

SELECT 
	OrderId,
	OrderDate,
	Sales,
	SUM(Sales) OVER () Total_sales
FROM Sales.Orders;

/* #2-USECASE: TOTAL PER GROUPS
Group-wise Analaysis to understand pattern within diff categories */


-- TASK-2 : FInd the total sales across all Orders 
-- Find the Total sales for each Product
-- Additonally Provide Details Such as OrderId ,Orderdate

SELECT 
	OrderId,
	OrderDate,
	Sales,
	ProductID,
	SUM(Sales) OVER () TotalSales,
	SUM(sales) OVER (PARTITION BY ProductID ) AS SalesByProduct
FROM Sales.Orders;

/* #3-USECASE: PART-TO-WHOLE
Shows the  contribution of each data point to overall dataset */


-- TASK-3 : FInd the percentage contribution of each products sales 
-- to the total sales across all Orders 

SELECT 
	OrderId,
	OrderDate,
	Sales,
	ProductID,
	SUM(Sales) OVER () TotalOrders,
	ROUND(CAST(sales AS FLOAT)/SUM(sales) OVER() *100 ,2) AS percentageofTotal
FROM Sales.Orders;

/*  AVG() */

/* #1-USECASE : OVERALL ANALYSIS */

-- TASK-1 : FInd the average sales across all Orders 
-- Additonally Provide Details Such as OrderId ,Orderdate

SELECT 
	OrderId,
	OrderDate,
	Sales,
	AVG(Sales) OVER () avg_sales
FROM Sales.Orders;

/* #2-USECASE: TOTAL PER GROUPS
Group-wise Analaysis to understand pattern within diff categories */

-- TASK-2 : FInd the avaerage sales across all Orders 
-- Find the average sales for each Product
-- Additonally Provide Details Such as OrderId ,Orderdate

SELECT 
	OrderId,
	OrderDate,
	Sales,
	ProductID,
	AVG(Sales) OVER () avg_sales,
	AVG(Sales) OVER (PARTITION BY ProductID ) AS AvgSalesByProduct
FROM Sales.Orders;

/* NULL HANDLING */
-- TASK-3: FInd the avaerage scores of customers
-- Additonally Provide Details Such as customerId ,Lastname

SELECT 
	CustomerID,
	LastName,
	Score,
	AVG(Score) OVER () avg_score,
	COALESCE(Score,0) AS customscore,
	AVG(COALESCE(Score,0)) OVER () AS AvgScorewithoutnull
FROM Sales.Customers;

/* #3-USECASE: COMPARE-TO-AVG
Helps to evaluate whether a value is above or below the avg */


-- TASK-3 : FInd all orders where sales are higher than the ag sales across all Orders 

SELECT *
FROM (
SELECT 
	OrderId,
	Sales,
	ProductID,
	AVG(Sales) OVER () avgsales
FROM Sales.Orders)t
WHERE sales >avgsales;


/*  MIN() & MAX() */

/* #1-USECASE : OVERALL ANALYSIS */

-- Find the highest and lowest sales of all all orders
-- Additonally Provide Details Such as OrderId ,Orderdate

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() Highest_sales,
	MIN(Sales) OVER() Lowest_sales
FROM sales.Orders;

/* #2-USECASE: TOTAL PER GROUPS
Group-wise Analaysis to understand pattern within diff categories */

-- TASK-2 - Find the highest and lowest sales of all all orders
-- Find the highest and lowest sales for each Prdocut
-- Additonally Provide Details Such as OrderId ,Orderdate

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() Highest_sales,
	MIN(Sales) OVER() Lowest_sales,
	MAX(Sales) OVER(PARTITION BY ProductID) HighestSalesByProduct,
	MIN(Sales) OVER(PARTITION BY ProductID) LowestSalesByProduct
FROM sales.Orders;

--TASK-3 : show the employee who have the highest salary

SELECT  * FROM
(SELECT *,
	MAX(Salary) OVER () AS Highest_salary
FROM sales.Employees)t
WHERE salary = Highest_salary;


/* #3-USECASE: COMPARE-TO-EXTREMES
Helps to evaluate how well a value is performing relatives to extremes */

-- TASK-4 : FInd the deviation of each sales from min and max sales amounts

SELECT
	OrderID,
	OrderDate,
	ProductID,
	MAX(Sales) OVER() Highest_sales,
	MIN(Sales) OVER() Lowest_sales,
	Sales,
	Sales - MIN(Sales) OVER () AS DeviationFromMIn,
	MAX(Sales) OVER() - Sales As DeviationFromMAX
FROM sales.Orders;

/* Moving Average */

-- TASK-1: Calculate moving average of sales for each product over time

SELECT
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(sales) OVER(PARTITION BY ProductID) As AvgByProduct,
	AVG(sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) As MovingAvg
FROM  Sales.Orders;

-- TASK-2: Calculate moving average of sales for each product over time
-- Calculate moving average of sales for each product over time,Including only 
-- the Next order

SELECT
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(sales) OVER(PARTITION BY ProductID) As AvgByProduct,
	AVG(sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) As MovingAvg,
	AVG(sales) OVER(PARTITION BY ProductID ORDER BY OrderDate 
	ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)  As MovingAvg_forNextOrder
FROM  Sales.Orders;
