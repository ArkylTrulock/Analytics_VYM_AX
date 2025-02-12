/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest paying Data Analyst roles that are available remotely & offer health insurance.
- Focus on job postings with specified salaries (remove nulls).
- Why? Highlight the top paying opportunities for Data Analysis, offering insights into employment options &
  location flexibiity.
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
      TO_CHAR(ROUND(jpf.salary_year_avg, 0),'FM999,999,999') AS formatted_salary,
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
  job_health_insurance,
  location_category,
  formatted_salary,
  salary_quote,
  salary_rank
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
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "255,830",
    "salary_quote": "Mid High",
    "salary_rank": "1"
  },
  {
    "company_name": "SmartAsset",
    "date_job_posted": "2023-08-09",
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "205,000",
    "salary_quote": "Mid High",
    "salary_rank": "2"
  },
  {
    "company_name": "SmartAsset",
    "date_job_posted": "2023-07-11",
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "186,000",
    "salary_quote": "Mid",
    "salary_rank": "3"
  },
  {
    "company_name": "Get It Recruit - Information Technology",
    "date_job_posted": "2023-06-09",
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "184,000",
    "salary_quote": "Mid",
    "salary_rank": "4"
  },
  {
    "company_name": "Robert Half",
    "date_job_posted": "2023-10-06",
    "job_id": 1781684,
    "job_title": "DTCC Data Analyst",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "170,000",
    "salary_quote": "Mid",
    "salary_rank": "5"
  },
  {
    "company_name": "Uber",
    "date_job_posted": "2023-04-18",
    "job_id": 1525451,
    "job_title": "Manager, Data Analyst",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "167,000",
    "salary_quote": "Mid",
    "salary_rank": "6"
  },
  {
    "company_name": "Get It Recruit - Information Technology",
    "date_job_posted": "2023-08-14",
    "job_id": 712473,
    "job_title": "Data Analyst",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "165,000",
    "salary_quote": "Mid",
    "salary_rank": "7"
  },
  {
    "company_name": "Mayo Clinic",
    "date_job_posted": "2023-01-13",
    "job_id": 1423236,
    "job_title": "Principal Data Science Analyst- Remote",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "164,746",
    "salary_quote": "Mid",
    "salary_rank": "8"
  },
  {
    "company_name": "DIRECTV",
    "date_job_posted": "2023-06-14",
    "job_id": 918213,
    "job_title": "Senior - Data Analyst",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "160,515",
    "salary_quote": "Mid",
    "salary_rank": "9"
  },
  {
    "company_name": "Get It Recruit - Information Technology",
    "date_job_posted": "2023-10-13",
    "job_id": 182813,
    "job_title": "Principal Data Analyst",
    "job_health_insurance": true,
    "location_category": "Remote",
    "formatted_salary": "160,000",
    "salary_quote": "Mid",
    "salary_rank": "10"
  }
]