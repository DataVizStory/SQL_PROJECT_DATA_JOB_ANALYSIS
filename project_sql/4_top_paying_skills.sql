/*
Question: What are the top skills based on salary?
- Examine the average salary associated with each skill for Data Analyst positions.
- Focus on roles with specified salaries, regardless of location.
Why? This reveals how different skills impact salary levels for Data Analysts 
and helps identify the most financially rewarding skills to acquire for improvement.
*/

SELECT 
    skills,
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
    skills_dim .skills
ORDER BY
    avg_salary DESC
LIMIT 10 ;

/*
Demand for Advanced Technologies: PySpark, Databricks, Elasticsearch, 
and Kubernetes signify a strong demand for skills in big data processing 
and cloud computing, commanding top salaries in the data analysis field. 
Proficiency in these technologies, coupled with expertise in Machine Learning 
(ML) algorithms optimized for big data, allows data scientists to efficiently 
process and derive insights from massive datasets.

Valuable Collaboration and Development Tools: Bitbucket, GitLab, Jenkins, 
and Jupyter are highly valued, highlighting the importance of collaboration 
tools and development environments for efficient code management and 
workflow automation. Integration of ML models into these development workflows, 
along with version control and continuous integration practices, streamlines 
the deployment of ML solutions in big data environments.

Specialized Data Analysis Platforms and Libraries Remain Lucrative: 
Couchbase, Watson, DataRobot, Pandas, NumPy, and Scikit-learn indicate a continued demand 
for expertise in data analysis platforms, machine learning, and statistical analysis libraries, 
offering high-paying roles in the industry. 

Proficiency in these platforms and libraries, coupled with skills in distributed 
computing frameworks like PySpark and Databricks, enables data analysts to extract 
meaningful insights and build predictive models from large-scale datasets efficiently. 
*/