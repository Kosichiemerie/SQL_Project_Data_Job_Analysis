ALTER TABLE job_applied
ADD contact VARCHAR(50);

SELECT *
FROM job_applied;


ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;


ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;


ALTER TABLE job_applied
DROP COLUMN contact_name;

DROP TABLE job_applied;


ALTER TABLE data_science_jobs
ADD remote BOOLEAN;

ALTER TABLE data_science_jobs
RENAME COLUMN post_date TO posted_on;

SELECT *
FROM data_science_jobs;

ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT false;

insert into 
    data_science_jobs (job_id, job_title, company_name, posted_on)
values 
                    (4, 'Data Scientist', 'Google', 'February 5, 2023');



ALTER TABLE data_science_jobs
DROP COLUMN company_name;

