# Intoduction
This project delves into the job market, with a specific focus on data analytics. It explores the highest-paying roles for data analysts, the skills in demand, and where high demand aligns with lucrative salaries in the data analysis field.

🔎SQL queries? Check them out here [project_sql folder](/project_sql/)

# Background

Motivated by a quest to navigate the data analyst job market more effectively, this project emerged from a desire to pinpoint top-paid and in-demand skills, streamlining other work to find optimal jobs.

Data is sourced from the 🔗[SQL Course](https://lukebarousse.com/sql), which provides valuable insights into job titles, salaries, locations, and essential skills.

### The questions I sought to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for the top-paying Data Analyst jobs?
3. What are the most in-demand skills for Data Analysts?
4. What are the top skills based on salary?
5. What are the most optimal skills to learn?

# Tools I Used
🔧 For this analysis, I used several key tools:

**Postgres SQL**: Selected as the database management system, it's optimal for managing job posting data.
**Visual Studio Code**: My primary tool for database management and SQL query execution.
**Git and GitHub**: Crucial for version control and sharing SQL scripts and analyses, fostering collaboration and project tracking.
**Tableau**: Utilized for data visualization, empowering the creation of insightful visual representations of my analyses.

# The Analysis
Queries in this project aimed to investigate specific facets of the data analysis job market.
Here's my approach to each question:

### 1. Top-paying data analyst jobs
o pinpoint the highest-paying positions, I sifted through data analyst roles based on average salary and location, with a focus on remote opportunities. This query returns the lucrative prospects within the field.

```sql
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
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

```

![Top 10 Remote Data Analysis Jobs with Highest Salaries in 2023](assets\1_top_paying_jobs.png)

The analysis of the top 10 highest-paying remote Data Analyst jobs in 2023 provides valuable insights into the landscape of data analysis opportunities. The top 10 paying data analyst roles range from $184,000 to $650,000, indicating significant salary potential in the field. The presence of titles such as Director of Analytics, Associate Director - Data Insights, and Principal Data Analyst indicates a hierarchy within the field, with higher-ranking positions commanding significantly higher salaries. Furthermore, the prevalence of full-time positions underscores the commitment required for these roles, suggesting that employers prioritize consistency and dedication in their remote workforce. 

### 2. Skills for the top-paying Data Analyst jobs
To grasp the skills needed for well-paid positions, I formulated a query that merged job postings with skills data, offering insights into the competencies prized by employers for high-paid roles.

```sql
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
```

![Skills count for the top 10 paying Data Analyst jobs in 2023](assets\2_top_paying_job_skills.png)

**SQL** is leading with a bold count of 8 across the top-paying roles, 
highlighting its fundamental importance for data manipulation and analysis tasks.

**Python** is mentioned 7 times in the high-paying job descriptions, 
indicating its significance for data processing, machine learning, and automation tasks.

**Tableau** is mentioned 6 times among the top-paying roles, 
showcasing the need for strong data visualization skills to communicate insights effectively. 

Other skills like **R**, **Azure**, **AWS**, **Atlassian**, **Pandas** , **Excel**, 
and **Snowflake** are mentioned across these roles. 
This reflects the diverse technical requirements and tools utilized 
in high-paying Data Analyst positions. 

### 3. Most in-demanded skills for Data Analyst

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand. 

```sql
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

```
| Skills    | Demand count |
|-----------|--------------|
| SQL       | 7291         |
| Excel     | 4611         |
| Python    | 4330         |
| Tableau   | 3745         |
| Power BI  | 2609         |

*Table1: The top 5 most in-demand skills for Data Analysts*

The top 5 most in-demand skills for Data Analysts, based on job postings that allow remote work, are as follows:

**SQL**: Leading the list with a demand count of 7291, SQL remains a fundamental skill for data analysis tasks, including data manipulation and querying databases.

**Excel**: Following closely behind with 4611 job postings mentioning it, Excel proficiency is highly sought-after for data organization, analysis, and reporting.

**Python**: With 4330 mentions, Python is in high demand for its versatility in data processing, machine learning, and automation tasks.
**Tableau**: Not far behind, Tableau is mentioned in 3745 job postings, indicating the importance of strong data visualization skills in communicating insights effectively.

**Power BI**: Rounding up the top 5, Power BI is mentioned in 2609 job postings, highlighting the need for skills in this popular business intelligence tool for data analysis and reporting. */

### 4. Top skills based on the salary

This query, exploring the average salaries associated with different skills, revealed which skills are the highest paying 

```sql
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
```

| Skills          | Avgerage yearly salary ($) |
|-----------------|------------|
| PySpark         | 208172     |
| Bitbucket       | 189155     |
| Watson          | 160515     |
| Couchbase       | 160515     |
| DataRobot       | 155486     |
| GitLab          | 154500     |
| Swift           | 153750     |
| Jupyter         | 152777     |
| Pandas          | 151821     |
| Elasticsearch  | 145000     |

*Table2: Top 10 Salary-Based Skills for Remote Data Analysis Jobs in 2023* 

**Demand for Advanced Technologies**: *PySpark, Databricks*, and *Elasticsearch* signify a strong demand for skills in big data processing and cloud computing, commanding top salaries in the data analysis field. Proficiency in these technologies, coupled with expertise in Machine Learning (ML) algorithms optimized for big data, allows data scientists to efficiently  process and derive insights from massive datasets.

**Valuable Collaboration and Development Tools**: *Bitbucket, GitLab,* and *Jupyter* are highly valued, highlighting the importance of collaboration  tools and development environments for efficient code management and  workflow automation. Integration of ML models into these development workflows, along with version control and continuous integration practices, streamlines the deployment of ML solutions in big data environments.

**Specialized Data Analysis Platforms and Libraries Remain Lucrative**: 
*Couchbase, Watson, DataRobot* and *Pandas* indicate a continued demand for expertise in data analysis platforms, machine learning, and statistical analysis libraries, offering high-paying roles in the industry. 

### 5. Most optima skills to learn

This query combines insights from both demand and salary data. Its outcome reveals skills that are both highly demanded and offer high salariesю

```sql
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
```


| Skills       | Demand Count | Avg. yearly salary ($) |
|--------------|--------------|------------|
| Go           | 27           | 115320     |
| Confluence   | 11           | 114210     |
| Hadoop       | 22           | 113193     |
| Snowflake    | 37           | 112948     |
| Azure        | 34           | 111225     |
| BigQuery     | 13           | 109654     |
| AWS          | 32           | 108317     |
| Java         | 17           | 106906     |
| SSIS         | 12           | 106683     |
| Jira         | 20           | 104918     |
| Oracle       | 37           | 104534     |
| Looker       | 49           | 103795     |
| NoSQL        | 13           | 101414     |
| Python       | 236          | 101397     |
| R            | 148          | 100499     |
| Redshift     | 16           | 99936      |
| Qlik         | 13           | 99631      |
| Tableau      | 230          | 99288      |
| SSRS         | 14           | 99171      |
| Spark        | 13           | 99077      |
| C++          | 11           | 98958      |
| SAS          | 63           | 98902      |
| SAS          | 63           | 98902      |
| SQL Server   | 35           | 97786      |
| JavaScript   | 20           | 97587      |

*Table3 : Top 25 Skills for Remote Data Analysis Jobs based on highest salaries in 2023*

The most financially rewarding skill to learn for remote Data Analyst positions is **Go**,  with an average salary of $115,320 and a demand count of 27.

Following closely behind is **Confluence** with an average salary of $114,210 and a demand count of 11.

**Hadoop**, **Snowflake**, and **Azure**are also highly lucrative skills, with average salaries of $113,193, $112,948, and $111,225 respectively.

**Python** and **R** are among the most in-demand skills, with demand 
counts of 236 and 148 respectively, and average salaries exceeding $100,000.

**Tableau** is another highly sought-after skill, with a demand count of 230 and an average salary of $99,288.

In conclusion, aspiring Data Analysts seeking remote positions should focus on acquiring skills like **Go**, **Confluence**, **Hadoop**, **Snowflake**, **Azure**, **Python**, **R**, and **Tableau** to maximize both job security and financial benefits. 

# Conclusions 

In summary, this project delves deep into the data job market, specifically focusing on roles within data analysis. Through extensive analysis and SQL queries, it identifies the top-paying data analyst jobs, in-demand skills, and the intersection of high demand with high salaries in data analytics.

The top-paying remote data analysis jobs in 2023 offer significant salary potential, with roles ranging from $184,000 to $650,000, indicating a hierarchy within the field and a preference for full-time positions.

Skills like SQL, Python, and Tableau emerge as fundamental requirements for high-paying data analyst roles, reflecting the importance of data manipulation, analysis, and visualization.

Moreover, the analysis highlights the most in-demand skills for data analysts, such as SQL, Excel, and Python, underscoring their significance in remote job postings.

By identifying skills with both high demand and high salaries, such as Go, Confluence, and Hadoop, aspiring data analysts can strategically focus on acquiring the skills that offer optimal job security and financial benefits in the remote data analysis job market. 