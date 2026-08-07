/*
Question 3: What are the most in-demand skills for Data Analyst jobs in Canada?

- Identify the top 10 skills that appear most frequently in Data Analyst job postings in Canada.
- Include all matching Data Analyst postings, regardless of salary, location type, or work arrangement.
- Count each job posting only once for each skill to avoid duplicate results.
- Rank the skills from the highest to the lowest demand.
- Why? This analysis shows which skills employers request most often and helps job seekers understand which tools and technical skills are most relevant 
across the Canadian Data Analyst job market.
*/


SELECT 
    skills,
    COUNT(DISTINCT skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_country = 'Canada'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10;