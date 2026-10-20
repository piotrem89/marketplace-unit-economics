-- 1. Key Performance Indicators (KPIs)
SELECT
	SUM(Total_spent) AS total_revenue,
	COUNT(Transaction_ID) AS total_transactions,
	SUM(Quantity) AS total_unit_sold,
	ROUND(AVG(Total_Spent), 2) AS avg_transaction_value
FROM dbo.cleaned_retail_sales ;

-- 2. Revenue and Volume by Category
SELECT
	Category AS category_name,
	SUM(Total_spent) AS total_revenue,
	SUM(Quantity) AS total_unit_sold
FROM dbo.cleaned_retail_sales
GROUP BY Category
ORDER BY total_revenue DESC ;

-- 3. Top 5 Products by Revenue
SELECT TOP 5
	Item AS product_name,
	Category AS category_name,
	SUM(Total_spent) AS total_revenue,
	SUM(Quantity) AS total_unit_sold
FROM dbo.cleaned_retail_sales
GROUP BY Item, Category
ORDER BY total_revenue DESC ;

-- 4. Monthly Sales Trend
SELECT
	YEAR(Transaction_Date) AS year,
	MONTH(Transaction_Date) AS month,
	COUNT(Transaction_ID) AS total_transactions,
	SUM(Total_spent) AS total_revenue
FROM dbo.cleaned_retail_sales
GROUP BY YEAR(Transaction_Date), MONTH(Transaction_Date)
ORDER BY year, month ;

-- 5. Discount Impact Analysis
SELECT
	CASE WHEN Discount_Applied = 1 THEN 'YES' ELSE 'NO' END AS discount_applied,
	COUNT(Transaction_ID) AS total_transactions,
	SUM(Total_spent) AS total_revenue,
	ROUND(AVG(Total_spent), 2) AS avg_transaction_value
FROM dbo.cleaned_retail_sales
GROUP BY Discount_Applied ;

-- 6. Payment Method Breakdown
SELECT
	Payment_Method AS payment_method,
	COUNT(Transaction_ID) AS total_transactions,
	SUM(Total_spent) AS total_revenue,
	ROUND(AVG(Total_spent), 2) AS avg_transaction_value
FROM dbo.cleaned_retail_sales
GROUP BY Payment_Method
ORDER BY total_transactions DESC ;

