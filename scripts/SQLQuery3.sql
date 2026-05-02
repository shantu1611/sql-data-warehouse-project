create or alter procedure bronze.load_bronze as
begin
    Truncate table bronze.crm_cust_info
    bulk insert bronze.crm_cust_info
    from "C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\cust_info.csv"
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )

    Truncate table bronze.crm_prd_info
    bulk insert bronze.crm_prd_info
    from "C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\prd_info.csv"
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )

    Truncate table bronze.crm_sales_details
    bulk insert bronze.crm_sales_details
    from "C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\sales_details.csv"
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )

    Truncate table bronze.erp_cust_az12
    bulk insert bronze.erp_cust_az12
    from "C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\CUST_AZ12.csv"
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )

    Truncate table bronze.erp_loc_a101
    bulk insert bronze.erp_loc_a101
    from "C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\LOC_A101.csv"
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )

    Truncate table bronze.erp_px_cat_g1v2
    bulk insert bronze.erp_px_cat_g1v2
    from "C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\PX_CAT_G1V2.csv"
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )
end

exec bronze.load_bronze;

select count(*) from bronze.crm_cust_info;