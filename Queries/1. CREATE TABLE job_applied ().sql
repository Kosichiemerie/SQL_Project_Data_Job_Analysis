CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);


SELECT
    *
FROM
    job_applied;



INSERT INTO job_applied
            (job_id, 
            application_sent_date, 
            custom_resume, 
            resume_file_name, 
            cover_letter_sent, 
            cover_letter_file_name, 
            status)
VALUES
            (1, 
            '2024-02-01', 
            true, 
            'resume_01.pdf', 
            true, 
            'cover_letter_01.pdf', 
            'Submitted'),
            (2, 
            '2024-02-02', 
            false, 
            'resume_02.pdf', 
            false, 
            NULL, 
            'interview scheduled'),
            (3, 
            '2024-02-03', 
            true, 
            'resume_03.pdf', 
            true, 
            'cover_03.pdf', 
            'ghosted'),
            (4, 
            '2024-02-04', 
            true, 
            'resume_04.pdf', 
            false, 
            NULL, 
            'submitted'),
            (5, 
            '2024-02-05', 
            false, 
            'resume_05.pdf', 
            true, 
            'cover_letter_05.pdf', 
            'rejected');


SELECT
    *
FROM
    job_applied;



CREATE TABLE data_science_jobs
         (
            job_id INT PRIMARY KEY,
            job_title TEXT,
            company_name TEXT,
            post_date DATE
        );


INSERT INTO data_science_jobs
            (job_id,
            job_title,
            company_name,
            post_date)
VALUES
            (1,
            'Data Scientist',
            'Tech Innovations',
            'January 1, 2023'),
            (2,
            'Machine Learning Engineer',
            'Data Driven Co',
            'January 15, 2023'),
            (3,
            'AI Specialist',
            'Future Tech',
            'February 1, 2023');




SELECT *
FROM data_science_jobs;