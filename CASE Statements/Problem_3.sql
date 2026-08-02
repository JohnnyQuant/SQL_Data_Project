--- https://www.lukebarousse.com/products/sql-for-data-analytics/categories/2154886311/posts/2175729140

SELECT
        job_id
        , salary_year_avg
        , CASE
            WHEN job_title LIKE '%Senior%' THEN 'Senior'
            WHEN job_title LIKE '%Lead%' OR job_title LIKE '%Manager%' THEN 'Lead/Manager'
            WHEN job_title LIKE '%Junior%' OR job_title LIKE '%Entry%' THEN 'Junior/Entry'
            ELSE 'Not Specified'
        END AS "Experience Level"
        , CASE
            WHEN job_work_from_home IS TRUE THEN 'Yes'
            ELSE 'No'
        END AS "Remote Option"
FROM
        job_postings_fact
WHERE
        salary_year_avg IS NOT NULL
ORDER BY
        job_id;
