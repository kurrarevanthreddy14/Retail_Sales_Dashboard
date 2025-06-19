USE retail_dashboard;
SHOW TABLES;
SELECT COUNT(*) FROM retail_sales;
SELECT * FROM retail_sales LIMIT 5;
-- Total Sales & Total Profit --
SELECT 
    ROUND(SUM(Total_Cost), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales;
-- Monthly Sales Trend --
SELECT 
    DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
    ROUND(SUM(Total_Cost), 2) AS Monthly_Sales,
    ROUND(SUM(Profit), 2) AS Monthly_Profit
FROM retail_sales
GROUP BY Month
ORDER BY Month;

-- Sales by Category --
SELECT Category, SUM(Total_Cost) AS Category_Sales
FROM retail_sales
GROUP BY Category
ORDER BY Category_Sales DESC;
-- Category-wise Top Products --
SELECT 
    Category,
    Item AS Product_Name,
    SUM(Quantity) AS Units_Sold,
    ROUND(SUM(Total_Cost), 2) AS Revenue
FROM retail_sales
GROUP BY Category, Product_Name
ORDER BY Revenue DESC;

-- Location-based Performance --
SELECT 
    Location,
    ROUND(SUM(Total_Cost), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(*) AS Transaction_Count
FROM retail_sales
GROUP BY Location
ORDER BY Total_Sales DESC;

-- Payment Method Insights --
SELECT 
    Payment_method,
    ROUND(SUM(Total_Cost), 2) AS Sales,
    COUNT(*) AS Transaction_Count
FROM retail_sales
GROUP BY Payment_method
ORDER BY Sales DESC;

-- Top 10 Selling Products --
SELECT 
    Item AS Product_Name,
    SUM(Quantity) AS Units_Sold,
    ROUND(SUM(Total_Cost), 2) AS Revenue
FROM retail_sales
GROUP BY Product_Name
ORDER BY Revenue DESC
LIMIT 10;
-- top 3 selling products by revenue within each category--
WITH RankedProducts AS (
    SELECT
        Category,
        Item AS Product_Name,
        ROUND(SUM(Total_Cost), 2) AS Revenue,
        ROW_NUMBER() OVER(PARTITION BY Category ORDER BY SUM(Total_Cost) DESC) as rn
    FROM
        retail_sales
    GROUP BY
        Category, Product_Name
)

SELECT
    Category,
    Product_Name,
    Revenue
FROM
    RankedProducts
WHERE
    rn <= 3;




