# The Data Analyst Career Market: An SQL Analysis

## 📚 Table of Contents

- [Introduction](#introduction)
- [Background](#background)
- [Business Questions](#business-questions)
- [Tools I Used](#tools-i-used)
- [The Analysis](#the-analysis)
  - [1. Top-Paying Remote Data Analyst Jobs](#1-top-paying-remote-data-analyst-jobs)
  - [2. Skills Listed for Top-Paying Jobs](#2-skills-listed-for-top-paying-jobs)
  - [3. Most In-Demand Skills](#3-most-in-demand-skills)
  - [4. Skills Associated with the Highest Average Salaries](#4-skills-associated-with-the-highest-average-salaries)
  - [5. Skills Combining Strong Demand and Salary](#5-skills-combining-strong-demand-and-salary)
- [What I Learned](#what-i-learned)
- [Key Insights](#key-insights)
- [Limitations](#limitations)
- [Conclusion](#conclusion)

---

## Introduction

Welcome to my SQL portfolio project.

This project uses SQL to explore the Data Analyst job market in Canada. The goal was to better understand the types of Data Analyst opportunities available, which roles offer the highest salaries, which skills employers list most often, which skills are associated with higher salaries, and which skills offer a useful balance between demand and earning potential.

I also included a separate look at Data Analyst opportunities in Winnipeg to better understand the local job market.

The SQL queries used for this analysis are available in this repository [project_sql folder](/SQL_Projects/)

---

## Background

I created this project to better understand the Data Analyst job market and use real job-posting data to answer questions that are useful for career planning and job searching.

The dataset used for this analysis comes from [Data Nerd](https://datanerd.tech/). It contains information about job postings, including job titles, companies, locations, salaries, work arrangements, and skills connected to each role.

For this project, I focused specifically on job postings classified as **Data Analyst** roles in Canada.

The analysis covers the full period available in the dataset rather than one specific year.

### Salary Note

The dataset does not state the currency used for the salary figures. For this reason, salary values are presented without a currency label to avoid making an unsupported assumption.

---

## Business Questions

The project was built around five main questions:

1. **What are the top-paying remote Data Analyst jobs available to candidates in Canada?**
2. **What skills are listed for these top-paying roles?**
3. **What are the most in-demand skills for Data Analyst jobs in Canada?**
4. **Which skills are associated with the highest average salaries for Data Analyst jobs in Canada?**
5. **Which skills offer the strongest combination of demand and average salary for Data Analyst jobs in Canada?**

---

## Tools I Used

I used the following tools to complete this project:

- **SQL:** Used to filter, join, group, sort, and analyze the job-posting data.
- **PostgreSQL:** Used as the database management system for storing and querying the dataset.
- **Visual Studio Code:** Used to write, organize, and run my SQL queries.
- **SQLTools:** Used inside Visual Studio Code to connect to PostgreSQL and view query results.
- **Git:** Used for version control and tracking changes made throughout the project.
- **GitHub:** Used to store, organize, and publish the completed project.

---

# The Analysis

Each query was created to answer a different question about the Data Analyst job market. Here's how I approached each question:

---

## 1. Top-Paying Remote Data Analyst Jobs

### Question

**What are the top-paying remote Data Analyst jobs available to candidates in Canada?**

For the first part of the analysis, I identified the top 10 highest-paying remote job postings classified as Data Analyst roles in Canada with available annual salary information. I also joined the company table to include employer names, and ranked the results from highest to lowest salary.

```sql
SELECT 
    job_postings_fact.job_id, 
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
```

### Key Findings

- The top 10 salary values ranged from **150,000 to 385,000**.
- **Siemens** had the highest-paying posting at **385,000**, followed by **Pfizer** at **198,500** and **Tanamera** at **180,000**.
- High-paying opportunities were listed under different titles, including **Financial & Data Analyst, Analytics Engineer, and Principal Data Analyst**.
- This showed that relevant Data Analyst opportunities may appear under different job titles, not only **"Data Analyst."**

### Winnipeg Data Analyst Opportunities

I also reviewed Data Analyst postings in Winnipeg using:

```sql
job_location ILIKE '%Winnipeg%'
```

This allowed me to capture different ways Winnipeg was written in the dataset.

### Key Findings

- The search returned **45 Data Analyst postings** in Winnipeg.
- Employers included **Manitoba Public Insurance, Manitoba Hydro, University of Manitoba, Government of Manitoba, and City of Winnipeg**.
- Most postings were full-time, with some internship and contractor roles.
- All matching Winnipeg postings had `NULL` annual salary values, so they could not be reliably ranked by salary.

> **Data limitation:** The missing Winnipeg salary information reflects a limitation in the dataset, not an error in the query.

![Top Paying Roles](csv_files\Visuals\Query_1\1.png)
> *Top 10 highest-paying Data Analyst jobs in Canada based on the SQL query results.*

![Top Paying Data Analyst Jobs Summary](csv_files\Visuals\Query_1\2.png)
> *Summary of the top-paying remote Data Analyst roles in Canada, highlighting the highest salary, leading employer, average salary, and key patterns across the top 10 results.*
---

## 2. Skills Listed for Top-Paying Jobs

### Question

**What skills are listed for the top-paying remote Data Analyst jobs available to candidates in Canada?**

After identifying the top-paying remote Data Analyst jobs, I connected those postings to the skills tables using each job's unique ID to see which skills were listed for the roles.

```sql
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
```

### Key Findings

- Skill information was available for **9 of the 10 top-paying job postings**, producing **33 job-and-skill combinations**.
- **SQL** was the most frequently listed skill, appearing in **6 of the 9 postings**.
- **Python** followed with **5 postings**, while **Excel** appeared in **4**.
- **Snowflake** and **Tableau** each appeared in **3 postings**.
- The results included a mix of querying, programming, visualization, spreadsheet, cloud, and data-platform skills.

Overall, **SQL, Python, and Excel** stood out as the strongest common foundation among the higher-paying roles, while tools such as Snowflake, Tableau, Power BI, Databricks, and BigQuery appeared in more specialized opportunities.

A skill appearing less frequently does not necessarily mean that it is unimportant. It simply means that fewer jobs within this small group listed it.

> **Data limitation:** One of the original top 10 job postings did not have matching skill information in the dataset, so it was not included in the final skills output.

![Top Skills in Top-Paying Data Analyst Roles](csv_files\Visuals\Query_2\1.png)
> *Top 10 skills listed across the top-paying remote Data Analyst roles in Canada, showing how often each skill appeared in the analyzed postings.*


![Top-Paying Data Analyst Roles Skills Summary](csv_files\Visuals\Query_2\2.png)

> *Summary of the top skills listed in the top-paying remote Data Analyst roles in Canada, highlighting the number of jobs analyzed, the most common skill, its frequency, and key patterns from the results.*


---

## 3. Most In-Demand Skills

### Question

**What are the most in-demand skills for Data Analyst jobs in Canada?**

For this part of the project, I examined all job postings classified as Data Analyst roles in Canada to identify the skills employers listed most often.

Unlike Query 2, which focused only on skills linked to the top-paying remote jobs, Query 3 looks at skill demand across the wider Canadian Data Analyst job market.

```sql
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
```

`COUNT(DISTINCT job_id)` ensures that each job posting is counted only once for each skill.

### Top 10 Most In-Demand Skills

| Skill     | Number of Job Postings |
| --------- | ---------------------: |
| SQL       |                  3,368 |
| Python    |                  2,405 |
| Excel     |                  2,092 |
| Tableau   |                  1,564 |
| Power BI  |                  1,432 |
| R         |                    969 |
| Azure     |                    688 |
| Snowflake |                    494 |
| Word      |                    491 |
| AWS       |                    487 |

### Key Findings

- **SQL** was the most in-demand skill with **3,368 postings**, followed by **Python** with **2,405** and **Excel** with **2,092**.
- **Tableau** and **Power BI** both ranked in the top five, showing strong demand for data visualization and reporting skills.
- **Azure, Snowflake, and AWS** also appeared in the top 10, showing demand for cloud and modern data-platform knowledge.
- Overall, **SQL, Python, and Excel** stood out as the strongest common foundation across the Canadian Data Analyst job market.

> **Important note:** This analysis measures demand based on how often each skill appeared in the dataset. A skill being highly demanded does not automatically mean that it is associated with the highest salary.

---

## 4. Skills Associated with the Highest Average Salaries

### Question

**Which skills are associated with the highest average salaries for Data Analyst jobs in Canada?**

I analyzed Data Analyst postings in Canada with available salary information and calculated the average annual salary associated with each skill.

Unlike Query 3, which measured how often a skill appeared, this analysis focuses on **salary rather than demand**.

```sql
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
```

### Top Skills by Average Salary

| Skill | Average Annual Salary |
|---|---:|
| Phoenix | 272,500 |
| MongoDB | 198,795 |
| Cassandra | 198,795 |
| Elasticsearch | 198,795 |
| DynamoDB | 198,795 |
| Kafka | 198,795 |
| Neo4j | 198,795 |
| Terraform | 198,795 |
| Kubernetes | 198,795 |
| MySQL | 198,795 |

### Key Findings

- **Phoenix** had the highest average salary value at **272,500**.
- Several database and data-infrastructure skills, including **MongoDB, Cassandra, Elasticsearch, Kafka, Terraform, Kubernetes, and MySQL**, were each associated with an average salary of **198,795**.
- Other high-ranking skills included **Aurora, C, Atlassian, PyTorch, and TensorFlow**.
- Overall, many of the higher-paying skills were more specialized and connected to **databases, cloud platforms, data infrastructure, and machine learning**.

### Query 3 vs. Query 4

Query 3 showed which skills appeared most often across Data Analyst job postings, while Query 4 shows which skills were associated with the highest average salaries.

Looking at both helps separate **high-demand skills from higher-paying skills**.

> **Important note:** Some skills may appear in only a small number of job postings, which can make their average salary appear unusually high. The results therefore show salary associations within this dataset and do not mean that learning a specific skill will automatically lead to a higher salary.

> **Salary note:** The dataset does not specify the currency used, so the salary values are shown without a currency label.

---

## 5. Skills Combining Strong Demand and Salary

### Question

**Which skills offer the strongest combination of demand and average salary for Data Analyst jobs in Canada?**

For the final analysis, I combined **skill demand** and **average salary** to identify skills that offer a useful balance between job opportunities and earning potential.

Only Data Analyst postings in Canada with available salary information were included so that both demand and salary could be compared using the same group of jobs.

```sql
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
```

### Top Skills by Demand and Average Salary

| Skill | Demand Count | Average Annual Salary |
|---|---:|---:|
| SQL | 119 | 98,937.92 |
| Python | 78 | 102,912.55 |
| Tableau | 60 | 95,590.18 |
| Excel | 60 | 88,152.43 |
| Power BI | 57 | 87,663.45 |
| Snowflake | 35 | 107,260.79 |
| R | 32 | 96,944.70 |
| Azure | 27 | 102,329.09 |
| Looker | 21 | 111,389.95 |
| Databricks | 19 | 115,229.08 |

### Key Findings

- **SQL** had the highest demand with **119 postings**, while **Python** followed with **78 postings** and a higher average salary.
- **Tableau, Excel, and Power BI** showed strong demand, confirming the importance of reporting and visualization skills.
- **Snowflake, Azure, Looker, and Databricks** had lower demand than the core tools but were associated with stronger average salaries.
- **C** had the highest average salary among the skills shown at **166,250**, but appeared in only **10 postings**, showing why salary alone does not make a skill "optimal."
- Overall, **SQL and Python** stood out as the strongest balance of demand and salary.

### Query 4 vs. Query 5

Query 4 focused only on salary, which means a skill could rank very highly even if it appeared in only a few job postings.

Query 5 adds demand to the analysis, giving a more balanced view of which skills may be worth learning.

### Why the Demand Counts Are Lower Than Query 3

Query 3 measures demand across all matching Data Analyst postings in Canada.

Query 5 only includes postings that also contain salary information, so the demand counts are lower.

> **Important note:** Demand is given priority in this ranking. When two skills have the same demand, the skill with the higher average salary ranks first.

> **Salary note:** The dataset does not specify the currency used, so the salary values are shown without a currency label.

---

# What I Learned

This project strengthened my SQL skills and helped me understand how to turn business questions into clear, data-driven answers.

### Key SQL Skills Practiced

- **Joins:** Used `LEFT JOIN` and `INNER JOIN` to connect related tables.
- **CTEs:** Used `WITH` statements to break complex queries into smaller, easier steps.
- **Filtering:** Used `WHERE`, `IS NOT NULL`, and `ILIKE` to focus the analysis and handle missing or differently formatted data.
- **Aggregation:** Used `COUNT()`, `COUNT(DISTINCT ...)`, `AVG()`, and `ROUND()` to measure demand and salary.
- **Grouping and Ranking:** Used `GROUP BY`, `ORDER BY`, and `LIMIT` to summarize and rank jobs and skills.
- **Analytical Thinking:** Learned that high demand does not always mean high salary, and that looking at both gives a more complete picture of the job market.

---

# Key Insights

- **High-paying Data Analyst roles can appear under different job titles**, so job seekers may benefit from searching beyond the exact title "Data Analyst."
- **SQL, Python, and Excel** appeared consistently across the analysis and stand out as strong foundational skills.
- **Tableau and Power BI** were also highly demanded, showing the importance of reporting and data visualization.
- **High demand and high salary are not always the same.** Some specialized skills had higher average salaries but appeared in fewer job postings.
- **Specialized tools** such as Snowflake, Databricks, Azure, Looker, and Redshift may be valuable additions after building a strong foundation.
- Looking at **demand and salary together** gives a more useful picture of which skills may offer both job opportunities and stronger earning potential.

---

# Limitations

- **Salary currency was not specified**, so salary values are shown without a currency label.
- **Some postings had missing salary data**, including all Winnipeg postings analyzed, so they could not be used in salary comparisons.
- **Some skills appeared in only a few postings**, which may make their average salaries look unusually high.
- **Skill information was not available for every job posting**, including one of the top 10 remote roles in Query 2.
- The dataset covers **multiple years** and reflects only the jobs included in this dataset, so the findings should not be treated as a complete picture of the entire Canadian Data Analyst job market.
---

# Conclusion

This project strengthened both my **SQL skills** and my understanding of the Canadian Data Analyst job market.

The analysis showed that **SQL, Python, and Excel** are strong foundational skills, while **Tableau and Power BI** remain important for reporting and visualization. More specialized tools such as **Snowflake, Databricks, Azure, Looker, and Redshift** were often associated with higher average salaries.

A key takeaway was that **high demand does not always mean high salary**. Looking at both factors together provided a more balanced view of which skills may offer stronger career opportunities.

Overall, the project helped me improve not only my SQL querying, but also my ability to **analyze business questions, interpret results, recognize data limitations, and communicate clear insights**.