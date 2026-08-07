
/*

/*
Question 2: What skills are listed for the top-paying remote Data Analyst jobs available to candidates in Canada?

- Identify the top 10 highest-paying remote job postings classified as Data Analyst roles in Canada.
- Include only postings with clearly stated average annual salaries so the opportunities can be compared accurately.
- Connect the top-paying job postings to the skills recorded for each role.
- Review the technical tools and skills that appear across these higher-paying opportunities.
- Why? This analysis helps show which skills are connected to higher-paying Data Analyst roles and gives job seekers a clearer idea of the tools 
that may be valuable to learn.

*/

*/

WITH top_paying_jobs AS (
    SELECT 
        job_id, 
        job_title,
        job_title_short,
        company_dim.name AS company_name,
        job_country,
        job_work_from_home,
        salary_year_avg
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
    LIMIT 10
)


SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN
    skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id;



/*

[
  {
    "job_id": 1004833,
    "job_title": "Financial & Data Analyst - Pricing (12 months Contract)",
    "job_title_short": "Data Analyst",
    "company_name": "Siemens",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "385000.0",
    "skills": "excel"
  },
  {
    "job_id": 1004833,
    "job_title": "Financial & Data Analyst - Pricing (12 months Contract)",
    "job_title_short": "Data Analyst",
    "company_name": "Siemens",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "385000.0",
    "skills": "sap"
  },
  {
    "job_id": 883859,
    "job_title": "Medical Analytics",
    "job_title_short": "Data Analyst",
    "company_name": "Pfizer",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "198500.0",
    "skills": "gcp"
  },
  {
    "job_id": 1834828,
    "job_title": "Analytics Engineer, GTM",
    "job_title_short": "Data Analyst",
    "company_name": "Owner.com",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "170000.0",
    "skills": "sql"
  },
  {
    "job_id": 1834828,
    "job_title": "Analytics Engineer, GTM",
    "job_title_short": "Data Analyst",
    "company_name": "Owner.com",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "170000.0",
    "skills": "python"
  },
  {
    "job_id": 1834828,
    "job_title": "Analytics Engineer, GTM",
    "job_title_short": "Data Analyst",
    "company_name": "Owner.com",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "170000.0",
    "skills": "go"
  },
  {
    "job_id": 1834828,
    "job_title": "Analytics Engineer, GTM",
    "job_title_short": "Data Analyst",
    "company_name": "Owner.com",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "170000.0",
    "skills": "c"
  },
  {
    "job_id": 1834828,
    "job_title": "Analytics Engineer, GTM",
    "job_title_short": "Data Analyst",
    "company_name": "Owner.com",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "170000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 1819664,
    "job_title": "Lead Data Analyst, Product Growth",
    "job_title_short": "Data Analyst",
    "company_name": "Life360",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "164500.0",
    "skills": "sql"
  },
  {
    "job_id": 1819664,
    "job_title": "Lead Data Analyst, Product Growth",
    "job_title_short": "Data Analyst",
    "company_name": "Life360",
    "job_country": "Canada",
    "job_work_from_home": true,
    "salary_year_avg": "164500.0",
    "skills": "python"
  }
]

*/