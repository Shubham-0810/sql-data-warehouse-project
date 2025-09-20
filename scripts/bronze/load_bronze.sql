/*
========================================================
Script: bronze_load_data.sql
Database: bronze
Purpose: Loads raw data from CSV files into the Bronze layer tables.
         Each table is truncated before loading to refresh the data.

Notes:
- Uses LOAD DATA INFILE to import CSV files.
- Handles null/empty values and converts date/datetime strings.
========================================================
*/

USE bronze;

-- ==============================
-- crm_cust_info
-- ==============================
TRUNCATE TABLE crm_cust_info;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_crm/cust_info.csv'
INTO TABLE crm_cust_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@cst_id, @cst_key, @cst_firstname, @cst_lastname, @cst_marital_status, @cst_gndr, @cst_create_date)
SET
    cst_id            = NULLIF(@cst_id, ''),
    cst_key           = NULLIF(@cst_key, ''),
    cst_firstname     = NULLIF(@cst_firstname, ''),
    cst_lastname      = NULLIF(@cst_lastname, ''),
    cst_marital_status= NULLIF(@cst_marital_status, ''),
    cst_gndr          = NULLIF(@cst_gndr, ''),
    cst_create_date   = STR_TO_DATE(NULLIF(@cst_create_date,''), '%Y-%m-%d');


-- ==============================
-- crm_prd_info
-- ==============================
TRUNCATE TABLE crm_prd_info;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_crm/prd_info.csv'
INTO TABLE crm_prd_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@prd_id, @prd_key, @prd_nm, @prd_cost, @prd_line, @prd_start_dt, @prd_end_dt)
SET
    prd_id       = NULLIF(@prd_id, ''),
    prd_key      = NULLIF(@prd_key, ''),
    prd_nm       = NULLIF(@prd_nm, ''),
    prd_cost     = NULLIF(@prd_cost, ''),
    prd_line     = NULLIF(@prd_line, ''),
    prd_start_dt = STR_TO_DATE(NULLIF(@prd_start_dt,''), '%Y-%m-%d %H:%i:%s'),
    prd_end_dt   = STR_TO_DATE(NULLIF(@prd_end_dt,''), '%Y-%m-%d %H:%i:%s');


-- ==============================
-- crm_sales_details
-- ==============================
TRUNCATE TABLE crm_sales_details;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_crm/sales_details.csv'
INTO TABLE crm_sales_details
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@sls_ord_num, @sls_prd_key, @sls_cust_id, @sls_order_dt, @sls_ship_dt, @sls_due_dt, @sls_sales, @sls_quantity, @sls_price)
SET
    sls_ord_num  = NULLIF(@sls_ord_num, ''),
    sls_prd_key  = NULLIF(@sls_prd_key, ''),
    sls_cust_id  = NULLIF(@sls_cust_id, ''),
    sls_order_dt = NULLIF(@sls_order_dt, ''),
    sls_ship_dt  = NULLIF(@sls_ship_dt, ''),
    sls_due_dt   = NULLIF(@sls_due_dt, ''),
    sls_sales    = NULLIF(@sls_sales, ''),
    sls_quantity = NULLIF(@sls_quantity, ''),
    sls_price    = NULLIF(@sls_price, '');


-- ==============================
-- erp_loc_a101
-- ==============================
TRUNCATE TABLE erp_loc_a101;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_erp/LOC_A101.csv'
INTO TABLE erp_loc_a101
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@cid, @cntry)
SET
    cid   = NULLIF(@cid, ''),
    cntry = NULLIF(@cntry, '');


-- ==============================
-- erp_cust_az12
-- ==============================
TRUNCATE TABLE erp_cust_az12;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_erp/CUST_AZ12.csv'
INTO TABLE erp_cust_az12
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@cid, @bdate, @gen)
SET
    cid   = NULLIF(@cid, ''),
    bdate = STR_TO_DATE(NULLIF(@bdate,''), '%Y-%m-%d'),
    gen   = NULLIF(@gen, '');


-- ==============================
-- erp_px_cat_g1v2
-- ==============================
TRUNCATE TABLE erp_px_cat_g1v2;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/datasets/source_erp/PX_CAT_G1V2.csv'
INTO TABLE erp_px_cat_g1v2
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@id, @cat, @subcat, @maintenance)
SET
    id          = NULLIF(@id, ''),
    cat         = NULLIF(@cat, ''),
    subcat      = NULLIF(@subcat, ''),
    maintenance = NULLIF(@maintenance, '');

