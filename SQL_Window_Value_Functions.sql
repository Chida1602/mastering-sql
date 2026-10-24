				/*  Window VALUE Functions */

/* LAG() AND LEAD  */

SELECT *,
	LAG(sales,2 ,0) OVER(ORDER BY OrderDate DESC),
	LEAD(sales,2 ,0) OVER(ORDER BY OrderDate DESC)
FROM
sales.Orders

/* TASK 1:
   Analyze the Month-over-Month Performance by Finding the Percentage Change in Sales
   Between the Current and Previous Months
*/
SELECT *,
CurrMonthSales - prevmonth As MOM_change,
Round(CAST((CurrMonthSales - prevmonth) AS float) /prevmonth *100,1) AS perc
FROM(SELECT 
	MONTH(OrderDate) AS OrderMonth,
	SUM(sales) AS currMonthSales,
	LAG(SUM(sales)) OVER(ORDER BY MONTH(OrderDate)) AS prevmonth
FROM Sales.Orders
GROUP BY MONTH(OrderDate)
)t;

/* TASK 2:
   Customer Loyalty Analysis - Rank Customers Based on the Average Days Between Their Orders
*/
SELECT
    CustomerID,
    AVG(DaysUntilNextOrder) AS AvgDays,
    RANK() OVER (ORDER BY COALESCE(AVG(DaysUntilNextOrder), 999999)) AS RankAvg
FROM (
    SELECT
        OrderID,
        CustomerID,
        OrderDate AS CurrentOrder,
        LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
        DATEDIFF(
            day,
            OrderDate,
            LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)
        ) AS DaysUntilNextOrder
    FROM Sales.Orders
) AS CustomerOrdersWithNext
GROUP BY CustomerID;

/* TASK 3:
   Time Gap Analysis - Find the average shipping Duration in days for each month 
*/

SELECT 
    MONTH(OrderDate) As OrderDate,
    Avg(DATEDIFF(day,OrderDate,ShipDate)) AS Duration
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

/* TASK 4:
   Time Gap Analysis - Find the number of days between each order
   and previous order
*/


SELECT 
    OrderID,
    OrderDate AS currOrderdate,
    LAG(OrderDate) OVER(ORDER BY OrderDate) AS previousOrderDate,
    DATEDIFF(day,LAG(OrderDate) OVER(ORDER BY OrderDate),OrderDate) AS duration
FROM Sales.Orders

/* FIRST_VALUE & LAST_VALUE */

SELECT *,
    FIRST_VALUE(Sales) OVER(ORDER BY CustomerID 
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) Asfir_value
FROM Sales.Orders

SELECT sales,
    FIRST_VALUE(Sales) OVER(ORDER BY CustomerID ) AS Default_value
FROM Sales.Orders

SELECT sales,
    LAST_VALUE(Sales) OVER(ORDER BY CustomerID 
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) Asfir_value
FROM Sales.Orders


/* TASK 5:
   Find the Lowest and Highest Sales for Each Product,
   and determine the difference between the current Sales and the lowest Sales for each Product.
*/

SELECT OrderID,
    ProductID,
    sales,
    FIRST_VALUE(sales) OVER(PARTITION BY ProductID ORDER BY sales) AS Lowestsales1,
    MIN(sales) OVER(PARTITION BY ProductID ORDER BY sales) AS Lowest_sales2,
    LAST_VALUE(sales) OVER(PARTITION BY ProductID ORDER BY sales 
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS highestSales1,
    FIRST_VALUE(sales) OVER(PARTITION BY ProductID ORDER BY sales DESC) AS highest_sales2,
    MAX(sales) OVER(PARTITION BY ProductID ORDER BY sales) AS Highest_sales3,
    Sales- MIN(sales) OVER(PARTITION BY ProductID ORDER BY sales)  AS diff
FROM Sales.Orders;
