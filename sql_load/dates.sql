SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS avg_yearly_salary,
    AVG(salary_hour_avg) AS avg_hourly_salary 
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type
ORDER BY job_schedule_type ASC


SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(*) AS job_postings_count
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY month
ORDER BY month;

SELECT DISTINCT
    c.company_id,
    c.name AS company_name
FROM job_postings_fact j
JOIN company_dim c
  ON j.company_id = c.company_id
WHERE j.job_health_insurance = TRUE
  AND j.job_posted_date >= '2023-04-01'
  AND j.job_posted_date <  '2023-07-01'
ORDER BY company_name;

CREATE TABLE january_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE 
    job_title_short  = 'Data Analyst'
GROUP BY location_category;

SELECT
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 120000 THEN 'High'
        WHEN salary_year_avg >= 70000 THEN 'Standard'
        ELSE 'Low'
    END AS salary_bucket
FROM job_postings_fact
WHERE job_title ILIKE '%data analyst%'
ORDER BY salary_year_avg DESC;


SELECT * --SUBQUERY
FROM ( 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) AS january_jobs;

--CTE COMMON TABLE EXPRESSIONS
WITH january_jobs AS ( --CTE BEGINS HERE
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) --CTE ENDS HERE

SELECT *
FROM january_jobs

SELECT name AS company_name
FROM company_dim
WHERE company_id IN (

SELECT 
    company_id

FROM 
    job_postings_fact

WHERE job_no_degree_mention = true
)

WITH company_job_count AS (
    SELECT 
    company_id,
    COUNT(*) AS total_jobs

FROM 
    job_postings_fact
GROUP BY
    company_id
)
SELECT company_dim.name AS company_name,company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC

SELECT
    s.skills,
    top_skills.skill_count
FROM (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY skill_count DESC
    LIMIT 5
) AS top_skills
JOIN skills_dim AS s
  ON top_skills.skill_id = s.skill_id
ORDER BY top_skills.skill_count DESC;


SELECT
    c.company_id,
    c.name AS company_name,
    job_counts.total_jobs,
    CASE
        WHEN job_counts.total_jobs < 10 THEN 'Small'
        WHEN job_counts.total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
) AS job_counts
JOIN company_dim c
  ON job_counts.company_id = c.company_id
ORDER BY job_counts.total_jobs DESC;

WITH remote_job_skills AS (

SELECT 
    skill_id,
    COUNT(*) AS skill_count
FROM 
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE job_postings.job_work_from_home = True AND job_postings.job_title_short = 'Data Analyst'
GROUP BY skill_id
)
SELECT skills.skill_id,
    skills as skill_name,
    skill_count


FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5


SELECT 
          job_title_short,
          company_id,
          job_location
FROM 
          january_job

UNION ALL

SELECT 
          job_title_short,
          company_id,
          job_location
FROM 
          february_job

UNION ALL

SELECT 
          job_title_short,
          company_id,
          job_location
FROM 
          march_job


SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM (
SELECT *
FROM january_job
UNION ALL 
SELECT * 
FROM february_job
UNION ALL
SELECT *
FROM march_job
) AS quarter1_job_postings
WHERE quarter1_job_postings.salary_year_avg >70000 AND
quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY quarter1_job_postings.salary_year_avg DESC

SELECT job_location
FROM job_postings_fact
WHERE job_location ILIKE '%india%' 
