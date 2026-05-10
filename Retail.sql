USE Retail_DB;

/* 
============================================================================================
Inserting the data into Temp tables so I can modify them and keep the original datasets as backups
============================================================================================
*/
Drop table if exists #stores
Drop table if exists #Customers
Drop table if exists #Products
Drop table if exists #Channels
Drop table if exists #Sales

Select * into #Stores from Stores
Select * into #Customers from Customers
Select * into #Products from Products
Select * into #Channels from Channels
Select * into #Sales from Sales

/* 
============================================================================================
Null check across all tables Before UPDATES
============================================================================================
*/

SELECT
    SUM(CASE WHEN store_id IS NULL THEN 1 ELSE 0 END) AS Null_store_id,
    SUM(CASE WHEN store_name IS NULL THEN 1 ELSE 0 END) AS Null_store_name,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS Null_region,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS Null_city
FROM #stores;

SELECT
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS Null_product_id,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS Null_product_name,
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS Null_category,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS Null_unit_price,
    SUM(CASE WHEN unit_cost IS NULL THEN 1 ELSE 0 END) AS Null_unit_cost
FROM #products;

SELECT
    SUM(CASE WHEN Customer_id IS NULL THEN 1 ELSE 0 END) AS Null_Customer_id,
    SUM(CASE WHEN Customer_name IS NULL THEN 1 ELSE 0 END) AS Null_Customer_name,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS Null_email,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS Null_city,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS Null_country
FROM #customers;

SELECT
    SUM(CASE WHEN Channel_id IS NULL THEN 1 ELSE 0 END) AS Null_Channel_id,
    SUM(CASE WHEN Channel_name IS NULL THEN 1 ELSE 0 END) AS Null_Channel_name
FROM #channels;

SELECT
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS Null_transaction_id,
    SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS Null_transaction_date,
    SUM(CASE WHEN Customer_id IS NULL THEN 1 ELSE 0 END) AS Null_Customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS Null_product_id,
    SUM(CASE WHEN store_id IS NULL THEN 1 ELSE 0 END) AS Null_store_id,
    SUM(CASE WHEN Channel_id IS NULL THEN 1 ELSE 0 END) AS Null_Channel_id,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS Null_quantity,
    SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS Null_discount    
FROM #Sales;

Begin tran
update #customers set email = 'Not Provided' where email is null
commit tran ---- only commit the transaction when you are sure you got the result you needed.

-- Null check across all tables AFTER UPDATES
SELECT
    SUM(CASE WHEN store_id IS NULL THEN 1 ELSE 0 END) AS Null_store_id,
    SUM(CASE WHEN store_name IS NULL THEN 1 ELSE 0 END) AS Null_store_name,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS Null_region,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS Null_city
FROM #stores;

SELECT
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS Null_product_id,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS Null_product_name,
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS Null_category,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS Null_unit_price,
    SUM(CASE WHEN unit_cost IS NULL THEN 1 ELSE 0 END) AS Null_unit_cost
FROM #products;

SELECT
    SUM(CASE WHEN Customer_id IS NULL THEN 1 ELSE 0 END) AS Null_Customer_id,
    SUM(CASE WHEN Customer_name IS NULL THEN 1 ELSE 0 END) AS Null_Customer_name,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS Null_email,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS Null_city,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS Null_country
FROM #customers;

SELECT
    SUM(CASE WHEN Channel_id IS NULL THEN 1 ELSE 0 END) AS Null_Channel_id,
    SUM(CASE WHEN Channel_name IS NULL THEN 1 ELSE 0 END) AS Null_Channel_name
FROM #channels;

SELECT
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS Null_transaction_id,
    SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS Null_transaction_date,
    SUM(CASE WHEN Customer_id IS NULL THEN 1 ELSE 0 END) AS Null_Customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS Null_product_id,
    SUM(CASE WHEN store_id IS NULL THEN 1 ELSE 0 END) AS Null_store_id,
    SUM(CASE WHEN Channel_id IS NULL THEN 1 ELSE 0 END) AS Null_Channel_id,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS Null_quantity,
    SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS Null_discount    
FROM #Sales;

/* 
============================================================================================
DATA CLEANING & TRANSFORMATION
============================================================================================
*/

DROP TABLE IF EXISTS #Cleaned_Sales;
DROP TABLE IF EXISTS #Dirty_Sales;

WITH MasterTable AS (

SELECT
        s.transaction_id
        ,CAST(s.transaction_date AS DATE) AS transaction_date
        ,s.customer_id
        ,c.customer_name 
        ,c.email
        ,c.city as customer_city
        ,c.country as Customer_Country
        ,s.product_id
        ,p.product_name
        ,p.category
        ,p.unit_price
        ,p.unit_cost
        ,s.store_id
        ,st.store_name
        ,st.region
        ,st.city as Store_city
        ,s.channel_id
        ,ch.channel_name
        ,s.quantity
        ,(s.quantity * p.unit_price) as Revenue        --,s.revenue
        ,(s.quantity * p.unit_cost) as total_cost        --,s.total_cost
        ,s.discount
        ,(s.quantity * p.unit_price) * (1-s.discount) as net_sales --,s.net_sales
        ,((s.quantity * p.unit_price) * (1-s.discount)) - (s.quantity * p.unit_cost) as profit--,profit 
        ,ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_date DESC) AS rn
        
    FROM #sales s
    left join #Customers c on c.customer_id = s.customer_id
    left join #Products p on p.product_id = s.product_id
    left join #Channels ch on ch.channel_id = s.channel_id
    left join #Stores st on st.store_id = s.store_id      

)

SELECT * INTO #Dirty_Sales FROM MasterTable ----insert all rows into a temp table
SELECT * INTO #Cleaned_Sales FROM #Dirty_Sales WHERE rn = 1; ----insert cleaned rows into another temp table

Select * from #Cleaned_Sales
/* 
============================================================================================
POST-CLEAN VALIDATION  - Row count comparison
============================================================================================
*/

SELECT 
    (SELECT COUNT(*) FROM #Dirty_Sales) AS Original_Count,
    (SELECT COUNT(*) FROM #Cleaned_Sales) AS Cleaned_Count;

/* 
============================================================================================
CORE KPIs (EXECUTIVE LEVEL)
============================================================================================
*/

SELECT
    COUNT(DISTINCT transaction_id) AS Count_Transactions,
    COUNT(DISTINCT customer_id) AS Count_Customers,
    SUM(quantity) AS Count_units_sold,
    '' as '  ',
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(total_cost), 2) AS Total_Spent, 
    ROUND(SUM(discount), 2) AS Total_Discount,
    ROUND(SUM(net_sales), 2) AS Total_Net_sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    '' as '  ',
    ROUND(SUM(profit) / NULLIF(SUM(net_sales),0), 4) AS Profit_Margin,
    ROUND(1 - (SUM(net_sales) / NULLIF(SUM(revenue),0)), 2) AS Discount_impact_pct, ------ REVIEW DISCOUNT IMPACT
    ROUND(CAST(SUM(quantity) AS DECIMAL(10,2)) / COUNT(DISTINCT transaction_id), 2) AS AVG_units_per_order,
    ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT transaction_id), 0), 2) AS AOV
FROM #Cleaned_Sales;

/* 
============================================================================================
GENERAL MONTHLY PERFORMANCE 
============================================================================================
*/

   WITH Monthly AS (
    SELECT
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS month_start
        ,SUM(revenue) AS revenue
        ,COUNT(DISTINCT transaction_id) AS Count_transactions
        ,COUNT(DISTINCT customer_id) AS customers
        ,ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT transaction_id), 0), 2) AS AOV
    FROM #Cleaned_Sales
    GROUP BY DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1)
),
Growth AS (
    SELECT *,
        LAG(revenue) OVER (ORDER BY month_start) AS prev_revenue,
        LAG(customers) OVER (ORDER BY month_start) AS prev_customers,
        LAG(Count_transactions) OVER (ORDER BY month_start) AS prev_Count_transactions,
        LAG(AOV) OVER (ORDER BY month_start) AS prev_AOV
    FROM Monthly
)
SELECT
    month_start
    ,revenue
    ,prev_revenue
    ,ROUND((revenue - prev_revenue) / NULLIF(prev_revenue,0), 4) AS revenue_growth_pct
    ,Count_transactions
    ,prev_Count_transactions
    ,ROUND((cast(Count_transactions as decimal(10,2)) - prev_Count_transactions) / NULLIF(prev_Count_transactions,0), 4) AS transactions_growth_pct
    ,Customers
    ,prev_Customers
    ,ROUND((cast(Customers as decimal(10,2)) - prev_Customers) / NULLIF(prev_Customers,0), 4) AS Customers_growth_pct
    ,AOV
    ,prev_AOV
    ,ROUND((AOV - prev_AOV) / NULLIF(prev_AOV,0), 4) AS AOV_growth_pct
FROM Growth
ORDER BY month_start;



/* 
============================================================================================
CHannel Performance: Revenue, count_transactions and AOV
============================================================================================
*/

SELECT
    c.channel_id,
    c.channel_name,
    SUM(revenue) AS revenue,
    COUNT(DISTINCT transaction_id) AS count_transactions,
    ROUND(SUM(revenue) / COUNT(DISTINCT transaction_id), 2) AS revenue_per_order
FROM #Cleaned_Sales c
GROUP BY c.channel_id, c.channel_name
ORDER BY revenue DESC;


/* 
============================================================================================
MONTHLY CHANNELPERFORMANCE 
============================================================================================
*/

   WITH Monthly AS (
    SELECT
        Channel_id,
        Channel_name,
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS month_start
        ,SUM(revenue) AS revenue
        ,COUNT(DISTINCT transaction_id) AS Count_transactions
        ,COUNT(DISTINCT customer_id) AS customers
        ,ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT transaction_id), 0), 2) AS AOV
    FROM #Cleaned_Sales
    GROUP BY DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1),
      Channel_id,
        Channel_name
),
Growth AS (
    SELECT *,
        LAG(revenue) OVER (ORDER BY month_start) AS prev_revenue,
        LAG(customers) OVER (ORDER BY month_start) AS prev_customers,
        LAG(Count_transactions) OVER (ORDER BY month_start) AS prev_Count_transactions,
        LAG(AOV) OVER (ORDER BY month_start) AS prev_AOV
    FROM Monthly
)
SELECT
    channel_name
    ,month_start
    ,revenue
    ,prev_revenue
    ,ROUND((revenue - prev_revenue) / NULLIF(prev_revenue,0), 4) AS revenue_growth_pct
    ,Count_transactions
    ,prev_Count_transactions
    ,ROUND((cast(Count_transactions as decimal(10,2)) - prev_Count_transactions) / NULLIF(prev_Count_transactions,0), 4) AS transactions_growth_pct
    ,Customers
    ,prev_Customers
    ,ROUND((cast(Customers as decimal(10,2)) - prev_Customers) / NULLIF(prev_Customers,0), 4) AS Customers_growth_pct
    ,AOV
    ,prev_AOV
    ,ROUND((AOV - prev_AOV) / NULLIF(prev_AOV,0), 4) AS AOV_growth_pct
FROM Growth
ORDER BY month_start;


/* 
============================================================================================
Customer Lifeteime_revenue ---- Customer Frequency (Repeat Behavior)
============================================================================================
*/

SELECT
    c.customer_id,
    COUNT(DISTINCT transaction_id) AS count_orders,
    SUM(c.revenue) AS Lifeteime_revenue    
FROM #Cleaned_Sales c
GROUP BY c.customer_id
ORDER BY Lifeteime_revenue desc


/* 
============================================================================================
Discount by bucket
============================================================================================
*/

SELECT
    CASE 
        WHEN c.discount = 0 OR discount IS NULl THEN 'No Discount'
        WHEN c.discount > 0 AND c.discount <= 0.03 THEN 'Low Discount'
        WHEN c.discount > 0.03 AND c.discount <= 0.07 THEN 'Medium Discount'
        WHEN c.discount > 0.07 AND c.discount <= 0.11 THEN 'High Discount'
        ELSE 'Premium Discount'
    END AS discount_bucket,

    COUNT(DISTINCT transaction_id) AS count_transactions,
    SUM(revenue) AS Bucket_revenue,
    ROUND(SUM(revenue)/COUNT(DISTINCT transaction_id),2) AS AOV

FROM #Cleaned_Sales c
GROUP BY 
    CASE 
        WHEN c.discount = 0 OR discount IS NULl THEN 'No Discount'
        WHEN c.discount > 0 AND c.discount <= 0.03 THEN 'Low Discount'
        WHEN c.discount > 0.03 AND c.discount <= 0.07 THEN 'Medium Discount'
        WHEN c.discount > 0.07 AND c.discount <= 0.11 THEN 'High Discount'
        ELSE 'Premium Discount'
    END
ORDER BY Bucket_revenue DESC;

/* 
============================================================================================
HIGH-VALUE CUSTOMER IDENTIFICATION
============================================================================================
*/


SELECT TOP 10
    customer_id,
    SUM(revenue) AS total_spent,
    COUNT(DISTINCT transaction_id) AS transactions,
    ROUND(SUM(revenue)/COUNT(DISTINCT transaction_id),2) AS avg_order_value
FROM #Cleaned_Sales
GROUP BY customer_id
ORDER BY total_spent DESC;
