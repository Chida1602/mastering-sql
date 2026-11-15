                    

                    /* CTAS (Create Table As Selected) */
       
-- USECASE-01 : Optimize Performance

/* creating a basic CTAS in SQL Server */
SELECT 
    DATENAME(month,OrderDate) As OrderMonth,
    Count(OrderID) TotalOrders
INTO Sales.MonthlyOrders 
FROM sales.Orders
GROUP BY DATENAME(MONTH,OrderDate);

-- Retieve the Data From the Newly Created CTAS 
SELECT * FROM Sales.MonthlyOrders;

-- Delete CTAS 
DROP TABLE Sales.MonthlyOrders;

/* creating a basic CTAS using T-SQL in SQL Server */

IF OBJECT_ID('Sales.MonthlyOrders', 'U') IS NOT NULL
    DROP TABLE Sales.MonthlyOrders;
GO
SELECT 
    DATENAME(month,OrderDate) As OrderMonth,
    Count(OrderID) TotalOrders
INTO Sales.MonthlyOrders 
FROM sales.Orders
GROUP BY DATENAME(MONTH,OrderDate);

-- Retieve the Data From the Newly Created CTAS 
SELECT * FROM Sales.MonthlyOrders;

