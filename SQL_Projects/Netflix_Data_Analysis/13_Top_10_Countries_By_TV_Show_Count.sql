-- Top 10 Countries By TV Show Count..

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


[
  {
    "country": "United States",
    "count": "845",
    "percentage": "39.54",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "1"
  },
  {
    "country": "Pakistan",
    "count": "350",
    "percentage": "16.38",
    "prev_count": "845",
    "percentage_change": "-58.58",
    "count_rank": "2"
  },
  {
    "country": "United Kingdom",
    "count": "251",
    "percentage": "11.75",
    "prev_count": "350",
    "percentage_change": "-28.29",
    "count_rank": "3"
  },
  {
    "country": "Japan",
    "count": "172",
    "percentage": "8.05",
    "prev_count": "251",
    "percentage_change": "-31.47",
    "count_rank": "4"
  },
  {
    "country": "South Korea",
    "count": "165",
    "percentage": "7.72",
    "prev_count": "172",
    "percentage_change": "-4.07",
    "count_rank": "5"
  },
  {
    "country": "Canada",
    "count": "84",
    "percentage": "3.93",
    "prev_count": "165",
    "percentage_change": "-49.09",
    "count_rank": "6"
  },
  {
    "country": "India",
    "count": "81",
    "percentage": "3.79",
    "prev_count": "84",
    "percentage_change": "-3.57",
    "count_rank": "7"
  },
  {
    "country": "Taiwan",
    "count": "71",
    "percentage": "3.32",
    "prev_count": "81",
    "percentage_change": "-12.35",
    "count_rank": "8"
  },
  {
    "country": "France",
    "count": "65",
    "percentage": "3.04",
    "prev_count": "71",
    "percentage_change": "-8.45",
    "count_rank": "9"
  },
  {
    "country": "Australia",
    "count": "53",
    "percentage": "2.48",
    "prev_count": "65",
    "percentage_change": "-18.46",
    "count_rank": "10"
  }
]