        
import pandas as pd
import os

# Set the input directory and output filename
input_dir = r"E:\Old Files\Users\Jared\Desktop\School\5_Year_2_Sem\CSCI 173\Ass 9\json"
output_filename = "output.parquet"

# Initialize an empty list to store DataFrames
dfs = []

# Loop through all JSON files in the input directory
for filename in os.listdir(input_dir):
    if filename.endswith(".json"):
        # Load the JSON file into a DataFrame and append it to the list
        df = pd.read_json(os.path.join(input_dir, filename))
        dfs.append(df)

# Concatenate all DataFrames into a single DataFrame
all_data = pd.concat(dfs, ignore_index=True)

# Write the DataFrame to Parquet format using fastparquet
all_data.to_parquet(output_filename, engine="fastparquet")