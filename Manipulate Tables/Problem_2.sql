--- Insert three job postings into the data_science_jobs table.
--- Make sure each job posting has a unique job_id, a job_title, a company_name, and a post_date.
INSERT INTO data_science_jobs (
        job_id,
        job_title,
        company_name,
        post_date
    )
VALUES (
        1,
        'Data Scientist',
        'Tech Innovations',
        '2023-01-01'
    ),
    (
        2,
        'Machine Learning Engineer',
        'Data Driven Co',
        '2023-01-15'
    ),
    (
        3,
        'AI Specialist',
        'Future Tech',
        '2023-02-01'
    );