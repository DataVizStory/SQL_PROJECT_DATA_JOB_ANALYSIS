/* 
Question: What skills are required for the top-paying Data Analyst jobs?
- Utilize the top 10 highest-paying Data Analyst jobs from the first query.
- Include the specific skills required for these roles.
- Why? This provides a detailed look at which high-paying jobs demand certain skills,
 helping job seekers understand which skills to develop to align with top salaries. 
 */
 
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM 
        job_postings_fact
    LEFT JOIN 
        company_dim ON job_postings_fact.company_id= company_dim.company_id
    WHERE 
        job_title_short='Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills 
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY
    salary_year_avg DESC ;

/* 
SQL is leading with a bold count of 8 across the top-paying roles, 
highlighting its fundamental importance for data manipulation and analysis tasks.

Python is mentioned 7 times in the high-paying job descriptions, 
indicating its significance for data processing, machine learning, and automation tasks.

Tableau is mentioned 6 times among the top-paying roles, 
showcasing the need for strong data visualization skills to communicate insights effectively. 

Other skills like R, Azure, AWS, Atlassian, Pandas , Excel, 
and Snowflake are mentioned across these roles. 
This reflects the diverse technical requirements and tools utilized 
in high-paying Data Analyst positions. */ 