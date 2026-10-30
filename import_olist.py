import pandas as pd
from sqlalchemy import create_engine
import os
from sqlalchemy import text

# --- YOUR DETAILS ALREADY FILLED ---
csv_folder = r"C:\Users\Aditya Bhoyar\OneDrive\Desktop\Ecommerce Dataset"
db_password = "root123"

engine = create_engine(f"mysql+pymysql://root:{db_password}@localhost/olist_store_analysis")

# Create database
with engine.connect() as conn:
    conn.execute(text("CREATE DATABASE IF NOT EXISTS olist_store_analysis"))
    conn.commit()

files = [
    "olist_customers_dataset.csv",
    "olist_geolocation_dataset.csv",
    "olist_sellers_dataset.csv",
    "olist_products_dataset.csv",
    "product_category_name_translation.csv",
    "olist_orders_dataset.csv",
    "olist_order_items_dataset.csv",
    "olist_order_payments_dataset.csv",
    "olist_order_reviews_dataset.csv"
]

for file in files:
    path = os.path.join(csv_folder, file)
    table_name = file.replace(".csv", "")
    print(f"Importing {file} -> {table_name}...")
    try:
        df = pd.read_csv(path, low_memory=False)
        df.columns = [c.strip().lower() for c in df.columns]
        df.to_sql(table_name, con=engine, if_exists='replace', index=False)
        print(f"  DONE - {len(df)} rows imported")
    except Exception as e:
        print(f"  FAILED - {file} - {e}")

print("\nALL DONE! Now open MySQL Workbench and check olist_store_analysis -> Tables")