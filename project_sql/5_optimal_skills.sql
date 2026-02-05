/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
    GROUP BY
        skills_dim.skill_id
), 

average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL 
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
INNER JOIN  average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE  
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*High-demand programming languages: Python and R continue to be the most sought-after skills, with demand counts of 236 and 148 respectively. Their average salaries—around $101,397 for Python and $100,499 for R—suggest that while these languages are highly valued, they are also relatively common in the talent pool.

Cloud tools and technologies: Expertise in platforms such as Snowflake, Azure, AWS, and BigQuery shows strong demand alongside comparatively higher average salaries, highlighting the increasing importance of cloud infrastructure and big data technologies in modern data analysis.

Business intelligence and visualization tools: Tools like Tableau and Looker remain critical, with demand counts of 230 and 49 and average salaries of approximately $99,288 and $103,795. This underscores the role of visualization and BI in transforming data into actionable insights.

Database technologies: Continued demand for both traditional and NoSQL databases—including Oracle, SQL Server, and NoSQL systems—with average salaries ranging from $97,786 to $104,534 reflects the ongoing need for strong data storage, retrieval, and management capabilities.
*/