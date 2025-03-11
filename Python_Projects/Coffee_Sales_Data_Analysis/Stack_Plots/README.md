# `Data Visualisation - Stack Plot`.
-----------------------------------
A stack plot is a type of chart used to display part-to-whole relationships over time or categories. This project demonstrates a workflow for loading, cleaning, and visualizing data with stack plots, enabling insights into cumulative trends across multiple categories.

## Suitable Data Types for Stack Plots
-------------------------------------
Stack plots are best suited for data that represents proportions or cumulative totals, especially over a time series. This visualization style is particularly useful for data that can be broken down into several components, showing how each part contributes to the whole.

#### Common data types for bar plots:
 1) Sales or revenue data over time by category
 2) Population statistics across different demographics
 3) Resource allocation in projects or departments

## Project Overview
-------------------
This project provides a workflow for loading, cleaning, and visualizing sales or categorical data using stack plots. The primary goal is to plot categories against total sales or similar metrics to reveal trends and provide insights. The workflow includes data cleaning, handling missing values, and customized stack plot visualization to emphasize key data points.

## Project Workflow
-------------------
1) Load Dataframe: Import the data into a pandas DataFrame.
2) Analyse Dataframe: Explore initial data characteristics and structure.
3) Clean Dataframe: Handle missing values, negative values, infinite values, duplicates, and data formatting.
4) Final Checkup: Ensure data integrity after cleaning.
5) Highlight negative values: Apply custom styling to emphasize negative values.
6) Create Stack Plots: Visualize the cleaned data using Matplotlib stack plots.

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
