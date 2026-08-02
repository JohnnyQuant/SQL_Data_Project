--- Find companies (include company name) that have posted jobs offering health insurance,
--- where these postings were made in the second quarter of 2023.
--- Use date extraction to filter by quarter. And order by the job postings count from highest to lowest.

SELECT
        CD.name AS "Comany Name"
        , TO_CHAR(COUNT(*), 'FM999,999,999') AS "Number of Job Postings"
FROM
        job_postings_fact AS JPF
        INNER JOIN company_dim AS CD
        ON JPF.company_id = CD.company_id
WHERE
        JPF.job_health_insurance IS TRUE
        AND EXTRACT(QUARTER FROM JPF.job_posted_date) = 2
GROUP BY
        "Comany Name"
HAVING
        COUNT(*) > 1
ORDER BY
        COUNT(*) DESC