--- Update the job posting with the job_id = 2 .
--- Update the remote column for this job posting to TRUE in data_science_jobs.
UPDATE data_science_jobs
SET remote = TRUE
WHERE job_id = 2;

SELECT *
FROM data_science_jobs