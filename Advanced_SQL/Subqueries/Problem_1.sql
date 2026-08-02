-- Identify the top 5 skills that are most frequently mentioned in job postings.
-- Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill names.

SELECT
        SN.skill_id AS "Skill ID"
        , SN.skills AS "Skill Name"
        , TO_CHAR(COUNT(*), 'FM999,999,999') AS "Number of Job Postings"
FROM
        (SELECT
                   SJD.job_id
                    , SD.skills
                    , SD.skill_id
        FROM
                    skills_dim AS SD
                    INNER JOIN skills_job_dim AS SJD
                    ON SD.skill_id = SJD.skill_id) AS SN
        INNER JOIN job_postings_fact AS JPF
        ON SN.job_id = JPF.job_id

GROUP BY
        SN.skill_id
        , SN.skills
ORDER BY
        COUNT(*) DESC
LIMIT 5;

SELECT skills_dim.skills
FROM skills_dim
INNER JOIN (
    SELECT 
        skill_id,
        COUNT(job_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(job_id) DESC
    LIMIT 5
) AS top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY top_skills.skill_count DESC;