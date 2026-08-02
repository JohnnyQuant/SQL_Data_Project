--- Retrieve the job id, job title short, job location, job via, skill and skill type for each job posting from the first quarter (January to March). Using a subquery to combine job postings from the first quarter (these tables were created in the Advanced Section - Practice Problem 6 Video) Only include postings with an average yearly salary greater than $70,000.


SELECT
        FQ.job_id
        , FQ.job_title_short
        , FQ.job_location
        , FQ.job_via
        , SD.skills
        , SD.type

FROM
        (SELECT
                job_id
                , job_title_short
                , job_location
                , job_via
        FROM
                january_jobs
        WHERE
                salary_year_avg > 70000
        UNION ALL

        SELECT
                job_id
                , job_title_short
                , job_location
                , job_via
        FROM
                february_jobs
        WHERE
                salary_year_avg > 70000
                
        UNION ALL
        
        SELECT
                job_id
                , job_title_short
                , job_location
                , job_via
        FROM
                march_jobs
        WHERE
                salary_year_avg > 70000) AS FQ
        LEFT JOIN skills_job_dim AS SJD
        ON FQ.job_id = SJD.job_id
        LEFT JOIN skills_dim AS SD
        ON SJD.skill_id = SD.skill_id;


---The second way
SELECT
    job_postings_q1.job_id,
    job_postings_q1.job_title_short,
    job_postings_q1.job_location,
    job_postings_q1.job_via,
    job_postings_q1.salary_year_avg,
    skills_dim.skills,
    skills_dim.type
FROM
-- Get job postings from the first quarter of 2023
    (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
    ) as job_postings_q1
LEFT JOIN skills_job_dim ON job_postings_q1.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_q1.salary_year_avg > 70000
ORDER BY
    job_postings_q1.job_id;

