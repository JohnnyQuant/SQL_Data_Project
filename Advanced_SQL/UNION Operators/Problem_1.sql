--- Create a unified query categorizing job postings into two groups: those With Salary Info and those Without Salary Info.
--- Return job_id, job_title, and a new column named salary_info.

(SELECT
        job_id
        , job_title
        , 'With Salary Info' AS "Salary Info"
FROM
        job_postings_fact
WHERE
        salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL)

UNION ALL

(SELECT
        job_id
        , job_title
        , 'Without Salary Info' AS "Salary Info"
FROM
        job_postings_fact
WHERE
        salary_year_avg IS NULL
        AND salary_hour_avg IS NULL)

ORDER BY
        job_id
        , "Salary Info" DESC


-- Select job postings with salary information
(
SELECT 
    job_id, 
    job_title, 
    'With Salary Info' AS salary_info  -- Custom field indicating salary info presence
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL  
)
UNION ALL
 -- Select job postings without salary information
(
SELECT 
    job_id, 
    job_title, 
    'Without Salary Info' AS salary_info  -- Custom field indicating absence of salary info
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NULL AND salary_hour_avg IS NULL 
)
ORDER BY 
    salary_info DESC, 
    job_id; 


