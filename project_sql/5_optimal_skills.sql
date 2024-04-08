/*
Question: What are the most optimal skills to learn 
(i.e., those in high demand and with high-paying potential)?
Identify skills in high demand and associated with high average 
salaries for Data Analyst roles.
Focus on remote positions with specified salaries.
Why? Target skills that offer job security (high demand) 
and financial benefits (high salaries), providing strategic insights for career development in data analysis.
*/


WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact 
    INNER JOIN 
        skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN 
        skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE job_title_short='Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home=True
    GROUP BY 
        skills_dim.skill_id
    
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG (salary_year_avg),0) AS avg_salary
    FROM job_postings_fact   
    INNER JOIN 
        skills_job_dim ON job_postings_fact.job_id=skills_job_dim .job_id
    INNER JOIN 
        skills_dim ON skills_job_dim.skill_id=skills_dim .skill_id
    WHERE 
        job_title_short='Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home=true
    GROUP BY 
        skills_job_dim.skill_id

)


SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN
average_salary ON skills_demand.skill_id=average_salary.skill_id
WHERE 
    demand_count>10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25 ;

/*The most financially rewarding skill to learn for remote Data Analyst positions is "Go", 
with an average salary of $115,320 and a demand count of 27.

Following closely behind is "Confluence" with an average salary of $114,210 
and a demand count of 11.

"Hadoop", "Snowflake", and "Azure" are also highly lucrative skills, 
with average salaries of $113,193, $112,948, and $111,225 respectively.

"Python" and "R" are among the most in-demand skills, with demand 
counts of 236 and 148 respectively, and average salaries exceeding $100,000.

"Tableau" is another highly sought-after skill, with a demand count of 230 
and an average salary of $99,288.

In conclusion, aspiring Data Analysts seeking remote positions should focus on acquiring skills like "Go", "Confluence", "Hadoop", "Snowflake", 
"Azure", "Python", "R", and "Tableau" to maximize both job security and financial benefits. */