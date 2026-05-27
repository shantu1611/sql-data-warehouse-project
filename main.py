from mssql_python import connect

conn = connect("Server=SHAN\SQLEXPRESS;Database=DataWarehouse;Encrypt=yes;TrustServerCertificate=yes;Trusted_Connection=yes")

SQL_QUERY = """
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info;
"""

cursor = conn.cursor()
cursor.execute(SQL_QUERY)

rows = cursor.fetchall()
for row in rows:
    print(row)