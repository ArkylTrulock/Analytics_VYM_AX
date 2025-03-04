-- Top 10 Directors By Count And Percentage (excluding director 'Not Given')...

WITH directors_ng AS (
    SELECT
        director,
        COUNT(director) AS count --(*) counts all rows in a table, including rows with NULL values.
    FROM 
        netflix_data
    WHERE
        director NOT IN ('Not Given') -- <> '' can be used too.
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
        directors_ng
    ORDER BY 
        count DESC
    LIMIT 10
)
--SELECT
    --director,
    --count,
    --ROUND((count * 100.0) / SUM(count) OVER (), 2) AS percentage
    --RANK() OVER (ORDER BY count) AS count_rank
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
    "director": "Rajiv Chilaka",
    "count": "20",
    "percentage": "13.25",
    "prev_count": "0",
    "percentage_change": "0",
    "count_rank": "1"
  },
  {
    "director": "Raúl Campos, Jan Suter",
    "count": "18",
    "percentage": "11.92",
    "prev_count": "20",
    "percentage_change": "-10.00",
    "count_rank": "2"
  },
  {
    "director": "Alastair Fothergill",
    "count": "18",
    "percentage": "11.92",
    "prev_count": "18",
    "percentage_change": "0.00",
    "count_rank": "2"
  },
  {
    "director": "Suhas Kadav",
    "count": "16",
    "percentage": "10.60",
    "prev_count": "18",
    "percentage_change": "-11.11",
    "count_rank": "3"
  },
  {
    "director": "Marcus Raboy",
    "count": "16",
    "percentage": "10.60",
    "prev_count": "16",
    "percentage_change": "0.00",
    "count_rank": "3"
  },
  {
    "director": "Jay Karas",
    "count": "14",
    "percentage": "9.27",
    "prev_count": "16",
    "percentage_change": "-12.50",
    "count_rank": "4"
  },
  {
    "director": "Cathy Garcia-Molina",
    "count": "13",
    "percentage": "8.61",
    "prev_count": "14",
    "percentage_change": "-7.14",
    "count_rank": "5"
  },
  {
    "director": "Jay Chapman",
    "count": "12",
    "percentage": "7.95",
    "prev_count": "13",
    "percentage_change": "-7.69",
    "count_rank": "6"
  },
  {
    "director": "Youssef Chahine",
    "count": "12",
    "percentage": "7.95",
    "prev_count": "12",
    "percentage_change": "0.00",
    "count_rank": "6"
  },
  {
    "director": "Martin Scorsese",
    "count": "12",
    "percentage": "7.95",
    "prev_count": "12",
    "percentage_change": "0.00",
    "count_rank": "6"
  }
]