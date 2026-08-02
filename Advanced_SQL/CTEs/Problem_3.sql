-- Your goal is to calculate two metrics for each company:
-- 1. The number of unique skills required for their job postings.
-- 2. The highest average annual salary among job postings that require at least one skill.

-- Your final query should return the company name, the count of unique skills, and the highest salary.
-- For companies with no skill-related job postings, the skill count should be 0 and the salary should be null.

WITH compay_count_skill AS(SELECT
        CD.company_id
        , CD.name
        , COUNT(DISTINCT SJD.skill_id) AS skill_count
FROM
        company_dim AS CD
        LEFT JOIN job_postings_fact AS JPF
        ON CD.company_id = JPF.company_id
        LEFT JOIN skills_job_dim AS SJD
        ON SJD.job_id = JPF.job_id
GROUP BY
        CD.company_id
        , CD.name
ORDER BY
        3 DESC)


,  max_salary AS (SELECT
        JPF.company_id
        , MAX(JPF.salary_year_avg) AS max_salary

FROM
        job_postings_fact AS JPF
WHERE
        JPF.job_id IN (
                        SELECT
                                job_id
                        FROM
                                skills_job_dim
        )
GROUP BY
        JPF.company_id)

SELECT
        CCS.company_id
        , CCS.name AS "Company Name"
        , CCS.skill_count AS "Number of Distinct Count"
        , TO_CHAR(MS.max_salary, 'FM999,999,999') AS "Maximum Salary"
FROM
        compay_count_skill AS CCS
        LEFT JOIN max_salary AS MS
        ON CCS.company_id = MS.company_id

--- The Second Way
-- Counts the distinct skills required for each company's job posting
WITH required_skills AS (
    SELECT
        companies.company_id,
        COUNT(DISTINCT skills_to_job.skill_id) AS unique_skills_required
    FROM
        company_dim AS companies 
    LEFT JOIN job_postings_fact as job_postings ON companies.company_id = job_postings.company_id
    LEFT JOIN skills_job_dim as skills_to_job ON job_postings.job_id = skills_to_job.job_id
    GROUP BY
        companies.company_id
),
-- Gets the highest average yearly salary from the jobs that require at least one skills 
max_salary AS (
    SELECT
        job_postings.company_id,
        MAX(job_postings.salary_year_avg) AS highest_average_salary
    FROM
        job_postings_fact AS job_postings
    WHERE
        job_postings.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY
        job_postings.company_id
)
-- Joins 2 CTEs with table to get the query
SELECT
    companies.name,
    required_skills.unique_skills_required as unique_skills_required, --handle companies w/o any skills required
    max_salary.highest_average_salary
FROM
    company_dim AS companies
LEFT JOIN required_skills ON companies.company_id = required_skills.company_id
LEFT JOIN max_salary ON companies.company_id = max_salary.company_id
ORDER BY
    companies.name;