
select skills,
    count(sjd.job_id) as demand_count
from job_postings_fact jpf
INNER JOIN skills_job_dim sjd on sjd.job_id = jpf.job_id
INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id  
where job_title_short='Data Analyst'
GROUP BY skills
ORDER BY demand_count desc
limit 5