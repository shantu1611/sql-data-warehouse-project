create or alter procedure bronze.load_bronze as

begin

begin try

declare @start_time datetime,@end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
    set @batch_start_time=getdate();
    set @start_time= getdate();
    Truncate table bronze.crm_cust_info
    bulk insert bronze.crm_cust_info
    from 'C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\cust_info.csv'
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )
    set @end_time= getdate();
    PRINT '>> LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR(50))+' seconds';
    PRINT '==============================='

    set @start_time= getdate();
    Truncate table bronze.crm_prd_info
    bulk insert bronze.crm_prd_info
    from 'C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\prd_info.csv'
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )
    set @end_time= getdate();
    PRINT '>> LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR(50))+' seconds';
    PRINT '==============================='

    set @start_time= getdate();
    Truncate table bronze.crm_sales_details
    bulk insert bronze.crm_sales_details
    from 'C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\sales_details.csv'
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )
    set @end_time= getdate();
    PRINT '>> LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR(50))+' seconds';
    PRINT '==============================='

    set @start_time= getdate();
    Truncate table bronze.erp_cust_az12
    bulk insert bronze.erp_cust_az12
    from 'C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\CUST_AZ12.csv'
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )
    set @end_time= getdate();
    PRINT '>> LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR(50))+' seconds';
    PRINT '==============================='

    set @start_time= getdate();
    Truncate table bronze.erp_loc_a101
    bulk insert bronze.erp_loc_a101
    from 'C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\LOC_A101.csv'
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )
    set @end_time= getdate();
    PRINT '>> LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR(50))+' seconds';
    PRINT '==============================='

    set @start_time= getdate();
    Truncate table bronze.erp_px_cat_g1v2
    bulk insert bronze.erp_px_cat_g1v2
    from 'C:\Users\shantu\Desktop\my_works\sql-data-warehouse-project\dataset\PX_CAT_G1V2.csv'
    with(
        firstrow=2,
        fieldterminator=',',
        tablock
    )
    set @end_time= getdate();
    PRINT '>> LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR(50))+' seconds';
    PRINT '==============================='
    set @batch_end_time=getdate();
    PRINT 'BRONZE LAYER LOAD DUARATION: '+CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) as NVARCHAR(50))+' seconds';
end try

    begin catch
        PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
    end catch
end

exec bronze.load_bronze;

select count(*) from bronze.crm_cust_info;