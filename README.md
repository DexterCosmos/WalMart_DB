<div align="center">
    <img src="" alt="Banner">
    <h1><b>Walmart Products DB</b></h1>
</div>

## *Introduction*

This project involves the comprehensive analysis of a Walmart product dataset containing **`568,534`** records and **`16`** columns. The dataset has been meticulously cleaned and standardized using Python to ensure accuracy and consistency. Leveraging SQL for in-depth analysis, we uncovered key business insights and performance metrics for products. To make these findings accessible and actionable for stakeholders, the data has been visualized using Power BI, offering clear and impactful perspectives on trends and opportunities.

## *Analysis*

Using Python, the Walmart products dataset underwent rigorous analysis to extract meaningful insights. Key steps included:

- **Data Cleaning and Preprocessing**: Python libraries such as Pandas and NumPy were utilized to handle missing values, standardize data formats, and remove duplicates, ensuring data integrity.
- **Exploratory Data Analysis (EDA)**: Visualizations created with libraries like Matplotlib and Seaborn highlighted trends, outliers, and relationships within the data.
- **Key Insights Generation**: Metrics such as product sales performance, inventory trends, and customer preferences were derived, providing actionable business intelligence.
- **Automated Reporting**: Python scripts were developed for efficiency, allowing repeatable and scalable analysis workflows.

This systematic approach facilitated a deeper understanding of product performance and informed strategic decision-making. Let me know if you'd like to expand on specific parts!

### Python Scripts Prototype

1. Importing Libraries

    ```python
    import pandas as pd
    import pymysql
    from sqlalchemy import create_engine

    df = pd.read_csv('WalMart_groceries.csv', low_memory=False)
    ```

2. Analysis of Dataset

    ```python
    df.head()

    df.describe()

    df.columns

    df.info()

    df.shape

    df.isnull().sum()

    df.duplicated().sum()
    ```

3. Data Cleaning and Standardization

    ```python
    # Lowercase all column names
    df.columns = df.columns.str.lower()

    # Dropping Promotion Column from the dataset
    df.drop(columns=['promotion'], inplace=True)
    ```

    ```python
    ## Fixing the column Datatype, removing String value and calculating total_price

    # Cleaning product_size: Removing commas and strip spaces
    df['product_size'] = df['product_size'].str.replace(',', '').str.strip()

    # Converting product_size to float, handle errors if any
    df['product_size'] = pd.to_numeric(df['product_size'], errors='coerce')

    # Handling NaN values
    df['product_size'] = df['product_size'].fillna(0).astype(int)

    # Calculating the total_price column
    df['total_price'] = df['price_current'] * df['product_size']

    print(df)
    ```

    ```python

    df.columns

    df.heads()
    ```

4. Exporting the cleaned .csv

    ```python
    df.to_csv('walmart_cleaned.csv', index=False)
    ```

5. Connecting to SQL

    ```python
    engine_sql = create_engine('mysql+pymysql://root:Cosmos.90@localhost:3306/WalMart')
    ```

6. Exporting the cleaned .csv to SQL

    ```python
    df.to_sql(name='store', con=engine_sql, if_exists='replace', index=False)
    ```

## *Insights Analysis*

### SQL Queries Prototype




## *Data Visualization*

- Dashboard | Overview

<div>
 <img src="dashboard.png" alt="Dashboard | overview" width">
</div>

## *Impact*




## *Tools*

- Python - Libraries [Pandas, NumPy, pymysql, sqlalchemy]
- SQL
- Power BI
- Excel
- Jupyter Notebook

---

<div align="center">
    <i> This Project was solely exicuted by // <b>Nomaan Ansari</b> //</i>
</div>