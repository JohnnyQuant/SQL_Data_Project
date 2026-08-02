-- Identify companies with the most diverse (unique) job titles.
-- Use a CTE to count the number of unique job titles per company, then select companies with the highest diversity in job titles.

WITH count_distinct AS (SELECT
        company_id
        , COUNT(DISTINCT job_title) AS unique_title_count
FROM
        job_postings_fact
GROUP BY
        company_id
ORDER BY
        2 DESC
LIMIT 10)

SELECT
        CD.company_id
        , CD.name AS "company Name"
        , TO_CHAR(CDs.unique_title_count, 'FM999,999,999') AS "Number of Distinct Title"
FROM
        company_dim AS CD
        INNER JOIN count_distinct AS CDs
        ON CD.company_id = CDs.company_id;

------Second way
-- Define a CTE named title_diversity to calculate unique job titles per company
WITH title_diversity AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS unique_titles  
    FROM job_postings_fact
    GROUP BY company_id  
)
-- Get company name and count of how many unique titles each company has
SELECT
    company_dim.name,  
    title_diversity.unique_titles  
FROM title_diversity
	INNER JOIN company_dim ON title_diversity.company_id = company_dim.company_id  
ORDER BY 
	unique_titles DESC  
LIMIT 10;  