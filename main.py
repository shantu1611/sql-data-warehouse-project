from mssql_python import connect

conn = connect("Server=SHAN\SQLEXPRESS;Database=DataWarehouse;Encrypt=yes;TrustServerCertificate=yes;Trusted_Connection=yes")

SQL_QUERY = """
SELECT age from gold.dim_customers where birthdate is not null;
"""

cursor = conn.cursor()
cursor.execute(SQL_QUERY)

rows = cursor.fetchall()
for row in rows:
    
    print(row)

print(len(rows))