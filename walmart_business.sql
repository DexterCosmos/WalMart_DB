SELECT * FROM store;

-------------------------------------------------------------------------------------------------------------

-- Top 5 categories with total sales

WITH CategorySales AS (
    SELECT 
        category,
        SUM(total_price) AS total_sales,
        RANK() OVER (ORDER BY SUM(total_price) DESC) AS ranking
    FROM walmart_db
    GROUP BY category
)
SELECT *
FROM CategorySales
WHERE ranking <= 5;


-------------------------------------------------------------------------------------------------------------

-- Revenue Growth by Department

WITH DepartmentRevenue AS (
    SELECT 
        department,
        DATE_FORMAT(rundate, '%Y-%m') AS month,
        SUM(total_price) AS monthly_revenue
    FROM walmart_db
    GROUP BY department, DATE_FORMAT(rundate, '%Y-%m')
)
SELECT 
    department,
    month,
    monthly_revenue,
    RANK() OVER (PARTITION BY month ORDER BY monthly_revenue DESC) AS ranking
FROM DepartmentRevenue;


-------------------------------------------------------------------------------------------------------------

-- Price Trend Analysis

SELECT 
    category,
    AVG(price_retail - price_current) AS avg_discount,
    CASE 
        WHEN AVG(price_retail - price_current) > 5 THEN 'High Discount'
        WHEN AVG(price_retail - price_current) BETWEEN 3 AND 5 THEN 'Medium Discount'
        ELSE 'Low Discount'
    END AS discount_category
FROM walmart_db
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 10000;


-------------------------------------------------------------------------------------------------------------

-- Customer-Friendly Brands

SELECT 
    brand,
    COUNT(CASE WHEN price_retail > price_current THEN 1 ELSE NULL END) AS discount_count
FROM walmart_db
GROUP BY brand
ORDER BY discount_count DESC;


-------------------------------------------------------------------------------------------------------------

-- Shipping Location Performance

WITH LocationPerformance AS (
    SELECT 
        shipping_location,
        SUM(total_price) AS total_sales,
        COUNT(*) AS order_count
    FROM walmart_db
    GROUP BY shipping_location
)
SELECT 
    shipping_location,
    total_sales,
    order_count,
    RANK() OVER (ORDER BY total_sales DESC) AS ranking
FROM LocationPerformance
LIMIT 15;


-------------------------------------------------------------------------------------------------------------

-- Seasonal Insights

SELECT 
    product_name,
    category,
    CASE 
        WHEN MONTH(rundate) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(rundate) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(rundate) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Autumn'
    END AS season,
    SUM(total_price) AS seasonal_sales
FROM walmart_db
GROUP BY product_name, category, season;


-------------------------------------------------------------------------------------------------------------

-- Low Stock Alert

WITH StockStatus AS (
    SELECT 
        sku,
        product_name,
        product_size,
        CASE 
            WHEN product_size < 10 THEN 'Critical'
            WHEN product_size BETWEEN 10 AND 50 THEN 'Low'
            ELSE 'Sufficient'
        END AS stock_status
    FROM walmart_db
)
SELECT *
FROM StockStatus
WHERE stock_status = 'Critical';


-------------------------------------------------------------------------------------------------------------

-- Product Profitability

WITH ProductProfit AS (
    SELECT 
        sku,
        product_name,
        (price_retail - price_current) AS profit_margin
    FROM walmart_db
)
SELECT 
    sku,
    product_name,
    profit_margin
FROM ProductProfit
ORDER BY profit_margin DESC;


-------------------------------------------------------------------------------------------------------------

-- Subcategory Growth

WITH SubcategoryRevenue AS (
    SELECT 
        subcategory,
        DATE_FORMAT(rundate, '%Y-%m') AS month,
        SUM(total_price) AS monthly_revenue
    FROM walmart_db
    GROUP BY subcategory, DATE_FORMAT(rundate, '%Y-%m')
)
SELECT 
    subcategory,
    month,
    monthly_revenue
FROM SubcategoryRevenue;


-------------------------------------------------------------------------------------------------------------

-- Product Popularity by Breadcrumbs

WITH BreadcrumbsAnalysis AS (
    SELECT 
        breadcrumbs,
        SUM(total_price) AS total_sales,
        COUNT(*) AS product_count
    FROM walmart_db
    GROUP BY breadcrumbs
)
SELECT *
FROM BreadcrumbsAnalysis
ORDER BY total_sales DESC;
