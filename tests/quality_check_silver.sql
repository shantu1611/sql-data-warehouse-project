/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results

select * from silver.crm_cust_info;
-- Checking 'silver.crm_cust_info'
--To check if there are no duplicates or null in primary_key
select cst_id,count(*)
from silver.crm_cust_info 
group by cst_id 
having count(*)>1 or cst_id is null;

--check for unwanted spaces
select cst_key,
cst_firstname,
cst_lastname
from silver.crm_cust_info
where cst_key != trim(cst_key) or
cst_firstname != trim(cst_firstname) or 
cst_lastname != trim(cst_lastname);

-- Data Standardization & Consistency
select distinct cst_marital_status from 
silver.crm_cust_info;

select distinct cst_gndr from 
silver.crm_cust_info;

select * from silver.crm_prd_info
-- Checking 'silver.crm_prd_info'

--To check if there are no duplicates or null in primary_key
select prd_id,count(*)
from silver.crm_prd_info 
group by prd_id 
having count(*)>1 or prd_id is null;

-- Check for Unwanted Spaces
SELECT 
    prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLs or Negative Values in Cost
SELECT 
    prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT 
    prd_line 
FROM silver.crm_prd_info;

-- Check for Invalid Date Orders (Start Date > End Date)
SELECT 
    * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- Checking 'silver.crm_sales_details'
select * from silver.crm_sales_details;
-- Check for Invalid Dates

SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)

SELECT 
    * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Check Data Consistency: Sales = Quantity * Price

SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;


-- Checking 'silver.erp_cust_az12'

select * from silver.erp_cust_az12;

--check data consistency
select distinct gen from silver.erp_cust_az12;

-- Identify Out-of-Range Dates
-- Expectation: Birthdates between 1926-01-01 and Today
SELECT DISTINCT 
    bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1926-01-01' 
   OR bdate > GETDATE();

-- Checking 'silver.erp_loc_a101'
select * from silver.erp_loc_a101

-- Data Standardization & Consistency
SELECT DISTINCT 
    cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;

-- Checking 'silver.erp_px_cat_g1v2'
select * from silver.erp_px_cat_g1v2

-- Check for Unwanted Spaces

SELECT 
    * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT 
    maintenance 
FROM silver.erp_px_cat_g1v2;