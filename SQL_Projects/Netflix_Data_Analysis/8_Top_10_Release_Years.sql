-- Top 10 Release Years..

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


[
  {
    "release_year": "2012",
    "count": "236",
    "percentage": "3.33",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "9"
  },
  {
    "release_year": "2013",
    "count": "286",
    "percentage": "4.04",
    "prev_count": "236",
    "percentage_change": "21.19",
    "count_rank": "8"
  },
  {
    "release_year": "2014",
    "count": "352",
    "percentage": "4.97",
    "prev_count": "286",
    "percentage_change": "23.08",
    "count_rank": "7"
  },
  {
    "release_year": "2015",
    "count": "555",
    "percentage": "7.84",
    "prev_count": "352",
    "percentage_change": "57.67",
    "count_rank": "6"
  },
  {
    "release_year": "2016",
    "count": "901",
    "percentage": "12.72",
    "prev_count": "555",
    "percentage_change": "62.34",
    "count_rank": "4"
  },
  {
    "release_year": "2017",
    "count": "1030",
    "percentage": "14.55",
    "prev_count": "901",
    "percentage_change": "14.32",
    "count_rank": "2"
  },
  {
    "release_year": "2018",
    "count": "1146",
    "percentage": "16.18",
    "prev_count": "1030",
    "percentage_change": "11.26",
    "count_rank": "1"
  },
  {
    "release_year": "2019",
    "count": "1030",
    "percentage": "14.55",
    "prev_count": "1146",
    "percentage_change": "-10.12",
    "count_rank": "2"
  },
  {
    "release_year": "2020",
    "count": "953",
    "percentage": "13.46",
    "prev_count": "1030",
    "percentage_change": "-7.48",
    "count_rank": "3"
  },
  {
    "release_year": "2021",
    "count": "592",
    "percentage": "8.36",
    "prev_count": "953",
    "percentage_change": "-37.88",
    "count_rank": "5"
  }
]