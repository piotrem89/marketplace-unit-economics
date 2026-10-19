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
TRY_CAST(Transaction_ID AS INT),
TRY_CAST(Customer_ID AS INT),
TRIM(Category) AS Category,
TRIM(Item) AS ITEM,
TRY_CAST(Price_Per_Unit AS DECIMAL(10,2)),
TRY_CAST(TRY_CAST(Quantity AS FLOAT) AS INT),
TRY_CAST(Total_Spent AS DECIMAL(10,2)),
TRIM(Payment_Method) AS Payment_Method,
TRIM(Location) AS Location,
TRY_CONVERT(DATE, Transaction_Date, 120),
TRY_CAST(Discount_Applied AS BIT)
FROM dbo.stg_retail_sales ;
