-- Top 10 Months.

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
    month_number ASC


[
  {
    "month": "January  ",
    "count": "737",
    "percentage": "9.70",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "8"
  },
  {
    "month": "March    ",
    "count": "741",
    "percentage": "9.76",
    "prev_count": "737",
    "percentage_change": "0.54",
    "count_rank": "7"
  },
  {
    "month": "April    ",
    "count": "763",
    "percentage": "10.04",
    "prev_count": "741",
    "percentage_change": "2.97",
    "count_rank": "4"
  },
  {
    "month": "June     ",
    "count": "728",
    "percentage": "9.58",
    "prev_count": "763",
    "percentage_change": "-4.59",
    "count_rank": "9"
  },
  {
    "month": "July     ",
    "count": "827",
    "percentage": "10.89",
    "prev_count": "728",
    "percentage_change": "13.60",
    "count_rank": "1"
  },
  {
    "month": "August   ",
    "count": "754",
    "percentage": "9.93",
    "prev_count": "827",
    "percentage_change": "-8.83",
    "count_rank": "6"
  },
  {
    "month": "September",
    "count": "769",
    "percentage": "10.12",
    "prev_count": "754",
    "percentage_change": "1.99",
    "count_rank": "3"
  },
  {
    "month": "October  ",
    "count": "760",
    "percentage": "10.01",
    "prev_count": "769",
    "percentage_change": "-1.17",
    "count_rank": "5"
  },
  {
    "month": "November ",
    "count": "705",
    "percentage": "9.28",
    "prev_count": "760",
    "percentage_change": "-7.24",
    "count_rank": "10"
  },
  {
    "month": "December ",
    "count": "812",
    "percentage": "10.69",
    "prev_count": "705",
    "percentage_change": "15.18",
    "count_rank": "2"
  }
]