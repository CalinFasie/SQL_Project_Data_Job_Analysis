select 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    cd.name as company_name
FROM
    job_postings_fact j
LEFT JOIN company_dim cd on cd.company_id = j.company_id         
WHERE
    job_title_short = 'Data Analyst' AND
    job_location='Anywhere' AND
    salary_year_avg is not NULL
ORDER BY
    salary_year_avg DESC
limit 10    
