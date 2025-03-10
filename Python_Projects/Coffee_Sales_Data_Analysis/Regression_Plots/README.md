# `Data Visualisation - Regression Plot`.
-----------------------------------------
This project provides a comprehensive guide to data cleaning, processing, and visualizing with regression plots. It walks through preparing a dataset and generating insights through Seaborn’s regression-focused visualizations, including Regplot, Residplot, and Lmplot.

## Suitable Data Types for Regression Plots
-------------------------------------------
Regression plots work best with numerical data where relationships between continuous variables need to be visualized. They are especially useful for:

1) Identifying linear and non-linear relationships between variables.
2) Observing trends in time-series or sequential data.
3) Exploring the relationship between a dependent variable and independent variables for prediction and trend analysis.

## Project Overview
-------------------
This project presents a structured approach to handling data, from cleaning to visualization:

1) Load Dataframe: Import the data into a pandas DataFrame.
2) Analyse Dataframe: Explore initial data characteristics and structure.
3) Clean Dataframe: Handle missing values, negative values, infinite values, duplicates, and data formatting.
4) Final Checkup: Ensure data integrity after cleaning.
5) Highlight negative values: Apply custom styling to emphasize negative values.
6) Visualization with Seaborn: Generate regression plots, including Regplot, Residplot, and Lmplot, to examine relationships and trends in the data.

## Visualization Techniques
---------------------------
The following visualizations are covered in this project:

1) Regplot - A scatterplot with an optional regression line to identify correlations between two variables.
2) Residplot - A plot of residuals to assess the fit quality and distribution of errors.
3) Lmplot - Combines scatter and regression plots, useful for examining relationships across categories.
4) Pairplot - Displays pairwise relationships between variables with regression lines.

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
