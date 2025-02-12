/*
Questions: What are the optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Dat Analyst roles
- Concentrate on remote positions with speciic salaries..
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis..
*/

WITH optimal_skills AS(
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
    HAVING
        COUNT(sjd.job_id) > 10 -- Optimal skills filter
)
SELECT
    skills,
    skill_id,
    formatted_count,
    formatted_salary,
    count_rank,
    salary_rank
FROM
    optimal_skills
-- WHERE
--     demand_count > 10 -- Optimal skills filter
ORDER BY
    avg_yearly_sal DESC
    
LIMIT
    25;

[
  {
    "skills": "go",
    "skill_id": 8,
    "formatted_count": "27",
    "formatted_salary": "115,320",
    "count_rank": "19",
    "salary_rank": "1"
  },
  {
    "skills": "confluence",
    "skill_id": 234,
    "formatted_count": "11",
    "formatted_salary": "114,210",
    "count_rank": "36",
    "salary_rank": "2"
  },
  {
    "skills": "hadoop",
    "skill_id": 97,
    "formatted_count": "22",
    "formatted_salary": "113,193",
    "count_rank": "22",
    "salary_rank": "3"
  },
  {
    "skills": "snowflake",
    "skill_id": 80,
    "formatted_count": "37",
    "formatted_salary": "112,948",
    "count_rank": "12",
    "salary_rank": "4"
  },
  {
    "skills": "azure",
    "skill_id": 74,
    "formatted_count": "34",
    "formatted_salary": "111,225",
    "count_rank": "15",
    "salary_rank": "5"
  },
  {
    "skills": "bigquery",
    "skill_id": 77,
    "formatted_count": "13",
    "formatted_salary": "109,654",
    "count_rank": "30",
    "salary_rank": "6"
  },
  {
    "skills": "aws",
    "skill_id": 76,
    "formatted_count": "32",
    "formatted_salary": "108,317",
    "count_rank": "16",
    "salary_rank": "7"
  },
  {
    "skills": "java",
    "skill_id": 4,
    "formatted_count": "17",
    "formatted_salary": "106,906",
    "count_rank": "26",
    "salary_rank": "8"
  },
  {
    "skills": "ssis",
    "skill_id": 194,
    "formatted_count": "12",
    "formatted_salary": "106,683",
    "count_rank": "35",
    "salary_rank": "9"
  },
  {
    "skills": "jira",
    "skill_id": 233,
    "formatted_count": "20",
    "formatted_salary": "104,918",
    "count_rank": "23",
    "salary_rank": "10"
  },
  {
    "skills": "oracle",
    "skill_id": 79,
    "formatted_count": "37",
    "formatted_salary": "104,534",
    "count_rank": "12",
    "salary_rank": "11"
  },
  {
    "skills": "looker",
    "skill_id": 185,
    "formatted_count": "49",
    "formatted_salary": "103,795",
    "count_rank": "10",
    "salary_rank": "12"
  },
  {
    "skills": "nosql",
    "skill_id": 2,
    "formatted_count": "13",
    "formatted_salary": "101,414",
    "count_rank": "30",
    "salary_rank": "13"
  },
  {
    "skills": "python",
    "skill_id": 1,
    "formatted_count": "236",
    "formatted_salary": "101,397",
    "count_rank": "3",
    "salary_rank": "14"
  },
  {
    "skills": "r",
    "skill_id": 5,
    "formatted_count": "148",
    "formatted_salary": "100,499",
    "count_rank": "5",
    "salary_rank": "15"
  },
  {
    "skills": "redshift",
    "skill_id": 78,
    "formatted_count": "16",
    "formatted_salary": "99,936",
    "count_rank": "28",
    "salary_rank": "16"
  },
  {
    "skills": "qlik",
    "skill_id": 187,
    "formatted_count": "13",
    "formatted_salary": "99,631",
    "count_rank": "30",
    "salary_rank": "17"
  },
  {
    "skills": "tableau",
    "skill_id": 182,
    "formatted_count": "230",
    "formatted_salary": "99,288",
    "count_rank": "4",
    "salary_rank": "18"
  },
  {
    "skills": "ssrs",
    "skill_id": 197,
    "formatted_count": "14",
    "formatted_salary": "99,171",
    "count_rank": "29",
    "salary_rank": "19"
  },
  {
    "skills": "spark",
    "skill_id": 92,
    "formatted_count": "13",
    "formatted_salary": "99,077",
    "count_rank": "30",
    "salary_rank": "20"
  },
  {
    "skills": "c++",
    "skill_id": 13,
    "formatted_count": "11",
    "formatted_salary": "98,958",
    "count_rank": "36",
    "salary_rank": "21"
  },
  {
    "skills": "sas",
    "skill_id": 7,
    "formatted_count": "63",
    "formatted_salary": "98,902",
    "count_rank": "7",
    "salary_rank": "22"
  },
  {
    "skills": "sas",
    "skill_id": 186,
    "formatted_count": "63",
    "formatted_salary": "98,902",
    "count_rank": "7",
    "salary_rank": "22"
  },
  {
    "skills": "sql server",
    "skill_id": 61,
    "formatted_count": "35",
    "formatted_salary": "97,786",
    "count_rank": "14",
    "salary_rank": "24"
  },
  {
    "skills": "javascript",
    "skill_id": 9,
    "formatted_count": "20",
    "formatted_salary": "97,587",
    "count_rank": "23",
    "salary_rank": "25"
  }
]