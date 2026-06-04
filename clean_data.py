import pandas as pd

# Load dataset into a pandas DataFrame
df = pd.read_csv("Realestate.csv")


# Using Min-Max Normalization to scale houseAge between 0 and 1
min_age = df['houseAge'].min()
max_age = df['houseAge'].max()

df['houseAgeStandardized'] = (df['houseAge'] - min_age) / (max_age - min_age)

# Dropping the column permanently by using inplace=True
df.drop(columns=['numberOfConvenienceStores'], inplace=True)

# Renaming the column permanently using a mapping dictionary
df.rename(columns={'transaction': 'transactionDate'}, inplace=True)

# Note: .loc is label-based and is inclusive of both the start and stop indices
print("--- Rows 0 to 10 using .loc[] ---")
print(df.loc[0:10])
print("\n" + "="*50 + "\n")

# Note: .iloc is integer-position based and is exclusive of the stop index (0 to 9)
print("--- First 10 rows using .iloc[] ---")
print(df.iloc[0:10])
print("\n" + "="*50 + "\n")

# Removing duplicate rows completely and keeping the first occurrence
df.drop_duplicates(inplace=True)

# Selecting numeric columns to calculate their respective means and fill missing gaps
numeric_cols = df.select_dtypes(include=['number']).columns
df[numeric_cols] = df[numeric_cols].fillna(df[numeric_cols].mean())

# Saving the final modifications back to a new CSV file
df.to_csv("Cleaned_Realestate.csv", index=False)
print("Data cleaning complete. Cleaned file saved as 'Cleaned_Realestate.csv'.")
