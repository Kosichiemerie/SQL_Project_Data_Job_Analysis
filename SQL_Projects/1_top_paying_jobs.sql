
/*
Question: What are the top-paying remote Data Analyst jobs available to candidates in Canada?

- Identify the top 10 highest-paying remote job postings classified as Data Analyst roles in Canada.
- Include only postings with clearly stated average annual salaries so the opportunities can be compared accurately.
- Review the job titles, employers, work schedules, salary information, and posting dates.
- The results represent the years covered by the dataset rather than one specific year.
- Why? This analysis highlights the remote Data Analyst opportunities offering the strongest earning potential, 
and shows the types of roles and employers connected to these salaries.


Additional analysis: What Data Analyst job opportunities are available in Winnipeg?

- Review job postings classified as Data Analyst roles and located in Winnipeg.
- Examine the available job titles, employers, work schedules, and posting dates.
- Salary is not used to rank the Winnipeg opportunities because all matching postings have NULL annual salary values.
- Confirm how Winnipeg is written in the location column so that all matching postings are included.
- Why? This provides a clearer picture of the local Data Analyst job market while also identifying a limitation in the 
available salary information.
*/

SELECT 
    job_id, 
    job_title,
    job_title_short,
    company_dim.name AS company_name,
    job_location,
    job_country,
    job_schedule_type,
    job_work_from_home,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst'
    AND job_country = 'Canada'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;


SELECT DISTINCT
    job_location
FROM
    job_postings_fact
WHERE
    job_country = 'Canada'
    AND job_location ILIKE '%Winnipeg%';


SELECT 
    job_id, 
    job_title,
    job_title_short,
    name AS company_name,
    job_location,
    job_country,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND job_location ILIKE '%Winnipeg%' 
    AND job_country = 'Canada'
ORDER BY
    job_posted_date DESC;


