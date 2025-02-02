
select skills,
    round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact jpf
INNER JOIN skills_job_dim sjd on sjd.job_id = jpf.job_id
INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id  
where 
    job_title_short='Data Analyst' and
    salary_year_avg is not null AND
    job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary desc
limit 25