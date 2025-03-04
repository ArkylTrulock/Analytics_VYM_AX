-- Top 10 Directors.

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
    top_10
--ORDER BY 
    --count DESC

[
  {
    "director": "Not Given",
    "count": "2588",
    "percentage": "94.90",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "1"
  },
  {
    "director": "Rajiv Chilaka",
    "count": "20",
    "percentage": "0.73",
    "prev_count": "2588",
    "percentage_change": "-99.23",
    "count_rank": "2"
  },
  {
    "director": "Raúl Campos, Jan Suter",
    "count": "18",
    "percentage": "0.66",
    "prev_count": "20",
    "percentage_change": "-10.00",
    "count_rank": "3"
  },
  {
    "director": "Alastair Fothergill",
    "count": "18",
    "percentage": "0.66",
    "prev_count": "18",
    "percentage_change": "0.00",
    "count_rank": "3"
  },
  {
    "director": "Suhas Kadav",
    "count": "16",
    "percentage": "0.59",
    "prev_count": "18",
    "percentage_change": "-11.11",
    "count_rank": "4"
  },
  {
    "director": "Marcus Raboy",
    "count": "16",
    "percentage": "0.59",
    "prev_count": "16",
    "percentage_change": "0.00",
    "count_rank": "4"
  },
  {
    "director": "Jay Karas",
    "count": "14",
    "percentage": "0.51",
    "prev_count": "16",
    "percentage_change": "-12.50",
    "count_rank": "5"
  },
  {
    "director": "Cathy Garcia-Molina",
    "count": "13",
    "percentage": "0.48",
    "prev_count": "14",
    "percentage_change": "-7.14",
    "count_rank": "6"
  },
  {
    "director": "Jay Chapman",
    "count": "12",
    "percentage": "0.44",
    "prev_count": "13",
    "percentage_change": "-7.69",
    "count_rank": "7"
  },
  {
    "director": "Youssef Chahine",
    "count": "12",
    "percentage": "0.44",
    "prev_count": "12",
    "percentage_change": "0.00",
    "count_rank": "7"
  }
]