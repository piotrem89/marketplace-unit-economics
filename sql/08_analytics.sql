-- 1. Overall Business Unit Economics
SELECT
	COUNT(Transaction_ID) AS total_transactions,
	SUM(Quantity) AS total_unit_sold,
	SUM(Gross_Revenue) AS gross_revenue,
	SUM(Total_COGS) AS total_cogs,
	SUM(Total_Marketplace_Fees) AS total_marketplace_fees,
	SUM(Contribution_Margin_USD) AS net_contribution_margin,
	ROUND((SUM(Contribution_Margin_USD) / NULLIF(SUM(Gross_Revenue),0)) * 100, 2) AS weighted_margin_pct
FROM dbo.fact_sales ;


-- 2. Profitability by Channel (Allegro vs Amazon vs Own Store vs In-Store)
SELECT
	f.Channel_Name,
	f.Channel_Type,
	COUNT(s.Transaction_ID) AS total_transactions,
	SUM(s.Gross_Revenue) AS gross_revenue,
	SUM(s.Total_COGS) AS total_cogs,
	SUM(s.Total_Marketplace_Fees) AS total_marketplace_fees,
	SUM(s.Contribution_Margin_USD) AS net_contribution_margin,
	ROUND((SUM(s.Contribution_Margin_USD) / NULLIF(SUM(s.Gross_Revenue), 0)) * 100, 2) AS weighted_margin_pct
FROM dbo.fact_sales s
JOIN dbo.dim_channel_fees f ON f.Channel_Fee_ID = s.Channel_Fee_ID
GROUP BY f.Channel_Name, f.Channel_Type
ORDER BY net_contribution_margin DESC ;


-- 3. Loss-Making Zombie Products on Marketplaces
SELECT
	p.Product_Name,
	p.Category_Name,
	f.Channel_Name,
	SUM(s.Quantity) AS total_units_sold,
	SUM(s.Gross_Revenue) AS gross_revenue,
	SUM(s.Total_Marketplace_Fees) AS total_marketplace_fees,
	SUM(s.Contribution_Margin_USD) AS net_contribution_margin,
	ROUND((SUM(s.Contribution_Margin_USD) / NULLIF(SUM(s.Gross_Revenue),0)) * 100 ,2) AS weighted_margin_pct
FROM dbo.fact_sales s
JOIN dbo.dim_products p ON p.Product_ID = s.Product_ID
JOIN dbo.dim_channel_fees f ON f.Channel_Fee_ID = s.Channel_Fee_ID
WHERE f.Channel_Type = 'Marketplace'
GROUP BY p.Product_Name, p.Category_Name, f.Channel_Name
HAVING SUM(s.Contribution_Margin_USD) < 0
ORDER BY net_contribution_margin ;


-- 4. Margin Leakage by Category & Marketplace
SELECT
	p.Category_Name AS category_name,
	f.Channel_Name AS channel_name,
	SUM(s.Gross_Revenue) AS gross_revenue,
	SUM(s.Total_COGS) AS total_cogs,
	SUM(s.Total_Marketplace_Fees) AS total_marketplace_fees,
	SUM(s.Contribution_Margin_USD) AS net_contribution_margin,
	ROUND((SUM(s.Total_Marketplace_Fees) / NULLIF(SUM(s.Gross_Revenue), 0)) * 100, 2) AS fee_share_pct
FROM dbo.fact_sales s
JOIN dbo.dim_products p ON p.Product_ID = s.Product_ID
JOIN dbo.dim_channel_fees f ON f.Channel_Fee_ID = s.Channel_Fee_ID
WHERE f.Channel_Type = 'Marketplace'
GROUP BY p.Category_Name, f.Channel_Name
ORDER BY fee_share_pct DESC ;


-- 5. Payment Method Unit Economics
SELECT
	s.Payment_Method AS payment_method,
	COUNT(s.Transaction_ID) AS total_transactions,
	SUM(s.Gross_Revenue ) AS gross_revenue,
	SUM(s.Contribution_Margin_USD) AS net_contribution_margin,
	ROUND((SUM(s.Contribution_Margin_USD) / NULLIF(SUM(s.Gross_Revenue),0)) * 100, 2) AS weighted_margin_pct
FROM dbo.fact_sales s
GROUP BY s.Payment_Method
ORDER BY net_contribution_margin DESC ;


-- 6. Monthly Sales & Contribution Margin Trend
SELECT
	d.Year AS year,
	d.Month AS month,
	d.Month_Name AS month_name,
	COUNT(s.Transaction_ID) AS total_transactions,
	SUM(s.Gross_Revenue) AS gross_revenue,
	SUM(s.Total_COGS) AS total_cogs,
	SUM(s.Total_Marketplace_Fees) AS total_marketplace_fees,
	SUM(s.Contribution_Margin_USD) AS net_contribution_margin,
	ROUND((SUM(s.Contribution_Margin_USD) / NULLIF(SUM(s.Gross_Revenue),0)) * 100, 2) AS weighted_margin_pct
FROM dbo.fact_sales s
JOIN dbo.dim_date d ON d.Date_Key = s.Date_Key
GROUP BY d.Year, d.Month, d.Month_Name
ORDER BY d.Year, d.Month ;
