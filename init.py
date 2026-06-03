from mssql_python import connect
import numpy as np
import pandas as pd
import time
import seaborn as sns
import matplotlib.pyplot as plt
conn = connect("Server=SHAN\SQLEXPRESS;Database=DataWarehouse;Encrypt=yes;TrustServerCertificate=yes;Trusted_Connection=yes")

SQL_QUERY = """
SELECT age from gold.dim_customers where birthdate is not null;
"""

cursor = conn.cursor()
cursor.execute(SQL_QUERY)

rows = cursor.fetchall()
df=pd.DataFrame(rows)
df.to_csv("ages.csv",index=False)
# fig, ax = plt.subplots(1,2, figsize=(18, 5))
# x = (df - df.mean())/df.std()
# sns.histplot(df,ax=ax[0])
# sns.histplot(x,ax=ax[1])
# plt.show()
