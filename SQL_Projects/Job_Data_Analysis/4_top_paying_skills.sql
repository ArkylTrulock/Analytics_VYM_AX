/*
Questions: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions......
- Focus on roles with specified salaries, regardless of location......
- Why? It helps reveal how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to aquire or improve...........
*/

WITH top_demanded_skills AS(
    SELECT
    sd.skills AS skills,
    sd.skill_id AS skill_id,
    COUNT(sjd.job_id) AS demand_count,
    TO_CHAR(COUNT(sjd.job_id), 'FM999,999,999') AS formatted_count,
    AVG(jpf.salary_year_avg) AS avg_yearly_sal,
    --COALESCE((AVG(jpf.salary_year_avg) * 100.0 / SUM(AVG(jpf.salary_year_avg)) OVER ()), 0) AS avg_yearly_sal_percentage,
    COALESCE(AVG(jpf.salary_year_avg) - LAG(AVG(jpf.salary_year_avg)) OVER (ORDER BY AVG(jpf.salary_year_avg) DESC), 0) AS avg_yearly_sal_change,
    COALESCE(ROUND(((AVG(jpf.salary_year_avg) - LAG(AVG(jpf.salary_year_avg)) OVER (ORDER BY AVG(jpf.salary_year_avg) DESC)) 
        / NULLIF(LAG(AVG(jpf.salary_year_avg)) OVER (ORDER BY AVG(jpf.salary_year_avg) DESC), 0)) * 100, 2), 0) AS avg_yearly_sal_change_percentage, -- AVG() Already Returns a DECIMAL.
    TO_CHAR(ROUND(AVG(jpf.salary_year_avg), 0),'FM999,999,999') AS formatted_salary,
    RANK() OVER (ORDER BY (ROUND(COUNT(sjd.job_id)),0) DESC) AS count_rank,
    RANK() OVER (ORDER BY ROUND(AVG(jpf.salary_year_avg),0) DESC) AS salary_rank
    FROM 
        job_postings_fact AS jpf
    INNER JOIN 
        skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN 
        skills_dim AS sd ON sjd.skill_id = sd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst' AND
        jpf.job_work_from_home = TRUE AND
        jpf.salary_year_avg IS NOT NULL
    GROUP BY -- Use when aggregating (COUNT, SUM, AVG etc..)
        sd.skills,
        sd.skill_id
    ORDER BY
        --demand_count DESC
        avg_yearly_sal DESC
)
SELECT
    skills,
    skill_id,
    demand_count,
    count_rank,
    --formatted_count,
    --avg_yearly_sal_percentage,
    avg_yearly_sal,
    salary_rank,
    avg_yearly_sal_change,
    avg_yearly_sal_change_percentage
    --formatted_salary,     
FROM
    top_demanded_skills
LIMIT
    25;

[
  {
    "skills": "pyspark",
    "skill_id": 95,
    "demand_count": "2",
    "count_rank": "82",
    "avg_yearly_sal": "208172.250000000000",
    "salary_rank": "1",
    "avg_yearly_sal_change": "0",
    "avg_yearly_sal_change_percentage": "0"
  },
  {
    "skills": "bitbucket",
    "skill_id": 218,
    "demand_count": "2",
    "count_rank": "82",
    "avg_yearly_sal": "189154.500000000000",
    "salary_rank": "2",
    "avg_yearly_sal_change": "-19017.750000000000",
    "avg_yearly_sal_change_percentage": "-9.14"
  },
  {
    "skills": "watson",
    "skill_id": 85,
    "demand_count": "1",
    "count_rank": "96",
    "avg_yearly_sal": "160515.000000000000",
    "salary_rank": "3",
    "avg_yearly_sal_change": "-28639.500000000000",
    "avg_yearly_sal_change_percentage": "-15.14"
  },
  {
    "skills": "couchbase",
    "skill_id": 65,
    "demand_count": "1",
    "count_rank": "96",
    "avg_yearly_sal": "160515.000000000000",
    "salary_rank": "3",
    "avg_yearly_sal_change": "0.000000000000",
    "avg_yearly_sal_change_percentage": "0.00"
  },
  {
    "skills": "datarobot",
    "skill_id": 206,
    "demand_count": "1",
    "count_rank": "96",
    "avg_yearly_sal": "155485.500000000000",
    "salary_rank": "5",
    "avg_yearly_sal_change": "-5029.500000000000",
    "avg_yearly_sal_change_percentage": "-3.13"
  },
  {
    "skills": "gitlab",
    "skill_id": 220,
    "demand_count": "3",
    "count_rank": "72",
    "avg_yearly_sal": "154500.000000000000",
    "salary_rank": "6",
    "avg_yearly_sal_change": "-985.500000000000",
    "avg_yearly_sal_change_percentage": "-0.63"
  },
  {
    "skills": "swift",
    "skill_id": 35,
    "demand_count": "2",
    "count_rank": "82",
    "avg_yearly_sal": "153750.000000000000",
    "salary_rank": "7",
    "avg_yearly_sal_change": "-750.000000000000",
    "avg_yearly_sal_change_percentage": "-0.49"
  },
  {
    "skills": "jupyter",
    "skill_id": 102,
    "demand_count": "3",
    "count_rank": "72",
    "avg_yearly_sal": "152776.500000000000",
    "salary_rank": "8",
    "avg_yearly_sal_change": "-973.500000000000",
    "avg_yearly_sal_change_percentage": "-0.63"
  },
  {
    "skills": "pandas",
    "skill_id": 93,
    "demand_count": "9",
    "count_rank": "42",
    "avg_yearly_sal": "151821.333333333333",
    "salary_rank": "9",
    "avg_yearly_sal_change": "-955.166666666667",
    "avg_yearly_sal_change_percentage": "-0.63"
  },
  {
    "skills": "elasticsearch",
    "skill_id": 59,
    "demand_count": "1",
    "count_rank": "96",
    "avg_yearly_sal": "145000.000000000000",
    "salary_rank": "10",
    "avg_yearly_sal_change": "-6821.333333333333",
    "avg_yearly_sal_change_percentage": "-4.49"
  },
  {
    "skills": "golang",
    "skill_id": 27,
    "demand_count": "1",
    "count_rank": "96",
    "avg_yearly_sal": "145000.000000000000",
    "salary_rank": "10",
    "avg_yearly_sal_change": "0.000000000000",
    "avg_yearly_sal_change_percentage": "0.00"
  },
  {
    "skills": "numpy",
    "skill_id": 94,
    "demand_count": "5",
    "count_rank": "52",
    "avg_yearly_sal": "143512.500000000000",
    "salary_rank": "12",
    "avg_yearly_sal_change": "-1487.500000000000",
    "avg_yearly_sal_change_percentage": "-1.03"
  },
  {
    "skills": "databricks",
    "skill_id": 75,
    "demand_count": "10",
    "count_rank": "38",
    "avg_yearly_sal": "141906.600000000000",
    "salary_rank": "13",
    "avg_yearly_sal_change": "-1605.900000000000",
    "avg_yearly_sal_change_percentage": "-1.12"
  },
  {
    "skills": "linux",
    "skill_id": 169,
    "demand_count": "2",
    "count_rank": "82",
    "avg_yearly_sal": "136507.500000000000",
    "salary_rank": "14",
    "avg_yearly_sal_change": "-5399.100000000000",
    "avg_yearly_sal_change_percentage": "-3.80"
  },
  {
    "skills": "kubernetes",
    "skill_id": 213,
    "demand_count": "2",
    "count_rank": "82",
    "avg_yearly_sal": "132500.000000000000",
    "salary_rank": "15",
    "avg_yearly_sal_change": "-4007.500000000000",
    "avg_yearly_sal_change_percentage": "-2.94"
  },
  {
    "skills": "atlassian",
    "skill_id": 219,
    "demand_count": "5",
    "count_rank": "52",
    "avg_yearly_sal": "131161.800000000000",
    "salary_rank": "16",
    "avg_yearly_sal_change": "-1338.200000000000",
    "avg_yearly_sal_change_percentage": "-1.01"
  },
  {
    "skills": "twilio",
    "skill_id": 250,
    "demand_count": "1",
    "count_rank": "96",
    "avg_yearly_sal": "127000.000000000000",
    "salary_rank": "17",
    "avg_yearly_sal_change": "-4161.800000000000",
    "avg_yearly_sal_change_percentage": "-3.17"
  },
  {
    "skills": "airflow",
    "skill_id": 96,
    "demand_count": "5",
    "count_rank": "52",
    "avg_yearly_sal": "126103.000000000000",
    "salary_rank": "18",
    "avg_yearly_sal_change": "-897.000000000000",
    "avg_yearly_sal_change_percentage": "-0.71"
  },
  {
    "skills": "scikit-learn",
    "skill_id": 106,
    "demand_count": "2",
    "count_rank": "82",
    "avg_yearly_sal": "125781.250000000000",
    "salary_rank": "19",
    "avg_yearly_sal_change": "-321.750000000000",
    "avg_yearly_sal_change_percentage": "-0.26"
  },
  {
    "skills": "jenkins",
    "skill_id": 211,
    "demand_count": "3",
    "count_rank": "72",
    "avg_yearly_sal": "125436.333333333333",
    "salary_rank": "20",
    "avg_yearly_sal_change": "-344.916666666667",
    "avg_yearly_sal_change_percentage": "-0.27"
  },
  {
    "skills": "notion",
    "skill_id": 238,
    "demand_count": "1",
    "count_rank": "96",
    "avg_yearly_sal": "125000.000000000000",
    "salary_rank": "21",
    "avg_yearly_sal_change": "-436.333333333333",
    "avg_yearly_sal_change_percentage": "-0.35"
  },
  {
    "skills": "scala",
    "skill_id": 3,
    "demand_count": "5",
    "count_rank": "52",
    "avg_yearly_sal": "124903.000000000000",
    "salary_rank": "22",
    "avg_yearly_sal_change": "-97.000000000000",
    "avg_yearly_sal_change_percentage": "-0.08"
  },
  {
    "skills": "postgresql",
    "skill_id": 57,
    "demand_count": "4",
    "count_rank": "63",
    "avg_yearly_sal": "123878.750000000000",
    "salary_rank": "23",
    "avg_yearly_sal_change": "-1024.250000000000",
    "avg_yearly_sal_change_percentage": "-0.82"
  },
  {
    "skills": "gcp",
    "skill_id": 81,
    "demand_count": "3",
    "count_rank": "72",
    "avg_yearly_sal": "122500.000000000000",
    "salary_rank": "24",
    "avg_yearly_sal_change": "-1378.750000000000",
    "avg_yearly_sal_change_percentage": "-1.11"
  },
  {
    "skills": "microstrategy",
    "skill_id": 191,
    "demand_count": "2",
    "count_rank": "82",
    "avg_yearly_sal": "121619.250000000000",
    "salary_rank": "25",
    "avg_yearly_sal_change": "-880.750000000000",
    "avg_yearly_sal_change_percentage": "-0.72"
  }
]