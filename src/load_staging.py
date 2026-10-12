import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from pathlib import Path

# Load environment variables from .env file
load_dotenv()

DB_SERVER = os.getenv('DB_SERVER')
DB_NAME = os.getenv('DB_NAME')
DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')


def get_db_engine():
    """Create SQLAlchemy database connection engine."""
    connection_string = (
        f"mssql+pymssql://{DB_USER}:{DB_PASSWORD}@{DB_SERVER}/{DB_NAME}"
    )
    return create_engine(connection_string)


def load_staging_data():
    """Reads raw sales CSV and loads it into SQL Server staging table."""
    # Define project paths
    base_dir = Path(__file__).resolve().parent.parent
    data_path = base_dir / "data" / "retail_store_sales.csv"
    sql_path = base_dir / "sql" / "01_create_staging.sql"

    # Read CSV treating all columns as text to avoid data loss
    df = pd.read_csv(data_path, dtype=str)

    # Replace spaces with underscores in column names
    df.columns = df.columns.str.replace(" ", "_")

    engine = get_db_engine()

    # Recreate staging table in database
    with open(sql_path, "r", encoding="utf-8") as file:
        sql_script = file.read()
        with engine.begin() as conn:
            conn.execute(text(sql_script))

    # Insert data into the staging table
    df.to_sql(name="stg_retail_sales", schema="dbo", con=engine, index=False, if_exists="append")


if __name__ == "__main__":
    load_staging_data()



