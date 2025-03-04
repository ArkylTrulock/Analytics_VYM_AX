-- Top 10 Countries.

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


[
  {
    "country": "United States",
    "count": "3240",
    "percentage": "48.85",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "1"
  },
  {
    "country": "India",
    "count": "1057",
    "percentage": "15.94",
    "prev_count": "3240",
    "percentage_change": "-67.38",
    "count_rank": "2"
  },
  {
    "country": "United Kingdom",
    "count": "638",
    "percentage": "9.62",
    "prev_count": "1057",
    "percentage_change": "-39.64",
    "count_rank": "3"
  },
  {
    "country": "Pakistan",
    "count": "421",
    "percentage": "6.35",
    "prev_count": "638",
    "percentage_change": "-34.01",
    "count_rank": "4"
  },
  {
    "country": "Canada",
    "count": "271",
    "percentage": "4.09",
    "prev_count": "421",
    "percentage_change": "-35.63",
    "count_rank": "5"
  },
  {
    "country": "Japan",
    "count": "259",
    "percentage": "3.90",
    "prev_count": "271",
    "percentage_change": "-4.43",
    "count_rank": "6"
  },
  {
    "country": "South Korea",
    "count": "214",
    "percentage": "3.23",
    "prev_count": "259",
    "percentage_change": "-17.37",
    "count_rank": "7"
  },
  {
    "country": "France",
    "count": "213",
    "percentage": "3.21",
    "prev_count": "214",
    "percentage_change": "-0.47",
    "count_rank": "8"
  },
  {
    "country": "Spain",
    "count": "182",
    "percentage": "2.74",
    "prev_count": "213",
    "percentage_change": "-14.55",
    "count_rank": "9"
  },
  {
    "country": "Mexico",
    "count": "138",
    "percentage": "2.08",
    "prev_count": "182",
    "percentage_change": "-24.18",
    "count_rank": "10"
  }
]