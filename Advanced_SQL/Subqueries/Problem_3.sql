-- Your goal is to find the names of companies that have an average salary greater than the overall average salary across all job postings.
-- You'll need to use two tables: company_dim (for company names) and job_postings_fact (for salary data). The solution requires using subqueries.
SELECT CD.company_id,
    CD.name AS "Company Name",
    TO_CHAR(AVG(JPF.salary_year_avg), 'FM999,999,999.00') AS "Yearly Salary per Company"
FROM company_dim AS CD
    INNER JOIN job_postings_fact AS JPF ON CD.company_id = JPF.company_id
GROUP BY CD.company_id,
    CD.name
HAVING AVG(JPF.salary_year_avg) > (
        SELECT AVG(salary_year_avg)
        FROM job_postings_fact
    )
ORDER BY AVG(JPF.salary_year_avg) DESC;




SELECT company_dim.name
FROM company_dim
    INNER JOIN (
        -- Subquery to calculate average salary per company
        SELECT company_id,
            AVG(salary_year_avg) AS avg_salary
        FROM job_postings_fact
        GROUP BY company_id
    ) AS company_salaries ON company_dim.company_id = company_salaries.company_id -- Filter for companies with an average salary greater than the overall average
WHERE company_salaries.avg_salary > (
        -- Subquery to calculate the overall average salary
        SELECT AVG(salary_year_avg)
        FROM job_postings_fact
    );