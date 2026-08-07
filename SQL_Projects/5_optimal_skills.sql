
/*
Question 5: Which skills offer the strongest combination of demand and average salary for Data Analyst jobs in Canada?

- Identify skills that are both frequently listed and associated with strong average salaries.
- Include Data Analyst job postings in Canada with available annual salary information.
- Count how many different job postings include each skill and calculate the average annual salary associated with that skill.
- Combine the demand and salary results to compare both factors in one view.
- Rank the skills primarily by demand, followed by average salary, and return the top 25.
- Why? This analysis helps identify skills that are widely requested by employers while also being connected to stronger salary opportunities, 
providing useful guidance on which skills may be valuable to develop.

Note: The dataset does not state the currency used for the salary figures. 
The salary values are therefore shown without a currency label to avoid making an unsupported assumption.
*/

WITH top_demanded_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
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
        AND salary_year_avg IS NOT NULL
        AND job_country = 'Canada'
    GROUP BY
        skills_dim.skill_id
),

top_avg_paying_skills AS (
    SELECT 
        skills_job_dim.skill_id,
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
        skills_job_dim.skill_id
)


SELECT 
    top_demanded_skills.skill_id,
    top_demanded_skills.skills,
    demand_count,
    avg_annual_salary
FROM 
    top_demanded_skills
INNER JOIN  
    top_avg_paying_skills
    ON top_demanded_skills.skill_id = top_avg_paying_skills.skill_id
ORDER BY
    demand_count DESC,
    avg_annual_salary DESC
LIMIT 25;