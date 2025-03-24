/*
Questions: What are the optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Dat Analyst roles......
- Concentrate on remote positions with speciic salaries.......
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis............
*/

WITH optimal_skills AS(
    SELECT
        sd.skills AS skills,
        sd.skill_id AS skill_id,
        COUNT(sjd.job_id) AS demand_count,
        TO_CHAR(COUNT(sjd.job_id), 'FM999,999,999') AS formatted_count,
        ROUND(AVG(jpf.salary_year_avg),0) AS avg_yearly_sal,
        COALESCE(AVG(jpf.salary_year_avg) - LAG(AVG(jpf.salary_year_avg)) OVER (ORDER BY AVG(jpf.salary_year_avg) DESC), 0) AS avg_yearly_sal_change,
        COALESCE(ROUND(((AVG(jpf.salary_year_avg) - LAG(AVG(jpf.salary_year_avg)) OVER (ORDER BY AVG(jpf.salary_year_avg) DESC)) 
        / NULLIF(LAG(AVG(jpf.salary_year_avg)) OVER (ORDER BY AVG(jpf.salary_year_avg) DESC), 0)) * 100, 2), 0) AS avg_yearly_sal_change_percentage, -- AVG() Already Returns a DECIMAL.
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
    GROUP BY -- Use when you aggregate (COUNT, SUM, AVG etc..)
        sd.skills,
        sd.skill_id
    HAVING
        COUNT(sjd.job_id) > 10 -- Optimal skills filter
)
SELECT
    skills,
    skill_id,
    demand_count,
    count_rank,
    --formatted_count,
    avg_yearly_sal,
    salary_rank,
    avg_yearly_sal_change,
    avg_yearly_sal_change_percentage
    --formatted_salary,   
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
    "demand_count": "27",
    "count_rank": "19",
    "avg_yearly_sal": "115320",
    "salary_rank": "1",
    "avg_yearly_sal_change": "0",
    "avg_yearly_sal_change_percentage": "0"
  },
  {
    "skills": "confluence",
    "skill_id": 234,
    "demand_count": "11",
    "count_rank": "36",
    "avg_yearly_sal": "114210",
    "salary_rank": "2",
    "avg_yearly_sal_change": "-1109.979797979798",
    "avg_yearly_sal_change_percentage": "-0.96"
  },
  {
    "skills": "hadoop",
    "skill_id": 97,
    "demand_count": "22",
    "count_rank": "22",
    "avg_yearly_sal": "113193",
    "salary_rank": "3",
    "avg_yearly_sal_change": "-1017.340909090909",
    "avg_yearly_sal_change_percentage": "-0.89"
  },
  {
    "skills": "snowflake",
    "skill_id": 80,
    "demand_count": "37",
    "count_rank": "12",
    "avg_yearly_sal": "112948",
    "salary_rank": "4",
    "avg_yearly_sal_change": "-244.595208845209",
    "avg_yearly_sal_change_percentage": "-0.22"
  },
  {
    "skills": "azure",
    "skill_id": 74,
    "demand_count": "34",
    "count_rank": "15",
    "avg_yearly_sal": "111225",
    "salary_rank": "5",
    "avg_yearly_sal_change": "-1722.870031796502",
    "avg_yearly_sal_change_percentage": "-1.53"
  },
  {
    "skills": "bigquery",
    "skill_id": 77,
    "demand_count": "13",
    "count_rank": "30",
    "avg_yearly_sal": "109654",
    "salary_rank": "6",
    "avg_yearly_sal_change": "-1571.256787330317",
    "avg_yearly_sal_change_percentage": "-1.41"
  },
  {
    "skills": "aws",
    "skill_id": 76,
    "demand_count": "32",
    "count_rank": "16",
    "avg_yearly_sal": "108317",
    "salary_rank": "7",
    "avg_yearly_sal_change": "-1336.549278846154",
    "avg_yearly_sal_change_percentage": "-1.22"
  },
  {
    "skills": "java",
    "skill_id": 4,
    "demand_count": "17",
    "count_rank": "26",
    "avg_yearly_sal": "106906",
    "salary_rank": "8",
    "avg_yearly_sal_change": "-1410.855698529412",
    "avg_yearly_sal_change_percentage": "-1.30"
  },
  {
    "skills": "ssis",
    "skill_id": 194,
    "demand_count": "12",
    "count_rank": "35",
    "avg_yearly_sal": "106683",
    "salary_rank": "9",
    "avg_yearly_sal_change": "-223.107843137255",
    "avg_yearly_sal_change_percentage": "-0.21"
  },
  {
    "skills": "jira",
    "skill_id": 233,
    "demand_count": "20",
    "count_rank": "23",
    "avg_yearly_sal": "104918",
    "salary_rank": "10",
    "avg_yearly_sal_change": "-1765.433333333333",
    "avg_yearly_sal_change_percentage": "-1.65"
  },
  {
    "skills": "oracle",
    "skill_id": 79,
    "demand_count": "37",
    "count_rank": "12",
    "avg_yearly_sal": "104534",
    "salary_rank": "11",
    "avg_yearly_sal_change": "-384.199831081081",
    "avg_yearly_sal_change_percentage": "-0.37"
  },
  {
    "skills": "looker",
    "skill_id": 185,
    "demand_count": "49",
    "count_rank": "10",
    "avg_yearly_sal": "103795",
    "salary_rank": "12",
    "avg_yearly_sal_change": "-738.404250551572",
    "avg_yearly_sal_change_percentage": "-0.71"
  },
  {
    "skills": "nosql",
    "skill_id": 2,
    "demand_count": "13",
    "count_rank": "30",
    "avg_yearly_sal": "101414",
    "salary_rank": "13",
    "avg_yearly_sal_change": "-2381.565149136578",
    "avg_yearly_sal_change_percentage": "-2.29"
  },
  {
    "skills": "python",
    "skill_id": 1,
    "demand_count": "236",
    "count_rank": "3",
    "avg_yearly_sal": "101397",
    "salary_rank": "14",
    "avg_yearly_sal_change": "-16.510827493481",
    "avg_yearly_sal_change_percentage": "-0.02"
  },
  {
    "skills": "r",
    "skill_id": 5,
    "demand_count": "148",
    "count_rank": "5",
    "avg_yearly_sal": "100499",
    "salary_rank": "15",
    "avg_yearly_sal_change": "-898.453683291342",
    "avg_yearly_sal_change_percentage": "-0.89"
  },
  {
    "skills": "redshift",
    "skill_id": 78,
    "demand_count": "16",
    "count_rank": "28",
    "avg_yearly_sal": "99936",
    "salary_rank": "16",
    "avg_yearly_sal_change": "-562.328758445946",
    "avg_yearly_sal_change_percentage": "-0.56"
  },
  {
    "skills": "qlik",
    "skill_id": 187,
    "demand_count": "13",
    "count_rank": "30",
    "avg_yearly_sal": "99631",
    "salary_rank": "17",
    "avg_yearly_sal_change": "-305.629807692308",
    "avg_yearly_sal_change_percentage": "-0.31"
  },
  {
    "skills": "tableau",
    "skill_id": 182,
    "demand_count": "230",
    "count_rank": "4",
    "avg_yearly_sal": "99288",
    "salary_rank": "18",
    "avg_yearly_sal_change": "-343.157692307692",
    "avg_yearly_sal_change_percentage": "-0.34"
  },
  {
    "skills": "ssrs",
    "skill_id": 197,
    "demand_count": "14",
    "count_rank": "29",
    "avg_yearly_sal": "99171",
    "salary_rank": "19",
    "avg_yearly_sal_change": "-116.221428571429",
    "avg_yearly_sal_change_percentage": "-0.12"
  },
  {
    "skills": "spark",
    "skill_id": 92,
    "demand_count": "13",
    "count_rank": "30",
    "avg_yearly_sal": "99077",
    "salary_rank": "20",
    "avg_yearly_sal_change": "-94.505494505494",
    "avg_yearly_sal_change_percentage": "-0.10"
  },
  {
    "skills": "c++",
    "skill_id": 13,
    "demand_count": "11",
    "count_rank": "36",
    "avg_yearly_sal": "98958",
    "salary_rank": "21",
    "avg_yearly_sal_change": "-118.695804195804",
    "avg_yearly_sal_change_percentage": "-0.12"
  },
  {
    "skills": "sas",
    "skill_id": 7,
    "demand_count": "63",
    "count_rank": "7",
    "avg_yearly_sal": "98902",
    "salary_rank": "22",
    "avg_yearly_sal_change": "-55.855744949495",
    "avg_yearly_sal_change_percentage": "-0.06"
  },
  {
    "skills": "sas",
    "skill_id": 186,
    "demand_count": "63",
    "count_rank": "7",
    "avg_yearly_sal": "98902",
    "salary_rank": "22",
    "avg_yearly_sal_change": "0.000000000000",
    "avg_yearly_sal_change_percentage": "0.00"
  },
  {
    "skills": "sql server",
    "skill_id": 61,
    "demand_count": "35",
    "count_rank": "14",
    "avg_yearly_sal": "97786",
    "salary_rank": "24",
    "avg_yearly_sal_change": "-1116.642956349207",
    "avg_yearly_sal_change_percentage": "-1.13"
  },
  {
    "skills": "javascript",
    "skill_id": 9,
    "demand_count": "20",
    "count_rank": "23",
    "avg_yearly_sal": "97587",
    "salary_rank": "25",
    "avg_yearly_sal_change": "-198.728571428571",
    "avg_yearly_sal_change_percentage": "-0.20"
  }
]