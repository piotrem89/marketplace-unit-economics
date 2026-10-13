-- Check total row count and missing values (NULL or empty string)
SELECT
	COUNT(*) AS total_rows,
	SUM(CASE WHEN Transaction_ID IS NULL OR TRIM(Transaction_ID) = '' THEN 1 ELSE 0 END) AS missing_transaction_id,
    SUM(CASE WHEN Customer_ID IS NULL OR TRIM(Customer_ID) = '' THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN Category IS NULL OR TRIM(Category) = '' THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN Item IS NULL OR TRIM(Item) = '' THEN 1 ELSE 0 END) AS missing_item,
    SUM(CASE WHEN Price_Per_Unit IS NULL OR TRIM(Price_Per_Unit) = '' THEN 1 ELSE 0 END) AS missing_price_per_unit,
    SUM(CASE WHEN Quantity IS NULL OR TRIM(Quantity) = '' THEN 1 ELSE 0 END) AS missing_quantity,
    SUM(CASE WHEN Total_Spent IS NULL OR TRIM(Total_Spent) = '' THEN 1 ELSE 0 END) AS missing_total_spent,
    SUM(CASE WHEN Payment_Method IS NULL OR TRIM(Payment_Method) = '' THEN 1 ELSE 0 END) AS missing_payment_method,
    SUM(CASE WHEN Location IS NULL OR TRIM(Location) = '' THEN 1 ELSE 0 END) AS missing_location,
    SUM(CASE WHEN Transaction_Date IS NULL OR TRIM(Transaction_Date) = '' THEN 1 ELSE 0 END) AS missing_transaction_date,
    SUM(CASE WHEN Discount_Applied IS NULL OR TRIM(Discount_Applied) = '' THEN 1 ELSE 0 END) AS missing_discount_applied
FROM stg_retail_sales ;


-- Check for duplicate transaction IDs
SELECT
Transaction_ID,
COUNT(Transaction_id) AS duplicate_count
FROM stg_retail_sales
GROUP BY Transaction_id
HAVING COUNT(Transaction_id) > 1 ;


-- Check invalid data formats
SELECT
SUM(CASE WHEN TRIM(Quantity) != '' AND Quantity IS NOT NULL AND TRY_CAST(Quantity AS FLOAT) IS NULL THEN 1 ELSE 0 END) AS invalid_quantity,
SUM(CASE WHEN TRIM(Price_Per_Unit) != '' AND Price_Per_Unit IS NOT NULL AND TRY_CAST(Price_Per_Unit AS DECIMAL(10,2)) IS NULL THEN 1 ELSE 0 END) AS invalid_price_per_unit,
SUM(CASE WHEN TRIM(Total_Spent) != '' AND Total_Spent IS NOT NULL AND TRY_CAST(Total_Spent AS DECIMAL(10,2)) IS NULL THEN 1 ELSE 0 END) AS invalid_total_Spent,
SUM(CASE WHEN TRIM(Transaction_Date) != '' AND Transaction_Date IS NOT NULL AND TRY_CONVERT(DATE, Transaction_Date, 120) IS NULL THEN 1 ELSE 0 END) AS invalid_transaction_Date
FROM stg_retail_sales
