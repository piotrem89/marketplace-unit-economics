from src.load_staging import load_staging_data
from src.transform_sales import sales_transformation



if __name__ == "__main__":
    print("Starting ELT pipeline...")
    load_staging_data()
    sales_transformation()
    print("ELT pipeline completed successfully!")