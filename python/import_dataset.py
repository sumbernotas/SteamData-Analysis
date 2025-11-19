import pandas as pd
import mysql.connector
from mysql.connector import Error

file_paths = {
    'applications': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\applications.csv',
    'genres': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\genres.csv',
    'developers': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\developers.csv',
    'publishers': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\publishers.csv',
    'categories': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\categories.csv',
    'platforms': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\platforms.csv',
    'application_genres': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\application_genres.csv',
    'application_developers': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\application_developers.csv',
    'application_publishers': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\application_publishers.csv',
    'application_categories': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\application_categories.csv',
    'application_platforms': r'C:\Users\sumrx\OneDrive\Documents\Datasets\Steam 2025 Dataset\steam_dataset_2025_csv_package_v1\steam_dataset_2025_csv\application_platforms.csv'
}

try:
    # connect to MySQL
    connection = mysql.connector.connect(
        host='localhost',
        database='steam_db_2025',
        user='root',
        password='PASSWORD-HERE'
    )

    if connection.is_connected():
        print("Connected to steam_db_2025\n")
        cursor = connection.cursor()

        # imports each CSV file
        for table_name, file_path in file_paths.items():
            print(f"{'='*50}")
            print(f"Importing {table_name}...")
            print(f"{'='*50}")

            # reads CSV
            df = pd.read_csv(file_path, encoding='utf-8', low_memory=False)
            print(f"CSV loaded: {len(df)} rows, {len(df.columns)} columns")
            
            # Drop existing table
            cursor.execute(f"DROP TABLE IF EXISTS {table_name}")
            connection.commit()
            
            # Create table with all columns as LONGTEXT (handles any data)
            columns = []
            has_id_column = False

            for col in df.columns:
                # Clean column names (remove spaces, special chars)
                clean_col = col.replace(' ', '_').replace('-', '_')
                if clean_col.lower() == 'id':
                    has_id_column = True
                    columns.append(f"`{clean_col}` INT PRIMARY KEY")
                else:
                    columns.append(f"`{clean_col}` LONGTEXT")

            # Only add auto-increment id if CSV doesn't have one
            if not has_id_column:
                create_query = f"""
                CREATE TABLE {table_name} (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    {', '.join(columns)}
                )
                """
            else:
                create_query = f"""
                CREATE TABLE {table_name} (
                    {', '.join(columns)}
                )
                """
            cursor.execute(create_query)
            connection.commit()
            print(f"Table {table_name} created")
            
            # Prepare insert query
            clean_cols = [col.replace(' ', '_').replace('-', '_') for col in df.columns]
            cols_string = ', '.join([f"`{col}`" for col in clean_cols])
            placeholders = ', '.join(['%s'] * len(df.columns))
            insert_query = f"INSERT INTO {table_name} ({cols_string}) VALUES ({placeholders})"
            
            # Insert data in batches
            print(f"Inserting {len(df)} rows...")
            for index, row in df.iterrows():
                if index % 5000 == 0 and index > 0:
                    print(f"Progress: {index}/{len(df)} rows...")
                try:
                    cursor.execute(insert_query, tuple(row.astype(str)))
                except Exception as e:
                    print(f"Warning: Skipped row {index} due to error: {e}")
                    continue
            
            connection.commit()
            print(f"Successfully imported {len(df)} rows into {table_name}!\n")
        
        print("="*50)
        print("ALL TABLES IMPORTED SUCCESSFULLY")
        print("="*50)
        
except Error as e:
    print(f"MySQL Error: {e}")
except Exception as e:
    print(f"Error: {e}")
    
finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("\nMySQL connection closed.")



    
