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


