import os
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


def sales_transformation():
    """ """
    # Define project paths
    base_dir = Path(__file__).resolve().parent.parent
    sql_path = base_dir / "sql" / "03_transform_sales.sql"

    engine = get_db_engine()

    with open(sql_path, 'r', encoding='utf-8') as file:
        sql_script = file.read()
        with engine.begin() as conn:
            conn.execute(text(sql_script))

if __name__ == "__main__":
    sales_transformation()