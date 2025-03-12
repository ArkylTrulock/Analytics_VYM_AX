# `Data Visualisation - Categorical Distribution Plot`.
------------------------------------------------------
A categorical distribution plot is used to represent data that falls into distinct categories, allowing us to visualize the distribution, frequency, and outliers within each category. This project provides a streamlined approach for loading, cleaning, and visualizing categorical data distributions using various plotting techniques.

## Suitable Data Types for Categorical Distribution Plots
---------------------------------------------------------
Categorical distribution plots are ideal for representing data where values fall into a set of categories, such as:

1) Nominal Data - Categorical data without an intrinsic order (e.g., gender, region).
2) Ordinal Data - Categorical data with a meaningful order but without consistent intervals (e.g., satisfaction ratings, education levels).
3) Discrete Data - Countable data, often used with categories (e.g., number of items purchased by category).

## Project Overview
-------------------
This project provides a structured workflow to load, clean, and visualize categorical data, creating plots to uncover insights into data distribution, identify patterns, and highlight outliers. Using popular libraries like Pandas, Matplotlib, and Seaborn, it offers a flexible approach for a variety of categorical datasets.

## Project Workflow
-------------------
1) Load Dataframe: Import the data into a pandas DataFrame.
2) Analyse Dataframe: Explore initial data characteristics and structure.
3) Clean Dataframe: Handle missing values, negative values, infinite values, duplicates, and data formatting.
4) Final Checkup: Ensure data integrity after cleaning.
5) Highlight negative values: Apply custom styling to emphasize negative values.
6) Use Matplotlib and Seaborn to generate plots, including box plots, boxen plots, and violin plots, for in-depth visualization of categorical data distributions.

## Visualization Techniques
---------------------------
This project showcases several powerful visualization tools for categorical data, including:

1) Matplotlib Box Plot: Ideal for visualizing distribution and detecting outliers within each category.
2) Seaborn Boxen Plot: Effective for high-level categorical data insights.
3) Seaborn Violin Plot: Combines aspects of box plots and density plots to reveal distribution patterns.

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
