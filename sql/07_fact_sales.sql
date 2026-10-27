-- Create and populate the sales fact table with Unit Economics metrics.

IF OBJECT_ID('dbo.fact_sales', 'U') IS NOT NULL
    DROP TABLE dbo.fact_sales ;

CREATE TABLE dbo.fact_sales (
    Fact_Sales_ID           INT IDENTITY(1,1) PRIMARY KEY,
    Transaction_ID          NVARCHAR(50),
    Product_ID              INT REFERENCES dbo.dim_products(Product_ID),
    Channel_Fee_ID          INT REFERENCES dbo.dim_channel_fees(Channel_Fee_ID),
    Date_Key                INT REFERENCES dbo.dim_date(Date_Key),
    Customer_ID             NVARCHAR(50),
    Payment_Method          NVARCHAR(50),
    Quantity                INT,
    Unit_Price              DECIMAL(10,2),
    Gross_Revenue           DECIMAL(10,2),
    Total_COGS              DECIMAL(10,2),
    Commission_Fee_USD      DECIMAL(10,2),
    Fixed_Fee_USD           DECIMAL(10,2),
    Shipping_Fee_USD        DECIMAL(10,2),
    Total_Marketplace_Fees  DECIMAL(10,2),
    Contribution_Margin_USD DECIMAL(10,2),
    Contribution_Margin_Pct DECIMAL(5,4)
) ;

INSERT INTO dbo.fact_sales (
    Transaction_ID,
    Product_ID,
    Channel_Fee_ID,
    Date_Key,
    Customer_ID,
    Payment_Method,
    Quantity,
    Unit_Price,
    Gross_Revenue,
    Total_COGS,               
    Commission_Fee_USD,     
    Fixed_Fee_USD,
    Shipping_Fee_USD,
    Total_Marketplace_Fees,
    Contribution_Margin_USD,
    Contribution_Margin_Pct 
)
SELECT
    s.Transaction_ID,
    p.Product_ID,
    f.Channel_Fee_ID,
    d.Date_Key,
    s.Customer_ID,
    s.Payment_Method,
    s.Quantity,
    s.Price_Per_Unit AS Unit_Price,
    CAST(s.Quantity * s.Price_Per_Unit AS DECIMAL(10,2)) AS Gross_Revenue,
    CAST(s.Quantity * p.COGS AS DECIMAL(10,2)) AS Total_COGS,
    CAST((s.Quantity * s.Price_Per_Unit) * f.Commission_Pct AS DECIMAL(10,2)) AS Commission_Fee_USD,
    f.Fixed_Fee_USD,
    f.Shipping_Fee_USD,
    CAST(((s.Quantity * s.Price_Per_Unit) * f.Commission_Pct) + f.Fixed_Fee_USD + f.Shipping_Fee_USD AS DECIMAL(10,2)) AS Total_Marketplace_Fees,
    CAST((s.Quantity * s.Price_Per_Unit) - (s.Quantity * p.COGS) - (((s.Quantity * s.Price_Per_Unit) * f.Commission_Pct) + f.Fixed_Fee_USD + f.Shipping_Fee_USD) AS DECIMAL(10,2)) AS Contribution_Margin_USD,
    CAST(((s.Quantity * s.Price_Per_Unit) - (s.Quantity * p.COGS) - (((s.Quantity * s.Price_Per_Unit) * f.Commission_Pct) + f.Fixed_Fee_USD + f.Shipping_Fee_USD)) / NULLIF((s.Quantity * s.Price_Per_Unit), 0) AS DECIMAL(5,4)) AS Contribution_Margin_Pct
FROM dbo.cleaned_retail_sales s
JOIN dbo.dim_products p
    ON p.Product_Name = s.Item
   AND p.Category_Name = s.Category
   
-- Map channels: Keep 'In-store' as In-Store.
-- Split 'Online' sales between Allegro, Amazon, and Own Store using CHECKSUM
JOIN dbo.dim_channel_fees f
    ON f.Channel_Name = CASE
           WHEN s.Location = 'In-store' THEN 'In-Store'
           WHEN ABS(CHECKSUM(s.Transaction_ID)) % 3 = 0 THEN 'Allegro'
           WHEN ABS(CHECKSUM(s.Transaction_ID)) % 3 = 1 THEN 'Amazon'
           ELSE 'Own Store'
       END
   AND f.Category_Name = s.Category
JOIN dbo.dim_date d
    ON d.Full_Date = s.Transaction_Date ;
    