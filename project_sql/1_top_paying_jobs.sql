/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
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

/*The analysis of top data analyst roles in 2023 shows a broad salary spectrum, with the highest-paying positions ranging from $184,000 to $650,000, highlighting the strong earning potential in the field. 
High salaries are offered by a diverse set of employers, including companies such as SmartAsset, Meta, and AT&T, reflecting demand across multiple industries.
Additionally, the wide variety of job titles—from Data Analyst to Director of Analytics—underscores the range of responsibilities and specializations within data analytics roles.
*/
