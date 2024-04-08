/*
 Question: What are the most in-demand skills for Data Analysts?
- Join job postings using an inner join similar to query 2.
 - Identify the top 5 in-demand skills for a Data Analyst.
Focus on all job postings.
Why? Retrieve the top 5 skills with the highest demand in 
the job market, providing insights into the most valuable 
skills for job seekers
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact 
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short='Data Analyst'AND
    job_work_from_home=True
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5 ;

/*The top 5 most in-demand skills for Data Analysts, based on job postings that allow remote work, are as follows:
SQL: Leading the list with a demand count of 7291, SQL remains a fundamental skill for data analysis tasks, including data manipulation and querying databases.
Excel: Following closely behind with 4611 job postings mentioning it, Excel proficiency is highly sought-after for data organization, analysis, and reporting.
Python: With 4330 mentions, Python is in high demand for its versatility in data processing, machine learning, and automation tasks.
Tableau: Not far behind, Tableau is mentioned in 3745 job postings, indicating the importance of strong data visualization skills in communicating insights effectively.
Power BI: Rounding up the top 5, Power BI is mentioned in 2609 job postings, highlighting the need for skills in this popular business intelligence tool for data analysis and reporting. */