-- Top 10 Days..

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

[
  {
    "day": "Monday",
    "count": "850",
    "percentage": "9.67",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "5"
  },
  {
    "day": "Tuesday",
    "count": "1196",
    "percentage": "13.61",
    "prev_count": "850",
    "percentage_change": "40.71",
    "count_rank": "4"
  },
  {
    "day": "Wednesday",
    "count": "1287",
    "percentage": "14.64",
    "prev_count": "1196",
    "percentage_change": "7.61",
    "count_rank": "3"
  },
  {
    "day": "Thursday",
    "count": "1393",
    "percentage": "15.85",
    "prev_count": "1287",
    "percentage_change": "8.24",
    "count_rank": "2"
  },
  {
    "day": "Friday",
    "count": "2497",
    "percentage": "28.41",
    "prev_count": "1393",
    "percentage_change": "79.25",
    "count_rank": "1"
  },
  {
    "day": "Saturday",
    "count": "816",
    "percentage": "9.28",
    "prev_count": "2497",
    "percentage_change": "-67.32",
    "count_rank": "6"
  },
  {
    "day": "Sunday",
    "count": "751",
    "percentage": "8.54",
    "prev_count": "816",
    "percentage_change": "-7.97",
    "count_rank": "7"
  }
]