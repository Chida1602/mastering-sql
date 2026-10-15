       /* Date Time Functions */

SELECT  
    OrderID,
    OrderDate,
    ShipDate,
    CreationTime
FROM Sales.Orders

-- DAY(), MONTH(), YEAR()

SELECT 
    CreationTime,
    YEAR(CreationTime) AS Year,
    MONTH(creationTime) As month,
    DAY(CreationTime) As day
FROM Sales.Orders;

--DATEPART()

SELECT 
    CreationTime,
    DATEPART(year,CreationTime) AS Year_dp,
    DATEPART(Month,CreationTime) AS Month_dp,
    DATEPART(Day,CreationTime) AS Day_dp,
    DATEPART(Week,CreationTime) AS Week_dp,
    DATEPART(QUARTER,CreationTime) AS quarter_dp,
    DATEPART(hour,CreationTime) AS hour_dp,
    DATEPART(Minute,CreationTime) AS minute_dp,
    DATEPART(SECOND,CreationTime) AS second_dp,
    DATEPART(WEEKDAY,CreationTime) AS weekday_dp
FROM Sales.Orders;

--DATENAME()

SELECT 
    CreationTime,
    DATENAME(Month,CreationTime) AS Month_dn,
    DATENAME(WEEKDAY,CreationTime) AS weekday_dp
FROM Sales.Orders;

--DATETRUNC()

SELECT 
    CreationTime,
    DATETRUNC(year,CreationTime) AS Year_dt,
    DATETRUNC(Month,CreationTime) AS Month_dt,
    DATETRUNC(Day,CreationTime) AS Day_dt,
    DATETRUNC(hour,CreationTime) AS hour_dt,
    DATETRUNC(Minute,CreationTime) AS minute_dt,
    DATETRUNC(SECOND,CreationTime) AS second_dt 
FROM Sales.Orders;

-- TO Caluculate the no. of orders in each month

SELECT 
    DATETRUNC(Month,CreationTime) AS Month_dt,
    COUNT(*)
FROM Sales.Orders
GROUP BY  DATETRUNC(Month,CreationTime);


-- EOMONTH()

SELECT 
    OrderID,
    CreationTime,
    EOMONTH(CreationTime) End_of_month,
    DATETRUNC(Month,CreationTime) AS Start_of_month  
FROM Sales.Orders

--How many orders were placed each month ?

SELECT 
    DATENAME(Month,CreationTime) AS Month_dn,
    COUNT(*) no_of_orders
FROM Sales.Orders
GROUP BY  DATENAME(Month,CreationTime);

--Show all orders that were  placed during the month of feburary

SELECT * 
FROM sales.Orders
WHERE MONTH(OrderDate) = 2;


--FORMAT()

SELECT 
    OrderID,
    CreationTime,
    --day
    FORMAT(CreationTime,'dd') AS day_in_num,  
    FORMAT(CreationTime,'ddd') AS day_in_str,
    FORMAT(CreationTime,'d') AS day_in_Full_str,
    --Month
    FORMAT(CreationTime,'MM') AS Mon_in_num,  
    FORMAT(CreationTime,'MMM') AS mon_in_str,
    FORMAT(CreationTime,'MMMM') AS Mon
FROM Sales.Orders;


SELECT 
    OrderID,
    CreationTime,
    FORMAT(CreationTime,'MM-dd-yyyy') AS US_Format,
    FORMAT(CreationTime,'dd-MM-yyyy') AS Europe_Format
FROM Sales.Orders;

--Show creationTime using the following output format 
-- Day Wed Jan Q1 2025 12:34:56 PM

SELECT 
    OrderID,
    CreationTime,
    'Day ' +
    FORMAT(CreationTime,'ddd MMM') +
    ' Q'+ DATENAME(Quarter,CreationTime) + ' ' +
    FORMAT(CreationTime,'yyyy hh:mm:ss tt')  AS Custom_format 
FROM Sales.Orders;

--CONVERT()

SELECT 
    CONVERT(INT ,'123') AS [String to INT Convert],
    CONVERT(DATE , '2025-10-12')AS [string to date],
    CreationTime,
    CONVERT(TIME , CreationTime)AS [time to date],
    CONVERT(DATE , CreationTime)AS [DateTime to date],
    CONVERT(VARCHAR,CreationTime,32) AS [usa Std. style:32],
    CONVERT(VARCHAR,CreationTime,34) AS [europe Std. style:32]
FROM Sales.Orders

--CAST()

SELECT 
    CAST('123' AS INT) AS [String to Int],
    CAST(123 AS VARCHAR) AS [Int to String],
    CAST('2026-10-12' AS DATE) AS [String to Date],
    CAST('2026-10-12' AS DATETIME2) AS [String to DateTime],
    CreationTime,
    CAST(CreationTime AS DATE) AS [DateTime to Date]
FROM Sales.Orders;

--DATEADD()

SELECT  
    OrderID,
    OrderDate,
    DATEADD(year,2,OrderDate) As Two_years_later,
    DATEADD(month,2,OrderDate) As Two_months_later,
    DATEADD(day,10,OrderDate) AS Ten_days_later,
    DATEADD(year,-2,OrderDate) as Two_years_before,
    DATEADD(month,-2,OrderDate) as Two_years_before,
    DATEADD(day,-12,OrderDate) as Twelve_days_before
FROM Sales.Orders


-- DATEDIFF()

SELECT 
    OrderID,
    OrderDate,
    ShipDate ,
    DATEDIFF(day,Orderdate,Shipdate) AS Diff_in_month
    FROM Sales.Orders

--caluclate the age of employees 

SELECT 
    EmployeeID,
    BirthDate,
    DATEDIFF(year,BirthDate,GETDATE()) AS AGE
FROM Sales.Employees

-- ISDATE()

SELECT 
    ISDATE('2026-10-13'),
    ISDATE(2026-10-13) As dateCheck,
    ISDATE(20-12-2023) as erupe_date,
    ISDATE(2026-10-13) As dateCheck


SELECT 
    --CAST(OrderDate AS DATE) OrderDate,
    OrderDate,
    ISDATE(OrderDate),
    CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
    END NewOrderDate
FROM
(
    SELECT '2025-08-20' AS OrderDate UNION
    SELECT '2025-08-21' UNION
    SELECT '2025-08-23' UNION
    SELECT '2025-08'
)t
-- WHERE ISDATE(OrderDate) = 0


