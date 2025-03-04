-- Director Name Given And Name Not Given

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
    count DESC

[
  {
    "director_formatted": "Name Given",
    "count": "6202",
    "percentage": "70.56",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "1"
  },
  {
    "director_formatted": "Name Not Given",
    "count": "2588",
    "percentage": "29.44",
    "prev_count": "6202",
    "percentage_change": "-58.27",
    "count_rank": "2"
  }
]