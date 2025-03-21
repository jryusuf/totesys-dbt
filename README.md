# Toteways dbt Project

## Project Purpose

This project is designed to practice ELT, specifically focusing on data transformation logic using dbt (data build tool). It builds upon previous experience with end-to-end data engineering pipelines, infrastructure, and coding, to deepen the understanding of data modeling and transformation within a dbt framework.

The goal is to transform data extracted from an operational database into a star schema format within a Postgres data warehouse, suitable for OLAP analysis.

## Setup and Run Instructions

This project uses dbt (data build tool) to transform and model data in a **Postgres** data warehouse. It leverages dbt utilities defined in the `packages.yml` file to enhance data transformations.

**Important**: This project requires a Postgres database that is already populated with data extracted from a production database. We recommend using a tool like Fivetran (free trial available) to automate the extraction and loading process.

### Prerequisites

- **Python and pip**: dbt is a Python package, so ensure you have Python and pip installed on your system.
- **dbt CLI**: Install the dbt command-line interface and the Postgres adapter. Refer to the [dbt documentation](https://docs.getdbt.com/docs/core/installation) for installation instructions.
  ```bash
  pip install dbt-core  # For core dbt functionality
  pip install dbt-postgres # Postgres adapter
  ```
- **Postgres Data Warehouse with Pre-loaded Data**: You need access to a Postgres data warehouse that has been pre-loaded with data. Consider using Fivetran or a similar ETL tool to extract and load data from your source database into your Postgres data warehouse.
- **Data Warehouse Credentials**: You will need credentials to access your Postgres data warehouse. These credentials will be configured in your `profiles.yml` file.

### Project Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/jryusuf/totesys-dbt
   cd totesys_dbt/totesys_dbt # Navigate to the dbt project directory
   ```

2. **Install dbt packages**:
   This project uses dbt packages defined in `packages.yml` (including dbt_utils). Install them by running:
   ```bash
   dbt deps
   ```
   This command will install the packages listed in your `packages.yml` file, including dbt utilities that provide helpful macros and functions for your dbt project.

3. **Configure your dbt profile**:
   dbt uses profiles to manage connections to your data warehouse. You need to configure your profile in the `profiles.yml` file.
   - This file is typically located in your dbt project directory or `~/.dbt/`.
   - Create or modify your `profiles.yml` to include a profile for your Postgres connection.
   - Refer to the dbt documentation for profile configuration for Postgres.
     [dbt Profiles](https://docs.getdbt.com/docs/core/dbt-project/dbt-profiles-yml)

   Example `profiles.yml` (Postgres):
   ```yaml
   totesys_dbt: # profile name, same as in dbt_project.yml
     target: dev # target name
     outputs:
       dev: # target name
         type: postgres
         threads: [1 or more]
         host: <your_postgres_host>
         port: <your_postgres_port>
         user: <your_postgres_user>
         password: <your_postgres_password>
         dbname: <your_postgres_dbname>
         schema: <your_dbt_schema> # Database schema to use for dbt objects
   ```
   **Replace the placeholders** `<your_postgres_host>`, `<your_postgres_port>`, `<your_postgres_user>`, `<your_postgres_password>`, `<your_postgres_dbname>`, and `<your_dbt_schema>` with your actual Postgres connection details.

### Running the dbt Project

Once you have set up your project and configured your profile, you can run the dbt project using the following commands:

1. **Run dbt models**:
   To execute the dbt models and transform your data, run:
   ```bash
   dbt run
   ```

2. **Seed data (if applicable)**:
   If you have seed data files (in the `seeds/` directory), load them into your data warehouse:
   ```bash
   dbt seed
   ```

3. **Run dbt tests**:
   To ensure the quality of your data transformations, run dbt tests:
   ```bash
   dbt test
   ```

4. **Generate documentation**:
   To generate documentation for your dbt project, run:
   ```bash
   dbt docs generate
   dbt docs serve # To view the documentation in your browser
   ```

### Cleaning up

To clean your dbt project (remove compiled SQL and target directory), you can run:
```bash
dbt clean
```

### Important Notes

- **Pre-loaded Database**: Ensure your Postgres database is already populated with data before running this dbt project. Consider using Fivetran or similar tools for data extraction and loading.
- **Postgres Data Warehouse**: This project is configured to work with a Postgres data warehouse.
- **dbt Utilities**: This project utilizes dbt utilities defined in the `packages.yml` file. Make sure to run `dbt deps` to install these packages.

## Data Model

This dbt project is designed around a star schema, optimized for sales data analysis. The schema includes the following key tables:

 - ["Sales" schema](https://dbdiagram.io/d/637a423fc9abfc611173f637)
 - ["Purchases" schema](https://dbdiagram.io/d/637b3e8bc9abfc61117419ee)
 - ["Payments" schema](https://dbdiagram.io/d/637b41a5c9abfc6111741ae8)

**Fact Table:**

- `fact_sales_order`: This table is the central fact table, recording details of each sales order. It includes measures like order amount, quantity, and keys to dimension tables for slicing and dicing data.

**Dimension Tables:**

- `dim_counterparty`: Stores information about counterparties (customers or suppliers).
- `dim_currency`: Lists different currencies used in transactions.
- `dim_date`: A date dimension table to enable time-based analysis.
- `dim_design`: Details about product designs.
- `dim_location`: Information about geographical locations.
- `dim_staff`: Details about staff members involved in sales processes.
- `dim_payment_type`: (To-Do) Details about payment types.
- `dim_transaction`: (To-Do) Details about transactions.

**Staging Tables:**

The `staging` directory contains tables that directly reflect the source data structure, prefixed with `stg_`. These tables are used to cleanse, transform, and prepare data before loading into the mart tables.

- `stg_address`
- `stg_counterparty`
- `stg_currency`
- `stg_department`
- `stg_design`
- `stg_payment_type`
- `stg_payment`
- `stg_purchase_order`
- `stg_sales_order`
- `stg_staff`
- `stg_transaction`

**Transformations:**

dbt models are used to perform the following transformations:

- **Staging**: Data is loaded from source tables into staging tables with minimal transformations, primarily focusing on data type casting and renaming columns for consistency.
- **Mart**: Staging tables are then joined, aggregated, and transformed to create the dimension and fact tables in the `marts` directory. These transformations include:
    - Joining related data from multiple staging tables.
    - Applying business logic to calculate key metrics.
    - Ensuring data quality and consistency.
    - Creating surrogate keys and managing relationships between tables.

### Further Information

- [dbt Documentation](https://docs.getdbt.com/) - Comprehensive documentation for dbt.
- [dbt Learn](https://courses.getdbt.com/courses/dbt-learn) - Interactive courses to learn dbt.
