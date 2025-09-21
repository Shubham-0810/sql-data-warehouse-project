-- ==========================================================
-- Script: load_silver.sql
-- Purpose: ETL transformations to populate SILVER tables
--          from BRONZE layer sources.
--          This script performs data cleansing, standardization,
--          enrichment, and ensures referential consistency.
-- Notes:  Each section truncates the SILVER table before insert
--         to maintain a fresh and deduplicated dataset.
-- ==========================================================

-- =============================================
-- crm_cust_info
-- =============================================
TRUNCATE TABLE silver.crm_cust_info;
INSERT INTO silver.crm_cust_info (
	cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date)
SELECT cst_id,
		cst_key,
        TRIM(cst_firstname),
        TRIM(cst_lastname),
        CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			 WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
             ELSE 'n/a'
		END cst_marital_status,
        CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			 WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
             ELSE 'n/a'
		END cst_gndr,
        cst_create_date
        FROM (
			SELECT *, 
					ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
			FROM bronze.crm_cust_info
            WHERE cst_id is not NULL) t
WHERE flag_last = 1;


-- =============================================
-- crm_prd_info
-- =============================================
TRUNCATE TABLE silver.crm_prd_info;
INSERT INTO silver.crm_prd_info(
	prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT  prd_id,
        REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') as cat_id,
        SUBSTRING(prd_key, 7, length(prd_key)) as prd_key,
        prd_nm,
        IFNULL(prd_cost, 0) as prd_cost,
        CASE UPPER(TRIM(prd_line))
			WHEN 'M' THEN 'Mountain'
			WHEN 'R' THEN 'Road'
			WHEN 'S' THEN 'Other Sales'
			WHEN 'T' THEN 'Touring'
			ELSE 'n/a'
		END as prd_line,
        CAST(prd_start_dt as date) as prd_start_dt,
        CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) as date) as prd_end_dt
FROM bronze.crm_prd_info;


-- =============================================
-- crm_sales_details
-- =============================================
TRUNCATE TABLE silver.crm_sales_details;
INSERT INTO silver.crm_sales_details (
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR length(sls_order_dt) != 8 THEN null
	 ELSE CAST(CAST(sls_order_dt as char) as date)
END as sls_order_dt,
CASE WHEN sls_ship_dt = 0 OR length(sls_ship_dt) != 8 THEN null
	 ELSE CAST(CAST(sls_ship_dt as char) as date)
END as sls_ship_dt,
CASE WHEN sls_due_dt = 0 OR length(sls_due_dt) != 8 THEN null
	 ELSE CAST(CAST(sls_due_dt as char) as date)
END as sls_due_dt,
CASE WHEN sls_sales is NULL or sls_sales <= 0 or sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * abs(sls_price)
	ELSE sls_sales
END as sls_sales,
sls_quantity,
CASE WHEN sls_price is NULL or sls_price <= 0
	THEN  sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END as sls_price
from bronze.crm_sales_details;


-- =============================================
-- erp_cust_az12
-- =============================================
TRUNCATE TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12(
cid,
bdate,
gen
)
SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, length(cid))
	 ELSE cid
END as cid,
CASE WHEN bdate > current_date() THEN NULL
	 ELSE bdate
END as bdate,
CASE WHEN UPPER(TRIM(gen)) In ('F', 'FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) In ('M', 'MALE') THEN 'Male'
     ELSE 'n/a'
END as gen
FROM bronze.erp_cust_az12;



-- =============================================
-- erp_loc_a101
-- =============================================
TRUNCATE TABLE silver.erp_loc_a101;
INSERT INTO silver.erp_loc_a101 (
cid,
cntry
)
SELECT
REPLACE(cid, '-', '') as cid,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
     WHEN TRIM(cntry) = '' or cntry is NULL THEN 'n/a'
     ELSE TRIM(cntry)
END as cntry
FROM bronze.erp_loc_a101;



-- =============================================
-- erp_px_cat_g1v2
-- =============================================
TRUNCATE TABLE silver.erp_px_cat_g1v2;
INSERT INTO silver.erp_px_cat_g1v2(
id,
cat,
subcat,
maintenance
)
SELECT 
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2;



