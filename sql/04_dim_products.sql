IF OBJECT_ID('dbo.dim_products', 'U') IS NOT NULL
    DROP TABLE dbo.dim_products;

CREATE TABLE dbo.dim_products (
    Product_ID      INT IDENTITY(1,1) PRIMARY KEY,
    Product_Name    NVARCHAR(250),
    Category_Name   NVARCHAR(250),
    Base_Price      DECIMAL(10,2),
    COGS            DECIMAL(10,2)
);

INSERT INTO dbo.dim_products (
    Product_Name,
    Category_Name,
    Base_Price,
    COGS
)
SELECT
    Item AS Product_Name,
    Category AS Category_Name,
    ROUND(AVG(Price_Per_Unit), 2) AS Base_Price,
    ROUND(CASE
        WHEN Category = 'Computers and electric accessories' THEN AVG(Price_Per_Unit) * 0.80
        WHEN Category = 'Electric household essentials' THEN AVG(Price_Per_Unit) * 0.75
        WHEN Category = 'Milk Products' THEN AVG(Price_Per_Unit) * 0.72
        WHEN Category = 'Food' THEN AVG(Price_Per_Unit) * 0.68
        WHEN Category = 'Butchers' THEN AVG(Price_Per_Unit) * 0.62
        WHEN Category = 'Furniture' THEN AVG(Price_Per_Unit) * 0.48
        WHEN Category = 'Beverages' THEN AVG(Price_Per_Unit) * 0.42
        WHEN Category = 'Patisserie' THEN AVG(Price_Per_Unit) * 0.38
        ELSE AVG(Price_Per_Unit) * 0.50
    END, 2) AS COGS
FROM dbo.cleaned_retail_sales
GROUP BY Item, Category ;
