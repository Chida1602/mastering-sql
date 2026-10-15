    /* CASE WHEN Statements */

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
