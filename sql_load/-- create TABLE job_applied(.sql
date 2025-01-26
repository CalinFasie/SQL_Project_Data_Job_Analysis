-- create TABLE job_applied(
--     job_id INT,
--     application_sent_date DATE,
--     custom_resume boolean,
--     resume_file_name VARCHAR(255),
--     cover_letter_sent boolean,
--     cover_letter_file_name VARCHAR(255),
--     status VARCHAR(50)
-- );

-- INSERT INTO job_applied VALUES (1, '2025-01-01', true, 'resume1.pdf', true, 'cover_letter1.pdf', 'submited'), 
--                                (2, '2025-01-02', false, null, false, null, 'submited'), 
--                                (3, '2025-01-03', true, 'resume3.pdf', true, 'cover_letter3.pdf', 'submited'), 
--                                (4, '2025-01-04', true, 'resume1.pdf', true, 'cover_letter1.pdf', 'rejected'), 
--                                (5, '2025-01-05', false, null, false, null, 'rejected'), 
--                                (6, '2025-01-06', true, 'resume3.pdf', true, 'cover_letter3.pdf', 'rejected'), 
--                                (7, '2025-01-07', true, 'resume1.pdf', true, 'cover_letter1.pdf', 'accepted'), 
--                                (8, '2025-01-08', false, null, false, null, 'accepted'), 
--                                (9, '2025-01-09', true, 'resume3.pdf', true, 'cover_letter3.pdf', 'accepted');    

-- SELECT * FROM job_applied;

-- alter TABLE job_applied
-- add contact VARCHAR(255);

-- UPDATE job_applied
-- set contact='Erlich Bachman'
-- where job_id=1;

-- UPDATE job_applied  
-- SET contact='Jared Dunn'
-- WHERE job_id=2; 

-- UPDATE job_applied
-- SET contact='Dinesh Chugtai'
-- WHERE job_id=3;

-- upDATE job_applied
-- SET contact='Richard Hendricks'
-- WHERE job_id=4; 
-- UPDATE job_applied
-- SET contact='Bertram Gilfoyle'
-- WHERE job_id=5;
-- UPDATE job_applied
-- SET contact='Monica Hall'
-- WHERE job_id=6;
-- UPDATE job_applied
-- SET contact='Laurie Bream'
-- WHERE job_id=7;
-- UPDATE job_applied
-- SET contact='Gavin Belson'
-- WHERE job_id=8;
-- UPDATE job_applied
-- SET contact='Nelson Bighetti'
-- WHERE job_id=9;
-- alter TABLE job_applied
-- alter COLUMN contact_person type text;
alter TABLE job_applied drop COLUMN contact_person;
select * from job_applied;
drop table IF EXISTS job_applied;