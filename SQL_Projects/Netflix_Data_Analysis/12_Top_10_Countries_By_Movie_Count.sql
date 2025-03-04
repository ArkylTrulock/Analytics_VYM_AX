-- Top 10 Countries By Movie Count

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


[
  {
    "country": "United States",
    "count": "2395",
    "percentage": "52.02",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "1"
  },
  {
    "country": "India",
    "count": "976",
    "percentage": "21.20",
    "prev_count": "2395",
    "percentage_change": "-59.25",
    "count_rank": "2"
  },
  {
    "country": "United Kingdom",
    "count": "387",
    "percentage": "8.41",
    "prev_count": "976",
    "percentage_change": "-60.35",
    "count_rank": "3"
  },
  {
    "country": "Canada",
    "count": "187",
    "percentage": "4.06",
    "prev_count": "387",
    "percentage_change": "-51.68",
    "count_rank": "4"
  },
  {
    "country": "France",
    "count": "148",
    "percentage": "3.21",
    "prev_count": "187",
    "percentage_change": "-20.86",
    "count_rank": "5"
  },
  {
    "country": "Spain",
    "count": "129",
    "percentage": "2.80",
    "prev_count": "148",
    "percentage_change": "-12.84",
    "count_rank": "6"
  },
  {
    "country": "Egypt",
    "count": "109",
    "percentage": "2.37",
    "prev_count": "129",
    "percentage_change": "-15.50",
    "count_rank": "7"
  },
  {
    "country": "Nigeria",
    "count": "96",
    "percentage": "2.09",
    "prev_count": "109",
    "percentage_change": "-11.93",
    "count_rank": "8"
  },
  {
    "country": "Mexico",
    "count": "90",
    "percentage": "1.95",
    "prev_count": "96",
    "percentage_change": "-6.25",
    "count_rank": "9"
  },
  {
    "country": "Japan",
    "count": "87",
    "percentage": "1.89",
    "prev_count": "90",
    "percentage_change": "-3.33",
    "count_rank": "10"
  }
]