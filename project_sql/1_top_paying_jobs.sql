/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focus on job postings with specified salaries (remove NULLs).
- Why? Highlight the top-paying opportunities for Data Analysts, optimal skills, and roles to pursue as a Data Analyst.
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    name AS company_name,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact 
LEFT JOIN 
    company_dim  ON job_postings_fact.company_id=company_dim.company_id
WHERE 
    job_title_short='Data Analyst' AND
    --job_location = 'Anywhere' 
     job_work_from_home=True
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

/*The analysis of the top 10 highest-paying remote Data Analyst jobs in 2023 
provides valuable insights into the landscape of data analysis 
opportunities. The presence of titles such as  Director of Analytics,
, Associate Director- Data Insights, and Principal Data Analyst indicates 
a hierarchy within the field, with higher-ranking positions commanding 
significantly higher salaries.
Furthermore, the prevalence of full-time positions underscores the commitment 
required for these roles, suggesting that employers prioritize consistency and 
dedication in their remote workforce. *./