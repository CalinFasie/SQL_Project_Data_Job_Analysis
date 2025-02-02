with skill_demand as (
    select sd.skill_id,sd.skills,
        count(sjd.job_id) as demand_count
    from job_postings_fact jpf
    INNER JOIN skills_job_dim sjd on sjd.job_id = jpf.job_id
    INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id  
    where job_title_short='Data Analyst'
    and salary_year_avg is not null
    GROUP BY sd.skill_id
), averagy_salary as (
    select sd.skill_id,sd.skills,
        round(avg(salary_year_avg),0) as avg_salary
    from job_postings_fact jpf
    INNER JOIN skills_job_dim sjd on sjd.job_id = jpf.job_id
    INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id  
    where 
        job_title_short='Data Analyst' and
        salary_year_avg is not null AND
        job_work_from_home = TRUE
    GROUP BY sd.skill_id
    )

select sd.skill_id,sd.skills,    
    sd.demand_count,
    avg_salary
from skill_demand sd
INNER JOIN averagy_salary as asd on asd.skill_id = sd.skill_id
ORDER BY avg_salary desc
------
select
    sd.skill_id,
    sd.skills,
    count(sjd.job_id) as demand_count,
    round(AVG(jpf.salary_year_avg),0) as avg_salary
from job_postings_fact jpf
INNER JOIN skills_job_dim sjd on sjd.job_id = jpf.job_id
INNER JOIN skills_dim sd on sd.skill_id = sjd.skill_id  
where job_title_short='Data Analyst'
and salary_year_avg is not null
and job_work_from_home = TRUE
group by sd.skill_id
having count(sjd.job_id) > 10
order by avg_salary desc