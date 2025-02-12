/*
Questions: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions..
- Focus on roles with specified salaries, regardless of location..
- Why? It helps reveal how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to aquire or improve..
*/

WITH top_paying_skills AS(
    SELECT
        sd.skills AS skills,
        sd.skill_id AS skill_id,
        COUNT(sjd.job_id) AS demand_count,
        TO_CHAR(COUNT(sjd.job_id), 'FM999,999,999') AS formatted_count,
        ROUND(AVG(jpf.salary_year_avg),0) AS avg_yearly_sal,
        TO_CHAR(ROUND(AVG(salary_year_avg), 0),'FM999,999,999') AS formatted_salary,
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
    -- ORDER BY
    --     avg_yearly_sal DESC
)
SELECT
    skills,
    skill_id,
    formatted_count,
    formatted_salary,
    count_rank,
    salary_rank
FROM
    top_paying_skills
ORDER BY
    avg_yearly_sal DESC
LIMIT
    25;

[
  {
    "skills": "pyspark",
    "skill_id": 95,
    "formatted_count": "2",
    "formatted_salary": "208,172",
    "count_rank": "82",
    "salary_rank": "1"
  },
  {
    "skills": "bitbucket",
    "skill_id": 218,
    "formatted_count": "2",
    "formatted_salary": "189,155",
    "count_rank": "82",
    "salary_rank": "2"
  },
  {
    "skills": "couchbase",
    "skill_id": 65,
    "formatted_count": "1",
    "formatted_salary": "160,515",
    "count_rank": "96",
    "salary_rank": "3"
  },
  {
    "skills": "watson",
    "skill_id": 85,
    "formatted_count": "1",
    "formatted_salary": "160,515",
    "count_rank": "96",
    "salary_rank": "3"
  },
  {
    "skills": "datarobot",
    "skill_id": 206,
    "formatted_count": "1",
    "formatted_salary": "155,486",
    "count_rank": "96",
    "salary_rank": "5"
  },
  {
    "skills": "gitlab",
    "skill_id": 220,
    "formatted_count": "3",
    "formatted_salary": "154,500",
    "count_rank": "72",
    "salary_rank": "6"
  },
  {
    "skills": "swift",
    "skill_id": 35,
    "formatted_count": "2",
    "formatted_salary": "153,750",
    "count_rank": "82",
    "salary_rank": "7"
  },
  {
    "skills": "jupyter",
    "skill_id": 102,
    "formatted_count": "3",
    "formatted_salary": "152,777",
    "count_rank": "72",
    "salary_rank": "8"
  },
  {
    "skills": "pandas",
    "skill_id": 93,
    "formatted_count": "9",
    "formatted_salary": "151,821",
    "count_rank": "42",
    "salary_rank": "9"
  },
  {
    "skills": "elasticsearch",
    "skill_id": 59,
    "formatted_count": "1",
    "formatted_salary": "145,000",
    "count_rank": "96",
    "salary_rank": "10"
  },
  {
    "skills": "golang",
    "skill_id": 27,
    "formatted_count": "1",
    "formatted_salary": "145,000",
    "count_rank": "96",
    "salary_rank": "10"
  },
  {
    "skills": "numpy",
    "skill_id": 94,
    "formatted_count": "5",
    "formatted_salary": "143,513",
    "count_rank": "52",
    "salary_rank": "12"
  },
  {
    "skills": "databricks",
    "skill_id": 75,
    "formatted_count": "10",
    "formatted_salary": "141,907",
    "count_rank": "38",
    "salary_rank": "13"
  },
  {
    "skills": "linux",
    "skill_id": 169,
    "formatted_count": "2",
    "formatted_salary": "136,508",
    "count_rank": "82",
    "salary_rank": "14"
  },
  {
    "skills": "kubernetes",
    "skill_id": 213,
    "formatted_count": "2",
    "formatted_salary": "132,500",
    "count_rank": "82",
    "salary_rank": "15"
  },
  {
    "skills": "atlassian",
    "skill_id": 219,
    "formatted_count": "5",
    "formatted_salary": "131,162",
    "count_rank": "52",
    "salary_rank": "16"
  },
  {
    "skills": "twilio",
    "skill_id": 250,
    "formatted_count": "1",
    "formatted_salary": "127,000",
    "count_rank": "96",
    "salary_rank": "17"
  },
  {
    "skills": "airflow",
    "skill_id": 96,
    "formatted_count": "5",
    "formatted_salary": "126,103",
    "count_rank": "52",
    "salary_rank": "18"
  },
  {
    "skills": "scikit-learn",
    "skill_id": 106,
    "formatted_count": "2",
    "formatted_salary": "125,781",
    "count_rank": "82",
    "salary_rank": "19"
  },
  {
    "skills": "jenkins",
    "skill_id": 211,
    "formatted_count": "3",
    "formatted_salary": "125,436",
    "count_rank": "72",
    "salary_rank": "20"
  },
  {
    "skills": "notion",
    "skill_id": 238,
    "formatted_count": "1",
    "formatted_salary": "125,000",
    "count_rank": "96",
    "salary_rank": "21"
  },
  {
    "skills": "scala",
    "skill_id": 3,
    "formatted_count": "5",
    "formatted_salary": "124,903",
    "count_rank": "52",
    "salary_rank": "22"
  },
  {
    "skills": "postgresql",
    "skill_id": 57,
    "formatted_count": "4",
    "formatted_salary": "123,879",
    "count_rank": "63",
    "salary_rank": "23"
  },
  {
    "skills": "gcp",
    "skill_id": 81,
    "formatted_count": "3",
    "formatted_salary": "122,500",
    "count_rank": "72",
    "salary_rank": "24"
  },
  {
    "skills": "microstrategy",
    "skill_id": 191,
    "formatted_count": "2",
    "formatted_salary": "121,619",
    "count_rank": "82",
    "salary_rank": "25"
  }
]