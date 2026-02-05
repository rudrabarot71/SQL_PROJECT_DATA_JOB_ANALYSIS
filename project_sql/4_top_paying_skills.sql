/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;


/*
Strong demand for big data and machine learning skills: High-paying data analyst roles favor expertise in big data technologies (e.g., PySpark, Couchbase), machine learning platforms (DataRobot), and Python libraries (Pandas, NumPy), reflecting the value placed on large-scale data processing and predictive analytics.
Emphasis on software development and deployment skills: Knowledge of tools such as GitLab, Kubernetes, and Airflow highlights the premium on analysts who can support automation and manage efficient, production-ready data pipelines.
Growing importance of cloud computing expertise: Familiarity with cloud and data engineering platforms like Elasticsearch, Databricks, and GCP underscores the increasing reliance on cloud-based analytics environments and their impact on higher earning potential.
*/