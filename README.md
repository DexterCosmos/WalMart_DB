<div align="center" style="font-family: Times New Roman, serif">
    <img src="images/banner.png" alt="Banner" width="500">
    <h1><b>Walmart Products DB</b></h1>
</div>

## *Introduction*

This project involves the comprehensive analysis of a Walmart product dataset containing **`568,534`** records and **`16`** columns. 
The dataset has been meticulously cleaned and standardized using Python to ensure accuracy and consistency. 
Leveraging SQL for in-depth analysis, we uncovered key business insights and performance metrics for products. 
To make these findings accessible and actionable for stakeholders, the data has been visualized using Power BI, offering clear and impactful perspectives on trends and opportunities.

## *Analysis*

Using Python, the Walmart products dataset underwent rigorous analysis to extract meaningful insights. Key steps included:

- **Data Cleaning and Preprocessing**: Python libraries such as Pandas and NumPy were utilized to handle missing values, standardize data formats, and remove duplicates, ensuring data integrity.

- **Key Insights Generation**: Metrics such as product sales performance, inventory trends, and customer preferences were derived, providing actionable business intelligence.

- **Automated Reporting**: Python scripts were developed for efficiency, allowing repeatable and scalable analysis workflows.

This systematic approach facilitated a deeper understanding of product performance and informed strategic decision-making.

- ### Python Scripts Prototype

1. Importing Libraries

```python
import pandas as pd
import pymysql
from sqlalchemy import create_engine
```
```python
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

- Fixing the column Datatype, removing String value and calculating total_price
```python
# Cleaning product_size: Removing commas and strip spaces

df['product_size'] = df['product_size'].str.replace(',', '').str.strip()
```

```python
# Converting product_size to float, handle errors if any

df['product_size'] = pd.to_numeric(df['product_size'], errors='coerce')
```

```python
# Handling NaN values

df['product_size'] = df['product_size'].fillna(0).astype(int)
```

```python
# Calculating the total_price column

df['total_price'] = df['price_current'] * df['product_size']

print(df)
```

```python
df.columns

df.head()
```

4. Exporting the cleaned .csv

```python
df.to_csv('walmart_cleaned.csv', index=False)
```

5. Connecting to SQL

```python
engine_sql = create_engine('mysql+pymysql://root:Cosmos.90@localhost:3306/walmart')
```

6. Exporting the cleaned .csv to SQL

```python
df.to_sql(name='walmart_db', con=engine_sql, if_exists='replace', index=False)
```

## *Insights Analysis*

Using SQL, key business insights were analyzed from the Walmart products dataset. 
This included uncovering patterns, trends, and performance metrics to better understand product behavior and overall business performance.

- ### SQL Queries Prototype

    For more related to the business SQL queries refer to **`walmart_business.sql`** file title.

```sql
-- Shipping Location Performance

WITH LocationPerformance AS (
    SELECT 
        shipping_location,
        SUM(total_price) AS total_sales,
        COUNT(*) AS order_count
    FROM walmart_db
    GROUP BY shipping_location
)
SELECT 
    shipping_location,
    total_sales,
    order_count,
    RANK() OVER (ORDER BY total_sales DESC) AS ranking
FROM LocationPerformance
LIMIT 15;
```

```sql
-- Revenue Growth by Department

WITH DepartmentRevenue AS (
    SELECT 
        department,
        DATE_FORMAT(rundate, '%Y-%m') AS month,
        SUM(total_price) AS monthly_revenue
    FROM walmart_db
    GROUP BY department, DATE_FORMAT(rundate, '%Y-%m')
)
SELECT 
    department,
    month,
    monthly_revenue,
    RANK() OVER (PARTITION BY month ORDER BY monthly_revenue DESC) AS ranking
FROM DepartmentRevenue;
```

```sql
-- Seasonal Insights

SELECT 
    product_name,
    category,
    CASE 
        WHEN MONTH(rundate) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(rundate) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(rundate) IN (6, 7, 8) THEN 'Summer'
        ELSE `Autumn`
    END AS season,
    SUM(total_price) AS seasonal_sales
FROM walmart_db
GROUP BY product_name, category, season;
```

## *Data Visualization*

- Dashboard | Overview

<div>
 <img src="dashboard.png" alt="Dashboard | overview" width">
</div>

## *Impact*


The Walmart Products Database project has significantly streamlined data analysis and visualization for stakeholders, driving impactful business insights. Key outcomes include:

- **Enhanced Data Integrity**: With Python-powered data cleaning and standardization, the dataset of **568,534 records** was transformed into an accurate and consistent foundation for analysis.

- **Actionable Business Insights**: SQL-driven analysis unearthed crucial patterns such as revenue growth trends, seasonal product performance, and shipping location rankings. These insights inform strategic decisions, optimizing Walmart's operations and market strategy.

- **Efficiency Through Automation**: Python scripts enabled repeatable and scalable workflows, saving valuable time for analysts and ensuring consistent analysis.

- **Visual Clarity for Stakeholders**: Power BI dashboards provided stakeholders with clear, actionable perspectives, enhancing decision-making through intuitive data storytelling.

The project empowers data-driven strategies, demonstrating a robust blend of technical expertise and business acumen.


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