-- Top 10 Ratings..

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


[
  {
    "rating": "TV-MA",
    "count": "3205",
    "percentage": "36.68",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "1"
  },
  {
    "rating": "TV-14",
    "count": "2157",
    "percentage": "24.69",
    "prev_count": "3205",
    "percentage_change": "-32.70",
    "count_rank": "2"
  },
  {
    "rating": "TV-PG",
    "count": "861",
    "percentage": "9.85",
    "prev_count": "2157",
    "percentage_change": "-60.08",
    "count_rank": "3"
  },
  {
    "rating": "R",
    "count": "799",
    "percentage": "9.15",
    "prev_count": "861",
    "percentage_change": "-7.20",
    "count_rank": "4"
  },
  {
    "rating": "PG-13",
    "count": "490",
    "percentage": "5.61",
    "prev_count": "799",
    "percentage_change": "-38.67",
    "count_rank": "5"
  },
  {
    "rating": "TV-Y7",
    "count": "333",
    "percentage": "3.81",
    "prev_count": "490",
    "percentage_change": "-32.04",
    "count_rank": "6"
  },
  {
    "rating": "TV-Y",
    "count": "306",
    "percentage": "3.50",
    "prev_count": "333",
    "percentage_change": "-8.11",
    "count_rank": "7"
  },
  {
    "rating": "PG",
    "count": "287",
    "percentage": "3.28",
    "prev_count": "306",
    "percentage_change": "-6.21",
    "count_rank": "8"
  },
  {
    "rating": "TV-G",
    "count": "220",
    "percentage": "2.52",
    "prev_count": "287",
    "percentage_change": "-23.34",
    "count_rank": "9"
  },
  {
    "rating": "NR",
    "count": "79",
    "percentage": "0.90",
    "prev_count": "220",
    "percentage_change": "-64.09",
    "count_rank": "10"
  }
]