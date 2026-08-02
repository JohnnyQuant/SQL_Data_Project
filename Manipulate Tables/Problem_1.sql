---Create a table named data_science_jobs that will hold information about job postings.
--- Include the following columns: job_id (integer and primary key), job_title (text), company_name (text), and post_date (date).

CREATE TABLE data_science_jobs (
        job_id INT PRIMARY key
        , job_title TEXT
        , company_name TEXT
        , post_date DATE
);

