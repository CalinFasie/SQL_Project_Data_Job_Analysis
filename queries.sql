-- select job_posted_date
-- from job_postings_fact
-- limit 10

-- select 
--     '2023-02-19'::Date,
--     '123'::int,
--     'true'::boolean,
--     '3.14'::real;

-- SELECT
--     job_title_short as title,
--     job_posted_date at time zone 'UTC' at time zone 'EST' as datetime,
--     job_location as location,
--     extract(month from job_posted_date) as month
-- FROM
--     job_postings_fact
--     limit 5;   

-- SELECT
--     count(job_id) as job_posted_count,
--     EXTRACT(month from job_posted_date) as month
-- FROM
--     job_postings_fact
--     where 
--     job_title_short = 'Data Analyst'

-- GROUP BY    
--     month
-- ORDER BY
--     job_posted_count DESC
-- LIMIT 5;

-- select 
--     avg(salary_year_avg) as avg_salary,
--     avg(salary_hour_avg) as avg_hourly_salary
--     FROM job_postings_fact
--     where
--     EXTRACT(month from job_posted_date) >5
--     GROUP BY
--     job_schedule_type

-- SELECT
--     count(job_id),
--     job_posted_date at time zone 'UTC' at time zone 'EST' as datetime,
--     EXTRACT(month from job_posted_date) as month
-- from
--     job_postings_fact

-- GROUP BY
--     month,job_posted_date
-- ORDER BY
--     month;

-- SELECT
--     c.name
-- FROM
--     job_postings_fact j
--     JOIN company_dim c ON j.company_id = c.company_id
-- WHERE
--     j.job_health_insurance = 'true'
--     AND
--     EXTRACT(month from job_posted_date) between 1 and 3
--     limit 5;

-- CREATE TABLE march_jobs
-- as
-- select * 
-- from job_postings_fact
-- where
-- EXTRACT(month from job_posted_date) = 3

-- drop table  Jan_2023_jobs

-- SELECT
--     count(job_id) as number_of_jobs,
--     case
--         when job_location='Anywhere' then 'Remote'
--         when job_location='New York, NY' then 'Local'
--         else 'Onsite'
--     end as location_category    
--     FROM
--     job_postings_fact
-- WHERE
--     job_title_short = 'Data Analyst'
-- GROUP BY
--     location_category
--     limit 5;
    
-- select *
-- from (
--     SELECT *
--     FROM job_postings_fact
--     where extract(month from job_posted_date) = 1
-- )    as january_jobs

with feb_jobs as (
    SELECT *
    FROM job_postings_fact
    where extract(month from job_posted_date) = 2
)
select * from feb_jobs
select name
    from company_dim
    where company_id in (
    select    
        company_id
    from 
        job_postings_fact
    where
        job_no_degree_mention = true        
    )

    with CTE as (
select count(job_id) as counts,company_id
from job_postings_fact
group by company_id
)
select c.name,CTE.counts
from company_dim c LEFT JOIN CTE on c.company_id = CTE.company_id
order by cte.counts desc

-- with CTE as (
-- select count(job_id) as counts,company_id
-- from job_postings_fact
-- group by company_id
-- )
-- select c.name,CTE.counts
-- from company_dim c LEFT JOIN CTE on c.company_id = CTE.company_id
-- order by cte.counts desc


with cte as
 (select skill_id,count(skill_id) as counts
FROM skills_job_dim 
GROUP BY skill_id
order by counts desc limit 10
)
select s.skills,cte.counts
from skills_dim s LEFT JOIN cte on s.skill_id = cte.skill_id
where counts is not null
order by counts desc

with cte as (
    select 
        skill_id,
        count(skill_id) as counts
    FROM
        skills_job_dim as s
    INNER JOIN job_postings_fact as j on j.job_id = s.job_id
    WHERE j.job_work_from_home=TRUE
    GROUP BY skill_id
)

select 
    s.skill_id,s.skills,cte.counts
from cte 
inner join skills_dim as s ON s.skill_id=cte.skill_id
ORDER BY counts DESC
limit 10

with CTE as (
select 
    count(job_id) as counts,
    company_id,
    case when count(job_id)<10 then 'Small'
            when count(job_id) between 10 and 50 then 'Medium'
            else 'Large' end as category
from job_postings_fact
group by company_id
)
select c.name,CTE.category
from company_dim c LEFT JOIN CTE on c.company_id = CTE.company_id
order by cte.counts desc

with CTE as (
select 
    count(job_id) as counts,
    company_id,
    case when count(job_id)<10 then 'Small'
            when count(job_id) between 10 and 50 then 'Medium'
            else 'Large' end as category
from job_postings_fact
group by company_id
)
select c.name,CTE.category
from company_dim c LEFT JOIN CTE on c.company_id = CTE.company_id
order by cte.counts desc

select 
   job_title_short,
   company_id,
   job_location,EXTRACT(MONTH FROM job_posted_date) as month
from january_jobs
UNION 
select 
   job_title_short,
   company_id,
   job_location,EXTRACT(MONTH FROM job_posted_date) as month
from february_jobs  

with cte AS (
SELECT job_id FROM job_postings_fact
where EXTRACT(MONTH FROM job_posted_date) <4 and salary_year_avg> 70000
)

select sd.skills, sd.type
    from skills_dim sd LEFT join skills_job_dim sjd on sjd.skill_id = sd.skill_id
where sjd.job_id in (select job_id from cte)
