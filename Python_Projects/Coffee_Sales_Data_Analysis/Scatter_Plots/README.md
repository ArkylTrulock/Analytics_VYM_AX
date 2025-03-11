# `Data Visualisation - Scatterplot`.
-----------------------------------
A scatterplot is a versatile visualization tool that can represent both numerical and categorical data. While traditional scatterplots show the relationship between two numerical variables, categorical scatterplots visualize data points where one or both axes are based on categorical values. This project covers both types and walks through a comprehensive process for using scatterplots to analyze various datasets.

## Suitable Data Types for Scatterplots
---------------------------------------

### Numerical Scatterplots
--------------------------
Numerical scatterplots are ideal for exploring relationships between two continuous numerical variables, identifying trends, correlations, or clusters.

#### Categorical Scatterplots
-----------------------------
Categorical scatterplots, or strip plots, are useful when one of the variables is categorical. They can reveal patterns across categories, show distributions within each category, and highlight frequency or density of values.

#### Common data types for Scatterplots:
1) Product Category vs. Sales Revenue
2) Time Period (Year, Month, Weekday) vs. Product Quantity
3) Department vs. Employee Performance Scores

## Project Overview
-------------------
This project provides a structured workflow for loading, cleaning, and visualizing both numerical and categorical data using scatterplots. It includes data preprocessing, styling to highlight important values, and customization options for categorical scatterplots, which display distributions across categories.

## Project Workflow
-------------------
1) Load Dataframe: Import the data into a pandas DataFrame.
2) Analyse Dataframe: Explore initial data characteristics and structure.
3) Clean Dataframe: Handle missing values, negative values, infinite values, duplicates, and data formatting.
4) Final Checkup: Ensure data integrity after cleaning.
5) Highlight negative values: Apply custom styling to emphasize negative values.
6) Create Scatterplots:
   - Numerical Scatterplots: Visualize relationships between two continuous variables.
   - Categorical Scatterplots: Use Seaborn’s stripplot or swarmplot for categorical data, focusing on distributions across categories.

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
17) `.show()` - Display all open figures.
