IF OBJECT_ID('dbo.stg_retail_sales', 'U') IS NOT NULL
    DROP TABLE dbo.stg_retail_sales;


CREATE TABLE dbo.stg_retail_sales (
    Transaction_ID   NVARCHAR(250),
    Customer_ID      NVARCHAR(250),
    Category         NVARCHAR(250),
    Item             NVARCHAR(250),
    Price_Per_Unit   NVARCHAR(250),
    Quantity         NVARCHAR(250),
    Total_Spent      NVARCHAR(250),
    Payment_Method   NVARCHAR(250),
    Location         NVARCHAR(250),
    Transaction_Date NVARCHAR(250),
    Discount_Applied NVARCHAR(250)
);
