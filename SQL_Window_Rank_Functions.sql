					
					/*  Window RANK Functions */
					

/*  ROW_NUMBER() */

-- TASK-1 : Rank the orders based on their sales from highest to lowest

SELECT * FROM Sales.Orders;

SELECT 
	OrderID,
	ProductID,
	sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS Sales_rowNumber
FROM Sales.Orders

/*  RANK() */

-- TASK-2 : Rank the orders based on their sales from highest to lowest

SELECT 
	OrderID,
	ProductID,
	sales,
	RANK() OVER(ORDER BY Sales DESC) AS Sales_Rank
FROM Sales.Orders

/*  DENSE_RANK() */

-- TASK-3 : Rank the orders based on their sales from highest to lowest

SELECT 
	OrderID,
	ProductID,
	sales,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS Sales_DenseRank
FROM Sales.Orders;

/* UseCase -TOP-N-ANALYSIS 
Analysis the top performers to do targeted marketing */

-- TASK-4: Find the top highest sales for each product

SELECT 
* FROM
(SELECT 
	OrderID,
	ProductID,
	sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID 
	ORDER BY Sales DESC) AS rankByProduct
FROM Sales.Orders)t
WHERE rankByProduct =1;

/* UseCase -BOTTOM-N-ANALYSIS 
help Analysis the under performance to manage risks and to do optimizations */

-- TASK-5: Find the Lowest 2 customers based on their sales 

SELECT TOP(2)
	CustomerID,
	SUM(sales) toatalsales ,
	ROW_NUMBER() OVER ( ORDER BY SUM(Sales) DESC) AS Rankcustomers
FROM Sales.Orders
Group By CustomerID;

SELECT TOP(2)
	CustomerID,
	SUM(sales) toatalsales ,
	ROW_NUMBER() OVER ( ORDER BY SUM(Sales) DESC) AS Rankcustomers
FROM Sales.Orders
Group By CustomerID;

-- or

SELECT *
FROM(SELECT 
		CustomerID,
		SUM(sales) toatalsales ,
		ROW_NUMBER() OVER ( ORDER BY SUM(Sales) DESC) AS Rankcustomers
	FROM Sales.Orders
	GROUP BY CustomerID)t
WHERE Rankcustomers <=2;

/* UseCase - ASSIGN UNIQUE IDs 
help to assign unique identifier for each row to help paginating */

-- TASK-6 Assign unique IDs to the rows of the 'OdersArchive' table

SELECT * FROM Sales.OrdersArchive;

SELECT 
	ROW_NUMBER() OVER( ORDER BY OrderID,OrderDate) AS UniqueId,
	*
FROM Sales.OrdersArchive;

/* UseCase - IDENTIFY DUPLICATES 
Identify and remove duplicate rows to improve Data quality */

-- TASK-7 Identify duplicate rows in the table 'Orders Archieve'
-- and return a clean result without any duplicates

SELECT * 
FROM 
(SELECT 
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) Rank_number,
	* 
FROM sales.OrdersArchive)t
WHERE Rank_number=1;

-- Duplicate records and clean them
SELECT * 
FROM 
(SELECT 
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) Rank_number,
	* 
FROM sales.OrdersArchive)t
WHERE Rank_number>1;

/* CUME_DIST() */

SELECT 
	CUME_DIST() OVER(ORDER BY sales DESC) Dist_rank,
	* 
FROM sales.Orders;

SELECT 
	CUME_DIST() OVER(ORDER BY sales DESC) cume_dist_rank,
	* 
FROM sales.OrdersArchive;

/* PERCENT_RANK() */

SELECT 
	ROUND(PERCENT_RANK() OVER(ORDER BY sales DESC),2) AS Percnt_rank,
	* 
FROM sales.Orders;

SELECT 
	PERCENT_RANK() OVER(ORDER BY sales DESC) As without_roundoff,
	ROUND(PERCENT_RANK() OVER(ORDER BY sales DESC),2) AS Percnt_rank,
	* 
FROM sales.OrdersArchive;

-- TASK-8 Find the products that fall within the highest 40% of prices

SELECT 
*,
CONCAT(Dist_rank *100 ,'%') AS DistRankPer
FROM
(SELECT 
	Product,
	Price,
	CUME_DIST() OVER(ORDER BY Price DESC) As Dist_rank
FROM sales.Products)t
WHERE Dist_rank <= 0.4;


/* NTILE(exp) */

SELECT OrderID,
	sales,
	NTILE(1) OVER(ORDER BY sales DESC) As OneBucket,
	NTILE(2) OVER(ORDER BY sales DESC) As TwoBucket,
	NTILE(3) OVER(ORDER BY sales DESC) As ThreeBucket,
	NTILE(4) OVER(ORDER BY sales DESC) As FourBucket,
	NTILE(5) OVER(ORDER BY sales DESC) As FiveBucket
FROM sales.Orders;

/* UseCase - DATA SEGMENTATION
Divides a datset into distinct subsets based on certain creteria */

-- TASK-9 : Segment all orders into 3 categories ie,high,medium and low sales

SELECT *,
	CASE 
		WHEN Buckets = 1 THEN 'High'
		WHEN Buckets = 2 THEN 'Medium'
		ELSE 'Low'
	END AS SalesSegmentation
FROM(
	SELECT 
		OrderID,
		sales,
		NTILE(3) OVER (ORDER BY Sales DESC ) AS Buckets
	FROM Sales.Orders
	)t ;

/* UseCase - EQUALIZING LOAD PROCESSING */

-- in order to export the data ,divde the orders table into 2 groups

SELECT
	NTILE(2) OVER (ORDER BY Sales DESC ) AS Buckets,
	*
FROM Sales.Orders 