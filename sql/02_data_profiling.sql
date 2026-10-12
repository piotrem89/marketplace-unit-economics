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
FROM dbo.stg_retail_sales ;


-- Check for duplicate transaction IDs
SELECT
Transaction_ID,
COUNT(Transaction_id) AS duplicate_count
FROM stg_retail_sales
GROUP BY Transaction_id
HAVING COUNT(Transaction_id) > 1 ;

