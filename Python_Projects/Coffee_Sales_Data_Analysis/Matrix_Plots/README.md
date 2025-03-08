# `Data Visualisation - Matrix Plot`.
-----------------------------------------
This project demonstrates data cleaning, processing, and visualization techniques with a focus on matrix plots such as Heatmaps and Pairplots. These plots provide powerful insights into relationships and trends within multidimensional data.

## Suitable Data Types for Matrix Plots
-------------------------------------------
Matrix plots work well with the following data types:

1) Numeric Data: Ideal for generating heatmaps to display correlations or other aggregated metrics.
2) Categorical Data: Can be grouped for pairwise comparisons and insights.
3) Multidimensional Data: Useful for pairplots to visualize distributions and relationships across multiple variables.

## Project Overview
-------------------
This project presents a structured approach to handling data, from cleaning to visualization:

1) Load Dataframe: Import the data into a pandas DataFrame.
2) Analyse Dataframe: Explore initial data characteristics and structure.
3) Clean Dataframe: Handle missing values, negative values, infinite values, duplicates, and data formatting.
4) Final Checkup: Ensure data integrity after cleaning.
5) Highlight negative values: Apply custom styling to emphasize negative values.
6) Visualizing Data: Generating Heatmaps and Pairplots using Seaborn for insights.

## Visualization Techniques
---------------------------
This project focuses on the following visualization techniques:

1) Heatmaps: Displaying relationships or aggregated metrics in a matrix format.
2) Pairplots: Exploring pairwise relationships between multiple variables.

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
