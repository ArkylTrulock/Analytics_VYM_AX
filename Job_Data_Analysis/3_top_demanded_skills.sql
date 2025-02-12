/*
Questions: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2.
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

WITH top_demanded_skills AS(
    SELECT
    sd.skills AS skills,
    sd.skill_id AS skill_id,
    COUNT(sjd.job_id) AS demand_count,
    TO_CHAR(COUNT(sjd.job_id), 'FM999,999,999') AS formatted_count,
    AVG(jpf.salary_year_avg) AS avg_yearly_sal,
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
    --     demand_count DESC
)
SELECT
    skills,
    skill_id,
    formatted_count,
    formatted_salary,
    count_rank,
    salary_rank  
FROM
    top_demanded_skills
ORDER BY
    demand_count DESC
LIMIT
    25;

[
  {
    "skills": "sql",
    "skill_id": 0,
    "formatted_count": "398",
    "formatted_salary": "97,237",
    "count_rank": "1",
    "salary_rank": "62"
  },
  {
    "skills": "excel",
    "skill_id": 181,
    "formatted_count": "256",
    "formatted_salary": "87,288",
    "count_rank": "2",
    "salary_rank": "86"
  },
  {
    "skills": "python",
    "skill_id": 1,
    "formatted_count": "236",
    "formatted_salary": "101,397",
    "count_rank": "3",
    "salary_rank": "47"
  },
  {
    "skills": "tableau",
    "skill_id": 182,
    "formatted_count": "230",
    "formatted_salary": "99,288",
    "count_rank": "4",
    "salary_rank": "51"
  },
  {
    "skills": "r",
    "skill_id": 5,
    "formatted_count": "148",
    "formatted_salary": "100,499",
    "count_rank": "5",
    "salary_rank": "48"
  },
  {
    "skills": "power bi",
    "skill_id": 183,
    "formatted_count": "110",
    "formatted_salary": "97,431",
    "count_rank": "6",
    "salary_rank": "61"
  },
  {
    "skills": "sas",
    "skill_id": 7,
    "formatted_count": "63",
    "formatted_salary": "98,902",
    "count_rank": "7",
    "salary_rank": "56"
  },
  {
    "skills": "sas",
    "skill_id": 186,
    "formatted_count": "63",
    "formatted_salary": "98,902",
    "count_rank": "7",
    "salary_rank": "56"
  },
  {
    "skills": "powerpoint",
    "skill_id": 196,
    "formatted_count": "58",
    "formatted_salary": "88,701",
    "count_rank": "9",
    "salary_rank": "84"
  },
  {
    "skills": "looker",
    "skill_id": 185,
    "formatted_count": "49",
    "formatted_salary": "103,795",
    "count_rank": "10",
    "salary_rank": "44"
  },
  {
    "skills": "word",
    "skill_id": 188,
    "formatted_count": "48",
    "formatted_salary": "82,576",
    "count_rank": "11",
    "salary_rank": "94"
  },
  {
    "skills": "oracle",
    "skill_id": 79,
    "formatted_count": "37",
    "formatted_salary": "104,534",
    "count_rank": "12",
    "salary_rank": "42"
  },
  {
    "skills": "snowflake",
    "skill_id": 80,
    "formatted_count": "37",
    "formatted_salary": "112,948",
    "count_rank": "12",
    "salary_rank": "31"
  },
  {
    "skills": "sql server",
    "skill_id": 61,
    "formatted_count": "35",
    "formatted_salary": "97,786",
    "count_rank": "14",
    "salary_rank": "58"
  },
  {
    "skills": "azure",
    "skill_id": 74,
    "formatted_count": "34",
    "formatted_salary": "111,225",
    "count_rank": "15",
    "salary_rank": "34"
  },
  {
    "skills": "aws",
    "skill_id": 76,
    "formatted_count": "32",
    "formatted_salary": "108,317",
    "count_rank": "16",
    "salary_rank": "36"
  },
  {
    "skills": "sheets",
    "skill_id": 192,
    "formatted_count": "32",
    "formatted_salary": "86,088",
    "count_rank": "16",
    "salary_rank": "89"
  },
  {
    "skills": "flow",
    "skill_id": 215,
    "formatted_count": "28",
    "formatted_salary": "97,200",
    "count_rank": "18",
    "salary_rank": "64"
  },
  {
    "skills": "go",
    "skill_id": 8,
    "formatted_count": "27",
    "formatted_salary": "115,320",
    "count_rank": "19",
    "salary_rank": "27"
  },
  {
    "skills": "spss",
    "skill_id": 199,
    "formatted_count": "24",
    "formatted_salary": "92,170",
    "count_rank": "20",
    "salary_rank": "76"
  },
  {
    "skills": "vba",
    "skill_id": 22,
    "formatted_count": "24",
    "formatted_salary": "88,783",
    "count_rank": "20",
    "salary_rank": "83"
  },
  {
    "skills": "hadoop",
    "skill_id": 97,
    "formatted_count": "22",
    "formatted_salary": "113,193",
    "count_rank": "22",
    "salary_rank": "30"
  },
  {
    "skills": "jira",
    "skill_id": 233,
    "formatted_count": "20",
    "formatted_salary": "104,918",
    "count_rank": "23",
    "salary_rank": "41"
  },
  {
    "skills": "javascript",
    "skill_id": 9,
    "formatted_count": "20",
    "formatted_salary": "97,587",
    "count_rank": "23",
    "salary_rank": "59"
  },
  {
    "skills": "sharepoint",
    "skill_id": 195,
    "formatted_count": "18",
    "formatted_salary": "81,634",
    "count_rank": "25",
    "salary_rank": "97"
  }
]