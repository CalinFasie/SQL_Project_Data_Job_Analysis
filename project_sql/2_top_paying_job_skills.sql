with top_paying_jobs as (
    select 
        job_id,
        job_title,
        salary_year_avg,
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
)

select 
    tpj.*,
    skills   
from top_paying_jobs tpj
INNER JOIN skills_job_dim sjd on sjd.job_id = tpj.job_id
INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id  
ORDER BY tpj.salary_year_avg DESC 