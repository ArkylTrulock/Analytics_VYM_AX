/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest paying Data Analyst roles that are available remotely & offer health insurance
- Focus on job postings with specified salaries (remove nulls).......
- Why? Highlight the top paying opportunities for Data Analysis, offering insights into employment options &
  location flexibiity...............
*/

WITH top_paying_jobs AS(
  SELECT   
      cd.name AS company_name,
      jpf.job_posted_date::date AS date_job_posted,
      jpf.job_id,
      jpf.job_title,
      jpf.job_title_short,
      jpf.job_location,
      jpf.job_schedule_type,
      jpf.job_health_insurance,
      jpf.salary_year_avg,
      COALESCE(jpf.salary_year_avg - LAG(jpf.salary_year_avg) OVER (ORDER BY jpf.salary_year_avg DESC), 0) AS salary_year_avg_change,
      COALESCE(ROUND(((jpf.salary_year_avg - LAG(jpf.salary_year_avg) OVER (ORDER BY jpf.salary_year_avg DESC)) 
        / LAG(jpf.salary_year_avg) OVER (ORDER BY jpf.salary_year_avg DESC)) * 100, 2), 0) AS salary_year_avg_change_percentage,
      TO_CHAR(ROUND(jpf.salary_year_avg, 0),'FM999,999,999') AS formatted_salary, -- '999,999,999' ensures the number has thousands separators. FM (Fill Mode) removes leading spaces.
      RANK() OVER (ORDER BY jpf.salary_year_avg DESC) AS salary_rank,
      CASE
          WHEN jpf.job_location = 'Anywhere' THEN 'Remote'
          ELSE 'Onsite'
      END AS location_category,
      CASE
          WHEN jpf.salary_year_avg > 600000 THEN 'Premium'
          WHEN jpf.salary_year_avg BETWEEN 400000 AND 600000 THEN 'High'
          WHEN jpf.salary_year_avg BETWEEN 200000 AND 400000 THEN 'Mid High'
          WHEN jpf.salary_year_avg BETWEEN 100000 AND 200000 THEN 'Mid'
          ELSE 'Low'
      END AS salary_quote
  FROM
      job_postings_fact AS jpf
  LEFT JOIN
      company_dim AS cd ON jpf.company_id = cd.company_id
  WHERE
      jpf.job_title_short = 'Data Analyst' AND
      jpf.job_location = 'Anywhere' AND
      jpf.job_health_insurance IS TRUE AND
      jpf.salary_year_avg IS NOT NULL
)
SELECT
  company_name,
  date_job_posted,
  job_id,
  job_title,
  location_category,
  job_health_insurance,
  salary_year_avg,
  salary_rank,
  salary_year_avg_change,
  salary_year_avg_change_percentage,
  --formatted_salary,
  salary_quote
FROM
  top_paying_jobs
ORDER BY
  salary_year_avg DESC
LIMIT  
    10

[
  {
    "company_name": "AT&T",
    "date_job_posted": "2023-06-18",
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "255829.5",
    "salary_rank": "1",
    "salary_year_avg_change": "0",
    "salary_year_avg_change_percentage": "0",
    "salary_quote": "Mid High"
  },
  {
    "company_name": "SmartAsset",
    "date_job_posted": "2023-08-09",
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "205000.0",
    "salary_rank": "2",
    "salary_year_avg_change": "-50829.5",
    "salary_year_avg_change_percentage": "-19.87",
    "salary_quote": "Mid High"
  },
  {
    "company_name": "SmartAsset",
    "date_job_posted": "2023-07-11",
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "186000.0",
    "salary_rank": "3",
    "salary_year_avg_change": "-19000.0",
    "salary_year_avg_change_percentage": "-9.27",
    "salary_quote": "Mid"
  },
  {
    "company_name": "Get It Recruit - Information Technology",
    "date_job_posted": "2023-06-09",
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "184000.0",
    "salary_rank": "4",
    "salary_year_avg_change": "-2000.0",
    "salary_year_avg_change_percentage": "-1.08",
    "salary_quote": "Mid"
  },
  {
    "company_name": "Robert Half",
    "date_job_posted": "2023-10-06",
    "job_id": 1781684,
    "job_title": "DTCC Data Analyst",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "170000.0",
    "salary_rank": "5",
    "salary_year_avg_change": "-14000.0",
    "salary_year_avg_change_percentage": "-7.61",
    "salary_quote": "Mid"
  },
  {
    "company_name": "Uber",
    "date_job_posted": "2023-04-18",
    "job_id": 1525451,
    "job_title": "Manager, Data Analyst",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "167000.0",
    "salary_rank": "6",
    "salary_year_avg_change": "-3000.0",
    "salary_year_avg_change_percentage": "-1.76",
    "salary_quote": "Mid"
  },
  {
    "company_name": "Get It Recruit - Information Technology",
    "date_job_posted": "2023-08-14",
    "job_id": 712473,
    "job_title": "Data Analyst",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "165000.0",
    "salary_rank": "7",
    "salary_year_avg_change": "-2000.0",
    "salary_year_avg_change_percentage": "-1.20",
    "salary_quote": "Mid"
  },
  {
    "company_name": "Mayo Clinic",
    "date_job_posted": "2023-01-13",
    "job_id": 1423236,
    "job_title": "Principal Data Science Analyst- Remote",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "164746.0",
    "salary_rank": "8",
    "salary_year_avg_change": "-254.0",
    "salary_year_avg_change_percentage": "-0.15",
    "salary_quote": "Mid"
  },
  {
    "company_name": "DIRECTV",
    "date_job_posted": "2023-06-14",
    "job_id": 918213,
    "job_title": "Senior - Data Analyst",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "160515.0",
    "salary_rank": "9",
    "salary_year_avg_change": "-4231.0",
    "salary_year_avg_change_percentage": "-2.57",
    "salary_quote": "Mid"
  },
  {
    "company_name": "Get It Recruit - Information Technology",
    "date_job_posted": "2023-10-13",
    "job_id": 182813,
    "job_title": "Principal Data Analyst",
    "location_category": "Remote",
    "job_health_insurance": true,
    "salary_year_avg": "160000.0",
    "salary_rank": "10",
    "salary_year_avg_change": "-515.0",
    "salary_year_avg_change_percentage": "-0.32",
    "salary_quote": "Mid"
  }
]