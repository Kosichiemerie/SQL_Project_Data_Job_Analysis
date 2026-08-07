
/*
Question 4: Which skills are associated with the highest average salaries for Data Analyst jobs in Canada?

- Calculate the average annual salary associated with each skill across Data Analyst job postings in Canada.
- Include only job postings with available annual salary information.
- Group the results by skill and rank them from the highest to the lowest average salary.
- Return the top 25 highest-paying skills.
- Why? This analysis helps identify the technical skills that appear alongside higher-paying Data Analyst opportunities and provides insight into skills 
that may be valuable to develop.

Note: The dataset does not state the currency used for the salary figures. 
The salary values are therefore shown without a currency label to avoid making an unsupported assumption.

Note: A high average salary does not necessarily mean that the skill itself causes a higher salary. 
Some skills may also appear in fewer job postings, which can affect the average.
*/


SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_annual_salary
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
    AND salary_year_avg IS NOT NULL
    AND job_country = 'Canada'
GROUP BY
    skills
ORDER BY
    avg_annual_salary DESC
LIMIT 25;