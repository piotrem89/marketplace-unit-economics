IF OBJECT_ID('dbo.cleaned_retail_sales', 'U') IS NOT NULL
    DROP TABLE dbo.cleaned_retail_sales;


CREATE TABLE dbo.cleaned_retail_sales (
    Transaction_ID   INT,
    Customer_ID      INT,
    Category         NVARCHAR(250),
    Item             NVARCHAR(250),
    Price_Per_Unit   DECIMAL(10,2),
    Quantity         INT,
    Total_Spent      DECIMAL(10,2),
    Payment_Method   NVARCHAR(250),
    Location         NVARCHAR(250),
    Transaction_Date DATE,
    Discount_Applied BIT
);

INSERT INTO dbo.cleaned_retail_sales (
    Transaction_ID,
    Customer_ID,
    Category,
    Item,
    Price_Per_Unit,
    Quantity,
    Total_Spent,
    Payment_Method,
    Location,
    Transaction_Date,
    Discount_Applied
)
SELECT
    TRY_CAST(Transaction_ID AS INT) AS Transaction_ID,
    TRY_CAST(Customer_ID AS INT) AS Customer_ID,
    CASE
        WHEN Category IS NULL OR TRIM(Category) = '' THEN 'Unknown'
        ELSE TRIM(Category) END AS Category,
    CASE
        WHEN Item IS NULL OR TRIM(Item) = '' THEN 'Unknown'
        ELSE TRIM(Item) END AS Item,
    TRY_CAST(Price_Per_Unit AS DECIMAL(10,2)) AS Price_Per_Unit,
    TRY_CAST(TRY_CAST(Quantity AS FLOAT) AS INT) AS Quantity,
    TRY_CAST(Total_Spent AS DECIMAL(10,2)) AS Total_Spent,
    TRIM(Payment_Method) AS Payment_Method,
    TRIM(Location) AS Location,
    TRY_CONVERT(DATE, Transaction_Date, 120) AS Transaction_Date,
    CASE
        WHEN TRIM(Discount_Applied) = 'True' THEN 1
        ELSE 0
    END AS Discount_Applied
FROM dbo.stg_retail_sales
WHERE Price_Per_Unit IS NOT NULL AND TRIM(Price_Per_Unit) != ''
   AND Quantity IS NOT NULL AND TRIM(Quantity) != ''
   AND Total_Spent IS NOT NULL AND TRIM(Total_Spent) != '' ;