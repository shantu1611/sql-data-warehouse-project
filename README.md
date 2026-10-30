# SQL Data Warehouse Project

A data warehouse built in **Microsoft SQL Server (MS SQL)** that integrates raw CRM and ERP exports into a clean **star schema** using a **Bronze → Silver → Gold** architecture, with stored-procedure ETL and SQL quality checks.

## Architecture

| Layer | Schema | What happens | Type |
|---|---|---|---|
| Bronze | `bronze` | Raw CSVs loaded unchanged via `BULK INSERT` | Tables |
| Silver | `silver` | Dedupe, trim, standardise codes, fix dates and sales values | Tables |
| Gold | `gold` | `dim_customers`, `dim_products`, `fact_sales` with surrogate keys | Views |

**Sources:** 3 CRM files (customers, products, sales: 60,398 order lines) and 3 ERP files (customer birthdate, location, product categories).

## Key Cleaning Rules

- Keep the latest record per customer (`ROW_NUMBER`) and drop null IDs
- Map codes to readable values (gender, marital status, product line, country)
- Convert `YYYYMMDD` integers to dates; invalid values become `NULL`
- Recalculate sales, quantity or price when missing or inconsistent (`sales = quantity × price`)
- Derive product end dates with `LEAD`; Gold keeps only current products

## Quality Checks (`tests/`)

- **Silver:** duplicate or null keys, unwanted spaces, standardised values, date validity and order, sales consistency
- **Gold:** surrogate key uniqueness and fact-to-dimension referential integrity

## Tech Stack

T-SQL, Microsoft SQL Server, SSMS, stored procedures with `TRY/CATCH` and load-time logging, window functions, views, star-schema modelling.

## Run It

1. In SSMS, create a `DataWarehouse` database, then run `scripts/init.sql`
2. Run `create_bronze_table.sql`
3. In `load_bronze.sql`, change the file paths to your local `dataset/` folder
4. `EXEC bronze.load_bronze;`
5. Run `create_silver_tables.sql` and `load_clean_silver.sql`, then `EXEC silver.load_silver;`
6. Run `create_gold_layer.sql`
7. Run the scripts in `tests/`; each check should return no rows

## Repository Structure

```
├── dataset/    # Source CSVs (CRM + ERP)
├── scripts/    # Schemas, DDL, load procedures, gold views
├── tests/      # Silver and Gold quality checks
└── docs/       # Diagrams
```

## Limitations and Next Steps

- Full-refresh loads (not incremental); file paths are local and must be edited
- Planned: data-flow diagram, one master load procedure, incremental loads, and a Power BI dashboard on the Gold layer

**Author:** Shantu Dhami · [@shantu1611](https://github.com/shantu1611) · MIT License
