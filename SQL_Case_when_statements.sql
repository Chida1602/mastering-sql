    /* CASE WHEN Statements */

-- Use case -1 : Categorizing Data

 /* Genrate a report showing the total sales for each category
high (sales over 50), medium (sales 21-50), and low (sales 20 or less)
sort the categories from the heighest sales to lowest */

SELECT 
    OrderID,
    Sales,
    CASE 
        WHEN Sales > 50 THEN 'High'
        WHEN Sales > 20 THEN 'Medium'
        ELSE 'Low'
    END AS category
FROM sales.Orders;

-- using subquery 

SELECT 
    Category,
    SUM(Sales) AS TotalSales
FROM(
SELECT 
    OrderID,
    Sales,
    CASE 
        WHEN Sales > 50 THEN 'High'
        WHEN Sales > 20 THEN 'Medium'
        ELSE 'Low'
    END AS category
FROM sales.Orders)e
GROUP BY category 
ORDER BY TotalSales DESC

-- UseCase-2 : Mapping Values 

--Retrieve employee details with gender displayed as full text

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Gender,
    CASE 
        WHEN Gender= 'M' THEN 'Male'
        WHEN Gender= 'f' THEN 'Female'
        ELSE 'Not Available'
    END AS Gender_FullText
FROM Sales.Employees

--Retrieve customer details with abbreviated country code

SELECT DISTINCT Country
FROM Sales.Customers; -- this will retrive the distinct country names

SELECT 
    CustomerID,
    Firstname,
    Country,
    CASE 
        WHEN Country= 'Germany' THEN 'DE'
        WHEN Country= 'USA' THEN 'US'
        ELSE 'N/A'
    END AS Country_abbr
FROM sales.Customers

SELECT 
    CustomerID,
    Firstname,
    Country,
    CASE Country
        WHEN 'Germany' THEN 'DE'
        WHEN  'USA' THEN 'US'
        ELSE 'N/A'
    END AS Country_abbr
FROM sales.Customers

-- UseCase-3 : Handling Null 

/* Find the Average scores of customers and treat NULLs As 0
Additionally provide details such as customerID and lastName */

SELECT 
    CustomerID,
    LastName,
    Score,
    AVG(score) OVER() Avg_customer,
    CASE 
        WHEN Score IS NULL THEN 0
        ELSE Score
    END AS Score_clean,
    AVG(CASE 
            WHEN Score IS NULL THEN 0
            ELSE Score
        END) OVER() AS avg_clean
FROM Sales.Customers


-- UseCase-4 : Conditional Aggregation

-- Count how many times each customer has made an order with sales > 30 

-- step-1:
SELECT 
    OrderID,
    CustomerID,
    Sales,
    CASE 
        WHEN Sales > 30 THEN 1
        ELSE 0
    END AS sales_flag
FROM Sales.Orders
ORDER BY CustomerID

-- step-2:
SELECT 
    CustomerID,
    SUM(CASE 
            WHEN Sales > 30 THEN 1
            ELSE 0
        END) AS Total_highorders,
    COUNT (*) AS Total_orders
FROM Sales.Orders
GROUP BY CustomerID