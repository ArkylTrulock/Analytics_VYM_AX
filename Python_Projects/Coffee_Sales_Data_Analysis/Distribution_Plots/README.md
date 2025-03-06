# `Data Visualisation - Distribution Plot`.
------------------------------------------------------
This project provides a comprehensive guide to generating and customizing distribution plots for exploratory data analysis using Matplotlib and Seaborn. Distribution plots are invaluable tools for understanding data patterns, assessing variability, and highlighting data distribution trends.

## Suitable Data Types for Distribution Plots
---------------------------------------------------------
Distribution plots can be especially useful for visualizing:

1) Numerical data, such as continuous values (e.g., age, salary, weight)
2) Categorical data, when combined with methods to show category distributions
3) Time series data, particularly for trends and seasonal analysis

## Project Overview
-------------------
This project presents a structured approach to preparing and visualizing data distributions, walking through the key steps required to transform raw data into insightful visualizations.

## Project Workflow
-------------------
1) Load Dataframe: Import the data into a pandas DataFrame.
2) Analyse Dataframe: Explore initial data characteristics and structure.
3) Clean Dataframe: Handle missing values, negative values, infinite values, duplicates, and data formatting.
4) Final Checkup: Ensure data integrity after cleaning.
5) Highlight negative values: Apply custom styling to emphasize negative values.
6) Use Matplotlib and Seaborn to create visualizations, including histograms, KDE plots, ECDFs, and rugplots.

## Visualization Techniques
---------------------------
The project demonstrates a variety of visualization techniques, focusing on key types of distribution plots:

1) Histogram - Displays the frequency distribution of a set of continuous data, giving a rough estimate of data distribution.
2) KDE Plot (Kernel Density Estimate) - Smoothens the distribution, showing an estimated probability density of continuous data.
3) ECDF Plot (Empirical Cumulative Distribution Function) - Represents the proportion of data points below each value.
4) Rugplot - Adds markers along an axis to show individual data points, complementing KDE or histograms.
5) Histplot - A histogram variant with more options for data binning and customization in Seaborn.

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
