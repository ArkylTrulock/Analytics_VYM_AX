/*
Questions: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2.....
- Identify the top 5 in-demand skills for a data analyst.....
- Focus on all job postings.....
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers............
*/

WITH top_demanded_skills AS(
    SELECT
    sd.skills AS skills,
    sd.skill_id AS skill_id,
    COUNT(sjd.job_id) AS demand_count,
    COALESCE((COUNT(sjd.job_id) * 100.0 / SUM(COUNT(sjd.job_id)) OVER ()), 0) AS demand_count_percentage,
    COALESCE(COUNT(sjd.job_id) - LAG(COUNT(sjd.job_id)) OVER (ORDER BY COUNT(sjd.job_id) DESC), 0) AS demand_count_change,
    COALESCE(ROUND(((COUNT(sjd.job_id) - LAG(COUNT(sjd.job_id)) OVER (ORDER BY COUNT(sjd.job_id) DESC)) 
        / NULLIF(LAG(COUNT(sjd.job_id)) OVER (ORDER BY COUNT(sjd.job_id) DESC)::DECIMAL, 0)) * 100, 2), 0) 
        AS demand_count_change_percentage, -- COUNT() returns an integer. Dividing two integers may result in 0. ::DECIMAL converts to DECIMAL or FLOAT before division. 
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
    ORDER BY
        demand_count DESC
        --avg_yearly_sal DESC
)
SELECT
    skills,
    skill_id,
    demand_count_percentage,
    demand_count,
    count_rank,
    demand_count_change,
    demand_count_change_percentage,
    --formatted_count,  
    --formatted_salary,   
    avg_yearly_sal,
    salary_rank  
FROM
    top_demanded_skills
LIMIT
    25;

[
  {
    "skills": "sql",
    "skill_id": 0,
    "demand_count_percentage": "15.9072741806554756",
    "demand_count": "398",
    "count_rank": "1",
    "demand_count_change": "0",
    "demand_count_change_percentage": "0",
    "avg_yearly_sal": "97237.161824748744",
    "salary_rank": "62"
  },
  {
    "skills": "excel",
    "skill_id": 181,
    "demand_count_percentage": "10.2318145483613110",
    "demand_count": "256",
    "count_rank": "2",
    "demand_count_change": "-142",
    "demand_count_change_percentage": "-35.68",
    "avg_yearly_sal": "87288.214080810547",
    "salary_rank": "86"
  },
  {
    "skills": "python",
    "skill_id": 1,
    "demand_count_percentage": "9.4324540367705835",
    "demand_count": "236",
    "count_rank": "3",
    "demand_count_change": "-20",
    "demand_count_change_percentage": "-7.81",
    "avg_yearly_sal": "101397.219941737288",
    "salary_rank": "47"
  },
  {
    "skills": "tableau",
    "skill_id": 182,
    "demand_count_percentage": "9.1926458832933653",
    "demand_count": "230",
    "count_rank": "4",
    "demand_count_change": "-6",
    "demand_count_change_percentage": "-2.54",
    "avg_yearly_sal": "99287.650000000000",
    "salary_rank": "51"
  },
  {
    "skills": "r",
    "skill_id": 5,
    "demand_count_percentage": "5.9152677857713829",
    "demand_count": "148",
    "count_rank": "5",
    "demand_count_change": "-82",
    "demand_count_change_percentage": "-35.65",
    "avg_yearly_sal": "100498.766258445946",
    "salary_rank": "48"
  },
  {
    "skills": "power bi",
    "skill_id": 183,
    "demand_count_percentage": "4.3964828137490008",
    "demand_count": "110",
    "count_rank": "6",
    "demand_count_change": "-38",
    "demand_count_change_percentage": "-25.68",
    "avg_yearly_sal": "97431.304545454545",
    "salary_rank": "61"
  },
  {
    "skills": "sas",
    "skill_id": 7,
    "demand_count_percentage": "2.5179856115107914",
    "demand_count": "63",
    "count_rank": "7",
    "demand_count_change": "-47",
    "demand_count_change_percentage": "-42.73",
    "avg_yearly_sal": "98902.371527777778",
    "salary_rank": "56"
  },
  {
    "skills": "sas",
    "skill_id": 186,
    "demand_count_percentage": "2.5179856115107914",
    "demand_count": "63",
    "count_rank": "7",
    "demand_count_change": "0",
    "demand_count_change_percentage": "0.00",
    "avg_yearly_sal": "98902.371527777778",
    "salary_rank": "56"
  },
  {
    "skills": "powerpoint",
    "skill_id": 196,
    "demand_count_percentage": "2.3181454836131095",
    "demand_count": "58",
    "count_rank": "9",
    "demand_count_change": "-5",
    "demand_count_change_percentage": "-7.94",
    "avg_yearly_sal": "88701.094827586207",
    "salary_rank": "84"
  },
  {
    "skills": "looker",
    "skill_id": 185,
    "demand_count_percentage": "1.9584332533972822",
    "demand_count": "49",
    "count_rank": "10",
    "demand_count_change": "-9",
    "demand_count_change_percentage": "-15.52",
    "avg_yearly_sal": "103795.295918367347",
    "salary_rank": "44"
  },
  {
    "skills": "word",
    "skill_id": 188,
    "demand_count_percentage": "1.9184652278177458",
    "demand_count": "48",
    "count_rank": "11",
    "demand_count_change": "-1",
    "demand_count_change_percentage": "-2.04",
    "avg_yearly_sal": "82576.039713541667",
    "salary_rank": "94"
  },
  {
    "skills": "oracle",
    "skill_id": 79,
    "demand_count_percentage": "1.4788169464428457",
    "demand_count": "37",
    "count_rank": "12",
    "demand_count_change": "-11",
    "demand_count_change_percentage": "-22.92",
    "avg_yearly_sal": "104533.700168918919",
    "salary_rank": "42"
  },
  {
    "skills": "snowflake",
    "skill_id": 80,
    "demand_count_percentage": "1.4788169464428457",
    "demand_count": "37",
    "count_rank": "12",
    "demand_count_change": "0",
    "demand_count_change_percentage": "0.00",
    "avg_yearly_sal": "112947.972972972973",
    "salary_rank": "31"
  },
  {
    "skills": "sql server",
    "skill_id": 61,
    "demand_count_percentage": "1.3988808952837730",
    "demand_count": "35",
    "count_rank": "14",
    "demand_count_change": "-2",
    "demand_count_change_percentage": "-5.41",
    "avg_yearly_sal": "97785.728571428571",
    "salary_rank": "58"
  },
  {
    "skills": "azure",
    "skill_id": 74,
    "demand_count_percentage": "1.3589128697042366",
    "demand_count": "34",
    "count_rank": "15",
    "demand_count_change": "-1",
    "demand_count_change_percentage": "-2.86",
    "avg_yearly_sal": "111225.102941176471",
    "salary_rank": "34"
  },
  {
    "skills": "sheets",
    "skill_id": 192,
    "demand_count_percentage": "1.2789768185451639",
    "demand_count": "32",
    "count_rank": "16",
    "demand_count_change": "-2",
    "demand_count_change_percentage": "-5.88",
    "avg_yearly_sal": "86087.790771484375",
    "salary_rank": "89"
  },
  {
    "skills": "aws",
    "skill_id": 76,
    "demand_count_percentage": "1.2789768185451639",
    "demand_count": "32",
    "count_rank": "16",
    "demand_count_change": "0",
    "demand_count_change_percentage": "0.00",
    "avg_yearly_sal": "108317.296875000000",
    "salary_rank": "36"
  },
  {
    "skills": "flow",
    "skill_id": 215,
    "demand_count_percentage": "1.1191047162270184",
    "demand_count": "28",
    "count_rank": "18",
    "demand_count_change": "-4",
    "demand_count_change_percentage": "-12.50",
    "avg_yearly_sal": "97200.000000000000",
    "salary_rank": "64"
  },
  {
    "skills": "go",
    "skill_id": 8,
    "demand_count_percentage": "1.0791366906474820",
    "demand_count": "27",
    "count_rank": "19",
    "demand_count_change": "-1",
    "demand_count_change_percentage": "-3.57",
    "avg_yearly_sal": "115319.888888888889",
    "salary_rank": "27"
  },
  {
    "skills": "vba",
    "skill_id": 22,
    "demand_count_percentage": "0.95923261390887290168",
    "demand_count": "24",
    "count_rank": "20",
    "demand_count_change": "-3",
    "demand_count_change_percentage": "-11.11",
    "avg_yearly_sal": "88783.291666666667",
    "salary_rank": "83"
  },
  {
    "skills": "spss",
    "skill_id": 199,
    "demand_count_percentage": "0.95923261390887290168",
    "demand_count": "24",
    "count_rank": "20",
    "demand_count_change": "0",
    "demand_count_change_percentage": "0.00",
    "avg_yearly_sal": "92169.683593750000",
    "salary_rank": "76"
  },
  {
    "skills": "hadoop",
    "skill_id": 97,
    "demand_count_percentage": "0.87929656274980015987",
    "demand_count": "22",
    "count_rank": "22",
    "demand_count_change": "-2",
    "demand_count_change_percentage": "-8.33",
    "avg_yearly_sal": "113192.568181818182",
    "salary_rank": "30"
  },
  {
    "skills": "javascript",
    "skill_id": 9,
    "demand_count_percentage": "0.79936051159072741807",
    "demand_count": "20",
    "count_rank": "23",
    "demand_count_change": "-2",
    "demand_count_change_percentage": "-9.09",
    "avg_yearly_sal": "97587.000000000000",
    "salary_rank": "59"
  },
  {
    "skills": "jira",
    "skill_id": 233,
    "demand_count_percentage": "0.79936051159072741807",
    "demand_count": "20",
    "count_rank": "23",
    "demand_count_change": "0",
    "demand_count_change_percentage": "0.00",
    "avg_yearly_sal": "104917.900000000000",
    "salary_rank": "41"
  },
  {
    "skills": "sharepoint",
    "skill_id": 195,
    "demand_count_percentage": "0.71942446043165467626",
    "demand_count": "18",
    "count_rank": "25",
    "demand_count_change": "-2",
    "demand_count_change_percentage": "-10.00",
    "avg_yearly_sal": "81633.583333333333",
    "salary_rank": "97"
  }
]