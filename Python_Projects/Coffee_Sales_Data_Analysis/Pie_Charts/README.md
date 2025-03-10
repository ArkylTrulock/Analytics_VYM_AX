# `Data Visualisation - Pie Chart`.
-----------------------------------
A pie chart is a circular statistical graphic used to illustrate proportions and relationships within a dataset by dividing a circle into slices, each representing a percentage of the whole.

## Suitable Data Types for Pie Charts
-------------------------------------
Pie charts are ideal for visualizing proportional data, making it easy to compare parts of a dataset to its entirety. They are commonly used for categorical data where each category's contribution to a total is the focus.

#### Common data types for Pie Charts:
 1) Market share distribution
 2) Budget breakdown by category
 3) Customer demographics or survey results

## Project Overview
-------------------
This project provides a comprehensive workflow for importing, cleaning, and visualizing sales data using pie charts. It walks through essential steps in data preparation and guides users on effectively creating and styling pie charts for insightful visualizations.

## Project Workflow
-------------------
1) Load Dataframe: Import the data into a pandas DataFrame.
2) Analyse Dataframe: Explore initial data characteristics and structure.
3) Clean Dataframe: Handle missing values, negative values, infinite values, duplicates, and data formatting.
4) Final Checkup: Ensure data integrity after cleaning.
5) Highlight negative values: Apply custom styling to emphasize negative values.
6) Create Bar Plots: Visualize the cleaned data using Matplotlib's pie chart functionality.

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
