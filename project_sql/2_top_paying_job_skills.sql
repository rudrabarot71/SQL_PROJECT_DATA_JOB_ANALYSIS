/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (

SELECT	
	job_id,
	job_title,
	salary_year_avg,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC

LIMIT 10
)
SELECT top_paying_jobs.*,
       skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC


/*SQL, Python, and Tableau clearly stand out as the most demanded skills.

There’s a long tail of supporting tools (cloud, BI, DevOps, analytics libraries), each appearing fewer times but collectively important.

The distribution reinforces that top-paying analyst roles require a broad, modern data toolkit, not just one core skill.

Key takeaway

It is clear that core querying + programming + visualization skills dominate, while cloud and collaboration tools act as strong differentiators at higher salary levels.