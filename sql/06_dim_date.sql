IF OBJECT_ID ('dbo.dim_date', 'U') IS NOT NULL
    DROP TABLE dbo.dim_date ;

CREATE TABLE dbo.dim_date (
    Date_Key        INT PRIMARY KEY,
    Full_Date       DATE,
    Year            INT,
    Quarter         INT,
    Month           INT,
    Month_Name      NVARCHAR(20),
    Day_Of_Week     INT,
    Day_Name        NVARCHAR(20),
    Is_Weekend      BIT
 );

INSERT INTO dbo.dim_date (
    Date_Key,
    Full_Date,
    Year,
    Quarter,
    Month,
    Month_Name,
    Day_Of_Week,
    Day_Name,
    Is_Weekend
)
SELECT
    CAST(CONVERT(NVARCHAR(8), Transaction_Date, 112) AS INT) AS Date_Key,
    Transaction_Date AS Full_Date,
    YEAR(Transaction_Date) AS Year,
    DATEPART(qq,Transaction_Date) AS Quarter,
    MONTH(Transaction_Date) AS Month,
    DATENAME(month, Transaction_Date) AS Month_Name,
    DATEPART(dw, Transaction_Date) AS Day_Of_Week,
    DATENAME(dw, Transaction_Date) AS Day_Name,
    CASE
        WHEN DATENAME(dw, Transaction_Date) IN ('Saturday', 'Sunday') THEN 1
        ELSE 0
    END AS Is_Weekend
FROM dbo.cleaned_retail_sales
GROUP BY Transaction_Date
;
