--- Count the number of job postings for each month, adjusting the job_posted_date to be in 'America/New_York' time zone before extracting the month.
--- Assume the job_posted_date is stored in UTC. Group by and order by the month.


SELECT
        EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS "Month"
        , TO_CHAR(COUNT(job_posted_date), 'FM999,999,999') AS "Number of Job Postings"
---        , COUNT(job_posted_date)
FROM
        job_postings_fact

GROUP BY
        "Month"
ORDER BY
        "Month"
