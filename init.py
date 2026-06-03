from mssql_python import connect
import numpy as np
import pandas as pd
import time
import seaborn as sns
import pyodbc
import matplotlib.pyplot as plt
import sqlparse
conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=SHAN\\SQLEXPRESS;"
    "DATABASE=master;"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;"
    "Trusted_Connection=yes;"
)
conn.autocommit = True
cursor = conn.cursor()

cursor.execute("IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'DataWarehouse') CREATE DATABASE DataWarehouse")
print("✓ Database created.")
conn.close()
conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=SHAN\\SQLEXPRESS;"
    "DATABASE=master;"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;"
    "Trusted_Connection=yes;"
)
conn.autocommit = True
cursor = conn.cursor()

with open("scripts/init.sql", "r", encoding="utf-8") as file:
    sql_script = file.read()

statements = sqlparse.split(sql_script)
for statement in statements:
    if statement.strip():
        cursor.execute(statement)
print(sql_script)

# rows = cursor.fetchall()
# df=pd.DataFrame(rows)
# df.to_csv("tables.csv",index=False)
# print(df.head())
# fig, ax = plt.subplots(1,2, figsize=(18, 5))
# x = (df - df.mean())/df.std()
# sns.histplot(df,ax=ax[0])
# sns.histplot(x,ax=ax[1])
# plt.show()
