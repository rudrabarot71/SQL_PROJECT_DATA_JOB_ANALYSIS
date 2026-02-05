/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.skill_id) AS demand_count
       
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5

/*The analysis of in-demand data analyst skills in 2023 highlights SQL and Excel as core requirements, reinforcing the importance of strong fundamentals in data querying and spreadsheet-based analysis.
 Additionally, programming and visualization tools such as Python, Tableau, and Power BI play a critical role, reflecting the growing emphasis on technical proficiency for data-driven insights and effective decision-making.
*/