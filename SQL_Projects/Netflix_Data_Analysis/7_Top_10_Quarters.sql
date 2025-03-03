-- Top 10 Quarters

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


[
  {
    "quarter": "Q1",
    "count": "2040",
    "percentage": "23.21",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "4"
  },
  {
    "quarter": "Q2",
    "count": "2123",
    "percentage": "24.15",
    "prev_count": "2040",
    "percentage_change": "4.07",
    "count_rank": "3"
  },
  {
    "quarter": "Q3",
    "count": "2350",
    "percentage": "26.73",
    "prev_count": "2123",
    "percentage_change": "10.69",
    "count_rank": "1"
  },
  {
    "quarter": "Q4",
    "count": "2277",
    "percentage": "25.90",
    "prev_count": "2350",
    "percentage_change": "-3.11",
    "count_rank": "2"
  }
]