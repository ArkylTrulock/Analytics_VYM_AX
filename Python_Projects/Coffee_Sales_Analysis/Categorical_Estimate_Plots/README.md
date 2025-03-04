# `Data Visualisation - Bar Plot`.
-----------------------------------
A bar plot is a type of chart used to represent data with rectangular bars, where the length of each bar is proportional to the value it represents. Bar plots are ideal for comparing quantities across categories and are commonly used to visualize categorical data, such as sales by product type, revenue by region, or frequency counts of specific items.

## Suitable Data Types for Bar Plots
-------------------------------------
Bar plots are ideal for visualizing relationships between categorical variables and numerical values, such as comparing sales across different categories or time periods.

#### Common data types for bar plots:
 1) Categorical variables (e.g., product types, regions, months)
 2) Numerical data (e.g., total sales, quantities sold)

## Project Overview
-------------------
This project provides a complete workflow for loading, cleaning, and visualizing sales data using bar plots. The primary focus is on plotting categorical variables against total sales to uncover trends and insights. The workflow guides users through essential steps, including data cleaning, handling missing values, and visualizing trends with customized bar plots.

## Project Workflow
-------------------
1) Load Dataframe: Import the data into a pandas DataFrame.
2) Analyse Dataframe: Explore initial data characteristics and structure.
3) Clean Dataframe: Handle missing values, negative values, infinite values, duplicates, and data formatting.
4) Final Checkup: Ensure data integrity after cleaning.
5) Highlight negative values: Apply custom styling to emphasize negative values.
6) Create Bar Plots: Visualize the cleaned data using Matplotlib and Seaborn bar plots.

## Key Functions and Methods in pandas
--------------------------------------
1) `.groupby()` - Group our data into categories.
2) `.aggregate()` - Aggregate data using functions like `min`, `median`, `max`, `mean`, `count`, and `sum`.
3) `.sort_values()` - Sort data by values in either ascending or descending order.
4) `.reset_index()` - Reset the index or a specific level in the DataFrame.
5) `.rename()` - Rename columns or index labels for clarity.
6) `.head()` - Return the first `n` rows of the DataFrame.
7) `.sum()` - Return the sum of the values over the requested axis.
8) `.rank()` - Compute numerical data ranks (1 through n) along axis.
9) `.background_gradient()` - Apply gradient coloring to highlight values.
10) `.map()` - Apply functions elementwise across a DataFrame.
11) `.style()` - Access methods for HTML representation with styling options.
12) `.format()` - Format text display in cells.
13) `.set_table_styles()` - Apply styles to the entire table, specific columns, rows, or HTML selectors.
14) `.set_properties()` - Set CSS properties for <td> elements in a subset.
15) `.set_caption()` - Add a caption to the HTML table for context.
16) `.display()` - Display a Python object in all frontends.
17) `.show()` - Display all open figures....
