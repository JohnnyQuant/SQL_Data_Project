-- Analyze the monthly demand for skills by counting the number of job postings for each skill in the first quarter (January to March), utilizing data from separate tables for each month. Ensure to include skills from all job postings across these months. The tables for the first quarter job postings were created in Practice Problem 6.


WITH first_quarter AS(
    SELECT
            job_id
            , job_posted_date
    FROM
            january_jobs
    
    UNION ALL

    SELECT
            job_id
            , job_posted_date
    FROM
            february_jobs
    
    UNION ALL

    SELECT
            job_id
            , job_posted_date
    FROM
            march_jobs)

SELECT
        SD.skills AS "Skill Name"
        , EXTRACT(YEAR FROM FQ.job_posted_date) AS "Year"
        , EXTRACT(MONTH FROM FQ.job_posted_date) AS "Month"
        , TO_CHAR(COUNT(*), 'FM999,999,999') AS "Number of Job Postings"
FROM
        first_quarter AS FQ
        INNER JOIN skills_job_dim AS SJD
        ON FQ.job_id = SJD.job_id
        INNER JOIN skills_dim AS SD
        ON SJD.skill_id = SD.skill_id
GROUP BY
        "Skill Name"
        , "Year"
        , "Month"
ORDER BY
        COUNT(*) DESC


---THe second way
-- CTE for combining job postings from January, February, and March
WITH combined_job_postings AS (
    SELECT job_id, job_posted_date
    FROM january_jobs
    UNION ALL
    SELECT job_id, job_posted_date
    FROM february_jobs
    UNION ALL
    SELECT job_id, job_posted_date
    FROM march_jobs
),
-- CTE for calculating monthly skill demand based on the combined postings
monthly_skill_demand AS (
    SELECT
        skills_dim.skills,  
        EXTRACT(YEAR FROM combined_job_postings.job_posted_date) AS year,  
        EXTRACT(MONTH FROM combined_job_postings.job_posted_date) AS month,  
        COUNT(combined_job_postings.job_id) AS postings_count 
    FROM
        combined_job_postings
    INNER JOIN skills_job_dim ON combined_job_postings.job_id = skills_job_dim.job_id  
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id  
    GROUP BY
        skills_dim.skills, 
        year, 
        month
)
-- Main query to display the demand for each skill during the first quarter
SELECT
    skills,  
    year,  
    month,  
    postings_count 
FROM
    monthly_skill_demand
ORDER BY
    skills, 
    year,
    month;  