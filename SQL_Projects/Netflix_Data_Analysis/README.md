# Introduction 
TBC.

SQL queries? Check them out here: [sql_projects_folder](/SQL_Projects/)

# Background
TBC.

### The questions i wanted to answer through my SQL queries were:

1. What are the types of Netflix Media?
2. What are the Top 10 Directors?
3. What is the proportion Of Directors With Name Given And Name Not Given?
4. What are the Top 10 Directors excluding director Not Given?
5. What are the Top 10 Days? (LIMIT 10 was used for continuity. I know there are only 7 days!😂).
6. What are the Top 10 Months?
7. What are the Top 10 Quarters?
8. What are the Top 10 Release Years?
9. What are the Top 10 Release Years And Quarters?
10. What are the Top 10 Ratings?
11. What are the Top 10 Countries?
12. What are the Top 10 Countries By Movie Count?
13. What are the Top 10 Countries By TV Show Count?


# Tools I Used
For my deep dive into the Netflix Media Market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.


# The Analysis
Each query for this project aimed at investigating specific aspects of the Netflix Media.
Here's how I approached each question:


### 1. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Types Of Netflix Media[.sql](1_The_Count_And_Percentage_Of_Types_Of_Netflix_Media.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights the types of Netflix Media.*

```sql
WITH movie_type AS (
    SELECT
        type,
        COUNT(type) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    --WHERE
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY 
        type
),
count_formatted AS (
    SELECT
        type,
        count,
        TO_CHAR(count, 'FM999,999,999') AS formatted_count,
        ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage
        --RANK() OVER (ORDER BY count DESC) AS count_rank
    FROM 
        movie_type
    --ORDER BY 
        --count ASC
        --count DESC
)
--SELECT
    --type,
    --count,
    --ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage
    --RANK() OVER (ORDER BY count DESC) AS count_rank
SELECT
    type,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY count DESC), 0) AS prev_count,  -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY count DESC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY count DESC)) * 100.0) / LAG(count) OVER (ORDER BY count DESC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    count_formatted
ORDER BY
    --count ASC 
    count DESC;
```

### Dataframe
![Types Of Netflix Media - Table](Assets/SQL_1_The_Count_And_Percentage_Of_Types_Of_Netflix_Media.png)
*Generated using pandas library*

### Pie Chart
![Types Of Netflix Media - Pie Chart](Assets/SQL_1_Count_And_Percentage_Of_Types_Of_Netflix_Media_Pie_Chart.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**I:** Movies dominate the Netflix library, making up nearly 70% of the content.

**II:** TV Shows have seen a significant decline of 56.51% compared to the previous count.


### Trends & Implications:

**I** The sharp drop in TV Shows suggests a shift in content strategy, possibly favoring movies over series.

**II** Netflix may be focusing more on feature films, potentially due to audience preferences or production costs.


### Actionable Takeaways:

**I** Further analysis is needed to understand whether this trend aligns with viewership demand.

**II** Content strategy adjustments may be required to balance TV Show offerings if audience engagement remains high.


### 2. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Directors[.sql](2_Top_10_Directors.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights the Top 10 Directors.*

```sql
WITH directors AS (
    SELECT
        director,
        COUNT(director) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    --WHERE
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY 
        director
),
top_10 AS (
    SELECT
        director,
        count
    FROM 
        directors
    ORDER BY
        count DESC
    LIMIT 10
)
--SELECT
    --director,
    --count,
    --ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage
    --RANK() OVER (ORDER BY count DESC) AS count_rank
SELECT
    director,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY count DESC), 0) AS prev_count,  -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY count DESC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY count DESC)) * 100.0) / LAG(count) OVER (ORDER BY count DESC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    top_10;
--ORDER BY 
    --count DESC
```

### Dataframe
![Top 10 Directors - Table](Assets/SQL_2_Top_10_Directors_By_Count_And_Percentage.png)
*Generated using pandas library*

### General Overview:


### Key Insights & Interpretations:

**I** A staggering 94.90% of media entries have no director information, indicating incomplete metadata.

**II** The most credited director, Rajiv Chilaka, has seen a sharp 99.23% decline in count compared to the previous dataset.


### Trends & Implications:

**I** The lack of director attribution may affect content discovery, credibility, and analytics on directorial influence.

**II:** The decline in counts for most directors suggests possible content removals or shifts in production focus.


### Actionable Takeaways:

**I** Improving metadata completeness should be a priority to enhance data accuracy and insights.

**II** Further analysis is needed to determine if director-related trends impact audience engagement.


### 3. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of Director Name Given And Name Not Given[.sql](3_Director_Name_Given_And_Name_Not_Given.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights Director Name Given And Name Not Given.*

```sql
WITH director_name AS (
    SELECT
        CASE
            WHEN director = 'Not Given' THEN 'Name Not Given'
            ELSE 'Name Given'
        END AS director_formatted,
        COUNT(director) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    --WHERE
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY
        director_formatted
),
count_formatted AS (
    SELECT
        director_formatted,
        count,
        TO_CHAR(count, 'FM999,999,999') AS formatted_count,
        ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
        RANK() OVER (ORDER BY count DESC) AS count_rank
    FROM 
        director_name
    --ORDER BY 
        --count ASC
        --count DESC
)
--SELECT
    --director_formatted,
    --count,
    --formatted_count,
    --percentage,
    --count_rank
SELECT
    director_formatted,
    count,
    --formatted_count
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY count DESC), 0) AS prev_count,  -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY count DESC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY count DESC)) * 100.0) / LAG(count) OVER (ORDER BY count DESC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    count_formatted
ORDER BY
    --count ASC
    count DESC;
```

### Dataframe
![Director Name Given And Name Not Given - Table](Assets/SQL_3_The_Count_&_Percentage_Of_Director_Not_Given_to_Name_not_Given.png)
*Generated using pandas library*

### Pie Chart
![Director Name Given And Name Not Given - Pie Chart](Assets/SQL_2_Count_and_Percentage_of_Director_Name_Given_To_Name_Not_Given_Pie_Chart.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**I** 70.56% of Netflix content now has a named director, improving metadata completeness.

**II** Having more named directors allows for better content analysis and categorization.


### Trends & Implications:

**I** This improvement suggests an effort to enhance content metadata accuracy.

**II** Having more named directors allows for better content analysis and categorization.


### Actionable Takeaways:

**I:** Further investigation can reveal if specific genres or regions still lack director attribution.

**II:** Ensuring complete metadata should remain a priority to maximize content discoverability and analytics.


### 4. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Directors excluding director Not Given[.sql](4_Top_10_Directors_Excluding_director_Not_Given.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Directors excluding director Not Given.*

```sql
WITH directors_ng AS (
    SELECT
        director,
        COUNT(director) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    WHERE
        director NOT IN ('Not Given') -- <> '' can be used too.
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY 
        director
),
top_10 AS (
    SELECT
        director,
        count
    FROM 
        directors_ng
    ORDER BY 
        count DESC
    LIMIT 10
)
--SELECT
    --director,
    --count,
    --ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage
    --RANK() OVER (ORDER BY count) AS count_rank
SELECT
    director,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY count DESC), 0) AS prev_count,  -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY count DESC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY count DESC)) * 100.0) / LAG(count) OVER (ORDER BY count DESC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    top_10;
--ORDER BY 
    --count DESC
```

### Dataframe
![The Top 10 Directors excluding director Not Given - Table](Assets/SQL_4_Top_10_Directors_By_Count_And_Percentage_(excluding_Director_Not_Given).png)
*Generated using pandas library*

### Bar Plot
![The Top 10 Directors excluding director Not Given - Bar Plot](Assets/SQL_3_Top_10_Directors_By_Count_And_Percentage_Ex_Dir_Not_Given_Barplot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**I** Rajiv Chilaka leads with 13.25% of the attributed content, making him the most frequently credited director.

**II:** Several top directors, including Raúl Campos & Jan Suter, have seen slight declines in their content count.


### Trends & Implications:

**I** The dominance of a few directors suggests that Netflix may have repeat collaborations with certain filmmakers.

**II** The presence of renowned names like Martin Scorsese highlights a mix of mainstream and niche content.


### Actionable Takeaways:

**I** Further analysis is needed to determine if certain genres or regions drive these top director counts.

**II** Monitoring trends in director contributions can offer insights into Netflix’s evolving content strategy


### 5. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Days[.sql](5_Top_10_Days.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Days.*

```sql
WITH release_days AS (
    SELECT
        TO_CHAR(date_added, 'FMDay') AS day,
        COUNT(*) AS count
    FROM 
        netflix_data
    --WHERE
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY 
        day
),
top_10 AS (
    SELECT
        day,
        count
    FROM 
        release_days
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    day,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY 
        CASE day
            WHEN 'Monday' THEN 1
            WHEN 'Tuesday' THEN 2
            WHEN 'Wednesday' THEN 3
            WHEN 'Thursday' THEN 4
            WHEN 'Friday' THEN 5
            WHEN 'Saturday' THEN 6
            WHEN 'Sunday' THEN 7
        END
    ), 0) AS prev_count,
    CASE 
        WHEN LAG(count) OVER (ORDER BY 
            CASE day
                WHEN 'Monday' THEN 1
                WHEN 'Tuesday' THEN 2
                WHEN 'Wednesday' THEN 3
                WHEN 'Thursday' THEN 4
                WHEN 'Friday' THEN 5
                WHEN 'Saturday' THEN 6
                WHEN 'Sunday' THEN 7
            END
        ) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY 
            CASE day
                WHEN 'Monday' THEN 1
                WHEN 'Tuesday' THEN 2
                WHEN 'Wednesday' THEN 3
                WHEN 'Thursday' THEN 4
                WHEN 'Friday' THEN 5
                WHEN 'Saturday' THEN 6
                WHEN 'Sunday' THEN 7
            END
        )) * 100.0) / LAG(count) OVER (ORDER BY 
            CASE day
                WHEN 'Monday' THEN 1
                WHEN 'Tuesday' THEN 2
                WHEN 'Wednesday' THEN 3
                WHEN 'Thursday' THEN 4
                WHEN 'Friday' THEN 5
                WHEN 'Saturday' THEN 6
                WHEN 'Sunday' THEN 7
            END
        ), 2)
        ELSE 0
    END AS percentage_change,
    RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    top_10
ORDER BY 
    CASE day
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;
```

### Dataframe
![The Top 10 Days - Table](Assets/SQL_5_Top_10_Days_By_Count_And_Percentage.png)
*Generated using pandas library*

### Bar Plot
![The Top 10 Days - Bar Plot](Assets/SQL_4_Top_10_Days_By_Count_And_Percentage_Barplot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**I** Friday has the highest content count at 28.41%, indicating it’s the most active day for releases.

**II** Saturday and Sunday see the lowest counts, suggesting reduced content activity on weekends.


### Trends & Implications:

**I** The gradual increase from Monday to Thursday suggests a buildup towards Friday’s peak.

**II** The sharp drop after Friday implies a strategic pause in releases over the weekend.


### Actionable Takeaways:

**I** Netflix could explore increasing weekend releases to balance engagement throughout the week.

**II** Further analysis could determine if content released on specific days performs better in viewership.


### 6. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Months[.sql](6_Top_10_Months.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Months.*

```sql
WITH release_months AS (
    SELECT
        EXTRACT(MONTH FROM date_added) AS month_number,
        TO_CHAR(date_added, 'Month') AS month,
        COUNT(*) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    --WHERE
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY 
        month_number,
        month
),
top_10 AS (
    SELECT
        month_number,
        month,
        count
    FROM 
        release_months
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    month,
    --month_number,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY month_number ASC), 0) AS prev_count,  -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY month_number) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY month_number ASC)) * 100.0) / LAG(count) OVER (ORDER BY month_number ASC), 2)
        ELSE 0
    END AS percentage_change,
    RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    top_10
ORDER BY 
    month_number ASC;
```

### Dataframe
![The Top 10 Months - Table](Assets/SQL_6_Top_10_Months_By_Count_And_Percentage.png)
*Generated using pandas library*

### Bar Plot
![The Top 10 Months - Bar Plot](Assets/SQL_5_Top_10_Months_By_Count_And_Percentage_Barplot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**TBC:** 

**TBC:** 

**TBC:**


### Trends & Implications:

**TBC:**

**TBC:** 

**TBC:**


### Actionable Takeaways:

**TBC:**

**TBC:**

**TBC:** 

**TBC:**


### 7. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Quarters[.sql](7_Top_10_Quarters.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Quarters.*

```sql
WITH release_quarters AS (
    SELECT
        EXTRACT(QUARTER FROM date_added) AS quarter_number,
        CONCAT('Q', EXTRACT(QUARTER FROM date_added)) AS quarter,
        COUNT(*) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    --WHERE
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY 
        quarter_number,
        quarter
),
top_10 AS (
    SELECT
        quarter_number,
        quarter,
        count
    FROM 
        release_quarters
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    quarter,
    --quarter_number,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY quarter_number ASC), 0) AS prev_count,  -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY quarter_number ASC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY quarter_number ASC)) * 100.0) / LAG(count) OVER (ORDER BY quarter_number ASC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    top_10
ORDER BY 
    quarter_number ASC;
```

### Dataframe
![The Top 10 Quarters - Table](Assets/SQL_7_Top_10_Quarters_By_Count_And_Percentage.png)
*Generated using pandas library*

### Bar Plot
![The Top 10 Quarters - Bar Plot](Assets/SQL_6_Top_10_Quarters_By_Count_And_Percentage_Barplot.png)
*Generated using seaborn library*

### Line Plot
![The Top 10 Quarters - Line Plot](Assets/SQL_7_Top_10_Quarters_By_Count_And_Percentage_Line_Plot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**TBC:** 

**TBC:** 

**TBC:**


### Trends & Implications:

**TBC:**

**TBC:** 

**TBC:**


### Actionable Takeaways:

**TBC:**

**TBC:**

**TBC:** 

**TBC:**


### 8. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Release Years[.sql](8_Top_10_Release_Years.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Release Years.*

```sql
WITH release_years AS (
    SELECT
        release_year,
        COUNT(release_year) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    --WHERE
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY 
        release_year
),
top_10 AS (
    SELECT
        release_year,
        count
    FROM 
        release_years
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    release_year,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY release_year ASC), 0) AS prev_count,  -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY release_year ASC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY release_year ASC)) * 100.0) / LAG(count) OVER (ORDER BY release_year ASC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    top_10
ORDER BY 
    release_year;
```

### Dataframe
![The Top 10 Release Years - Table](Assets/SQL_8_Top_10_Release_Years_By_Count_And_Percentage.png)
*Generated using pandas library*

### Bar Plot
![The Top 10 Release Years - Bar Plot](Assets/SQL_8_Top_10_Release_Years_By_Count_And_Percentage_Barplot.png)
*Generated using seaborn library*

### Line Plot
![The Top 10 Release Years - Line Plot](Assets/SQL_9_Top_10_Release_Years_By_Count_And_Percentage_Line_Plot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**TBC:** 

**TBC:** 

**TBC:**


### Trends & Implications:

**TBC:**

**TBC:** 

**TBC:**


### Actionable Takeaways:

**TBC:**

**TBC:**

**TBC:** 

**TBC:**


### 9. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Release Years And Quarters[.sql](9_Top_10_Release_Years_And_Quarters.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Release Years And Quarters.*

```sql
WITH release_years_and_quarters AS (
    SELECT
        release_year,
        EXTRACT(QUARTER FROM date_added) AS quarter_number,
        CONCAT('Q', EXTRACT(QUARTER FROM date_added)) AS quarter,
        COUNT(*) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    --WHERE
        --type
        --AND
        --director
        --AND
        --country
    GROUP BY 
        release_year,
        quarter_number,
        quarter
),
top_10 AS (
    SELECT
        release_year,
        quarter_number,
        quarter,
        count
    FROM 
        release_years_and_quarters
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    release_year,
    quarter,
    --quarter_number,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY release_year ASC), 0) AS prev_count,  -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY quarter_number ASC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY release_year ASC)) * 100.0) / LAG(count) OVER (ORDER BY release_year ASC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
FROM 
    top_10
ORDER BY 
    release_year ASC,
    quarter ASC
```

### Dataframe
![The Top 10 Release Years And Quarters - Table](Assets/SQL_9_Top_10_Release_Years_And_Quarters_By_Count_And_Percentage.png)
*Generated using pandas library*

### Heatmap
![The Top 10 Release Years And Quarters - Heatmap](Assets/SQL_10_Top_10_Release_Years_And_Quarters_By_Count_Of_Netflix_Media_Heatmap.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**TBC:** 

**TBC:** 

**TBC:**


### Trends & Implications:

**TBC:**

**TBC:** 

**TBC:**


### Actionable Takeaways:

**TBC:**

**TBC:**

**TBC:** 

**TBC:**


### 10. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Ratings[.sql](10_Top_10_Ratings.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Ratings.*

```sql
WITH ratings AS (
    SELECT
        rating,
        COUNT(rating) AS count --(*) counts all rows in a table, including rows with NULL values.
        --TO_CHAR(ROUND(rating, 0),'FM999,999,999') AS formatted_count
    FROM 
        netflix_data
    --WHERE 
        --EXTRACT(QUARTER FROM date_added) IN (1, 2, 3, 4)
    GROUP BY 
        rating
),
top_10 AS (
    SELECT
        rating,
        count
    FROM 
        ratings
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    rating,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY count DESC), 0) AS prev_count, -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY count DESC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY count DESC)) * 100.0) / LAG(count) OVER (ORDER BY count DESC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank   
FROM 
    top_10;
--ORDER BY 
    --count DESC
```

### Dataframe
![The Top 10 Ratings - Table](Assets/SQL_10_Top_10_Ratings_By_Count_And_Percentage_Of_Netflix_Media.png)
*Generated using pandas library*

### Pie Chart
![The Top 10 Ratings - Pie Chart](Assets/SQL_11_Top_10_Ratings_By_Count_And_Percentage_Of_Netflix_Media_Pie_Chart.png)
*Generated using seaborn library*

### Bar Plot
![The Top 10 Ratings - Bar Plot](Assets/SQL_12_Top_10_Ratings_By_Count_And_Percentage_Of_Netflix_Media_Barplot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**TBC:** 

**TBC:** 

**TBC:**


### Trends & Implications:

**TBC:**

**TBC:** 

**TBC:**


### Actionable Takeaways:

**TBC:**

**TBC:**

**TBC:** 

**TBC:**


### 11. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Countries[.sql](11_Top_10_Countries.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Countries.*

```sql
WITH countries AS (
    SELECT
        country,
        COUNT(country) AS count --(*) counts all rows in a table, including rows with NULL values.
        --TO_CHAR(ROUND(country, 0),'FM999,999,999') AS formatted_count
    FROM 
        netflix_data
    WHERE
        country NOT IN ('Not Given') -- <> '' can be used too
        --EXTRACT(QUARTER FROM date_added) IN (1, 2, 3, 4)
    GROUP BY 
        country
),
top_10 AS (
    SELECT
        country,
        count
    FROM 
        countries
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    country,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY count DESC), 0) AS prev_count, -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY count DESC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY count DESC)) * 100.0) / LAG(count) OVER (ORDER BY count DESC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
    
FROM 
    top_10;
--ORDER BY 
    --count DESC
```

### Dataframe
![The Top 10 Countries - Table](Assets/SQL_11_Top_10_Countries_By_Count_And_Percentage_Of_Neflix_Media.png)
*Generated using pandas library*

### Bar Plot
![The Top 10 Countries - Bar Plot](Assets/SQL_13_Top_10_Countries_By_Count_And_Percentage_Of_Netflix_Media_Barplot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**TBC:** 

**TBC:** 

**TBC:**


### Trends & Implications:

**TBC:**

**TBC:** 

**TBC:**


### Actionable Takeaways:

**TBC:**

**TBC:**

**TBC:** 

**TBC:**


### 12. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Countries By Movie Count[.sql](12_Top_10_Countries_By_Movie_Count.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Countries By Movie Count.*

```sql
WITH countries_movie AS (
    SELECT
        country,
        COUNT(country) AS count --(*) counts all rows in a table, including rows with NULL values.
        --TO_CHAR(ROUND(country, 0),'FM999,999,999') AS formatted_count
    FROM 
        netflix_data
    WHERE
        country NOT IN ('Not Given') -- <> '' can be used too
        AND
        type IN ('Movie')
        --EXTRACT(QUARTER FROM date_added) IN (1, 2, 3, 4)
    GROUP BY 
        country
),
top_10 AS (
    SELECT
        country,
        count
    FROM 
        countries_movie
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    country,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY count DESC), 0) AS prev_count, -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY count DESC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY count DESC)) * 100.0) / LAG(count) OVER (ORDER BY count DESC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
    
FROM 
    top_10;
--ORDER BY 
    --count DESC
```

### Dataframe
![The Top 10 Countries By Movie Count - Table](Assets/SQL_12_Top_10_Countries_By_Count_And_Percentage_Of_Neflix_Movie_Media.png)
*Generated using pandas library*

### Bar Plot
![The Top 10 Countries By Movie Count - Bar Plot](Assets/SQL_14_Top_10_Countries_By_Count_And_Percentage_Of_Netflix_Movie_Media_Barplot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**TBC:** 

**TBC:** 

**TBC:**


### Trends & Implications:

**TBC:**

**TBC:** 

**TBC:**


### Actionable Takeaways:

**TBC:**

**TBC:**

**TBC:** 

**TBC:**


### 13. 🔢The Count, 💯Percentage, ⏳Previous Count, 📈📉Percentage Change & 🏅Count Rank Of The Top 10 Countries By TV Show Count[.sql](13_Top_10_Countries_By_TV_Show_Count.sql)
To identify the Count, Percentage, Previous Count, Percentage Change & Count Rank the following functions were used: `COUNT`, `GROUP BY`, `LAG` and `DENSE_RANK`.

*This query highlights The Top 10 Countries By TV Show Count.*

```sql
WITH countries_tv AS (
    SELECT
        country,
        COUNT(country) AS count --(*) counts all rows in a table, including rows with NULL values.
        --TO_CHAR(ROUND(country, 0),'FM999,999,999') AS formatted_count
    FROM 
        netflix_data
    WHERE
        country NOT IN ('Not Given') -- <> '' can be used too
        AND
        type IN ('TV Show')
        --EXTRACT(QUARTER FROM date_added) IN (1, 2, 3, 4)
    GROUP BY 
        country
),
top_10 AS (
    SELECT
        country,
        count
    FROM 
        countries_tv
    ORDER BY 
        count DESC
    LIMIT 10
)
SELECT
    country,
    count,
    ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage,
    COALESCE(LAG(count) OVER (ORDER BY count DESC), 0) AS prev_count, -- Replacing NULL with 0,
    CASE 
        WHEN LAG(count) OVER (ORDER BY count DESC) IS NOT NULL 
        THEN ROUND(((count - LAG(count) OVER (ORDER BY count DESC)) * 100.0) / LAG(count) OVER (ORDER BY count DESC), 2)
        ELSE 0
    END AS percentage_change,
    DENSE_RANK() OVER (ORDER BY count DESC) AS count_rank
    
FROM 
    top_10;
--ORDER BY 
    --count DESC
```

### Dataframe
![The Top 10 Countries By TV Show Count - Table](Assets/SQL_13_Top_10_Countries_By_Count_And_Percentage_Of_Neflix_TV_Show_Media.png)
*Generated using pandas library*

### Bar Plot
![The Top 10 Countries By TV Show Count - Bar Plot](Assets/SQL_15_Top_10_Countries_By_Count_And_Percentage_Of_Netflix_TV_Show_Media_Barplot.png)
*Generated using seaborn library*

### General Overview:


### Key Insights & Interpretations:

**TBC:** 

**TBC:** 

**TBC:**


### Trends & Implications:

**TBC:**

**TBC:** 

**TBC:**


### Actionable Takeaways:

**TBC:**

**TBC:**

**TBC:** 

**TBC:**



# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding `WITH` clauses for ninja-level temp table manoeuvres.
- **📊 Data Aggregation:** Got cozy with `GROUP BY` and turned aggregate functions like `COUNT()` and `AVG()` into my data-summarising sidekicks.
- **💡Analystical Wizardry:** Leveled up my real-world puzzle solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions


### Insights
From the analysis, several insights emerged:

1. **TBC:** TBC.
2. **TBC:** TBC.
3. **TBC:** TBC.
4. **TBC:** TBC.
5. **TBC:** TBC.


### Closing Thoughts
TBC.
