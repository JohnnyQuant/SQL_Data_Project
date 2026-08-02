-- Count the number of unique companies that offer work from home (WFH) versus those requiring work to be on-site.
-- Use the job_postings_fact table to count and compare the distinct companies based on their WFH policy (job_work_from_home).

SELECT
        CASE
            WHEN job_work_from_home IS TRUE THEN 'WFH'
            ELSE 'On-site'
        END AS "Working Category"
        , TO_CHAR(COUNT(DISTINCT company_id), 'FM999,999,999') AS "Number of Companies"
FROM
        job_postings_fact

GROUP BY
        "Working Category";

SELECT 
    COUNT(DISTINCT CASE WHEN job_work_from_home = TRUE THEN company_id END) AS wfh_companies,
    COUNT(DISTINCT CASE WHEN job_work_from_home = FALSE THEN company_id END) AS non_wfh_companies
FROM job_postings_fact;
    
    