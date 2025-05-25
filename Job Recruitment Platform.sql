Schema (All levels share these tables)
-------------------------------------------------------------------------------

use JobRecruitmentPlatform

-- Company table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Industry VARCHAR(50),
    City VARCHAR(50)
);

-- Job Seekers
CREATE TABLE JobSeekers (
    SeekerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    ExperienceYears INT,
    City VARCHAR(50)
);

-- Job Postings
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100),
    CompanyID INT,
    Salary DECIMAL(10, 2),
    Location VARCHAR(50),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

-- Applications
CREATE TABLE Applications (
    AppID INT PRIMARY KEY,
    JobID INT,
    SeekerID INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (SeekerID) REFERENCES JobSeekers(SeekerID)
);

Sample Data
-------------------------------------------------------------------------
-- Companies
INSERT INTO Companies VALUES
(1, 'TechWave', 'IT', 'Muscat'),
(2, 'GreenEnergy', 'Energy', 'Sohar'),
(3, 'EduBridge', 'Education', 'Salalah');

-- Job Seekers
INSERT INTO JobSeekers VALUES
(101, 'Sara Al Busaidi', 'sara.b@example.com', 2, 'Muscat'),
(102, 'Ahmed Al Hinai', 'ahmed.h@example.com', 5, 'Nizwa'),
(103, 'Mona Al Zadjali', 'mona.z@example.com', 1, 'Salalah'),
(104, 'Hassan Al Lawati', 'hassan.l@example.com', 3, 'Muscat');

-- Jobs
INSERT INTO Jobs VALUES
(201, 'Software Developer', 1, 900, 'Muscat'),
(202, 'Data Analyst', 1, 800, 'Muscat'),
(203, 'Science Teacher', 3, 700, 'Salalah'),
(204, 'Field Engineer', 2, 950, 'Sohar');

-- Applications
INSERT INTO Applications VALUES
(301, 201, 101, '2025-05-01', 'Pending'),
(302, 202, 104, '2025-05-02', 'Shortlisted'),
(303, 203, 103, '2025-05-03', 'Rejected'),
(304, 204, 102, '2025-05-04', 'Pending');

--Task 1 'Show the Full Name of the Job Seeker, Job title that he/she Applied for, and the name of the company. 
--For only who applied on the job. by usiny inner join '  

select JS.FullName, J.Title, C.Name 
from Applications A, JobSeekers JS, Jobs J, Companies C
where A.SeekerID = JS.SeekerID AND A.JobID = J.JobID AND J.CompanyID = C.CompanyID

--Task 2 'Show the title and the company name even if no one has applied'

select Jobs.Title, Companies.Name
from Jobs, Companies , Applications 
where Jobs.JobID = Applications.JobID 
AND Jobs.CompanyID = Companies.CompanyID

--Task 3 'Show seeker name, job title, and city where both live and job match'
SELECT 
    JobSeekers.FullName,
    Jobs.Title,
    JobSeekers.City
FROM 
    JobSeekers
JOIN Applications ON JobSeekers.SeekerID = Applications.SeekerID
JOIN Jobs ON Applications.JobID = Jobs.JobID
WHERE 
    JobSeekers.City = Jobs.Location;
	
-- Task 4: Show all job seekers and any jobs they've applied to (if any).
-- Use LEFT JOIN to include seekers who never applied
select 
    JobSeekers.FullName,
    Jobs.Title,
    Applications.Status
from 
    JobSeekers
LEFT JOIN Applications ON JobSeekers.SeekerID = Applications.SeekerID
LEFT JOIN Jobs ON Applications.JobID = Jobs.JobID;

-- Task 5: Show each job and the names of applicants (if any).
-- Show all jobs even if no one applied.

select 
    Jobs.Title,
    JobSeekers.FullName
from 
    Jobs
LEFT JOIN Applications ON Jobs.JobID = Applications.JobID
LEFT JOIN JobSeekers ON Applications.SeekerID = JobSeekers.SeekerID;


--Task 6 'Show all jobs even if no one applied'

select 
    Jobs.Title,
    JobSeekers.FullName
from 
    Jobs
LEFT JOIN Applications ON Jobs.JobID = Applications.JobID
LEFT JOIN JobSeekers ON Applications.SeekerID = JobSeekers.SeekerID;


-- Task 7: Show companies that have no jobs posted.
-- Use LEFT JOIN from Companies to Jobs and filter jobs as NULL.

select 
    Companies.Name,
    Companies.City
from 
    Companies
LEFT JOIN Jobs ON Companies.CompanyID = Jobs.CompanyID
where 
    Jobs.JobID IS NULL;


-- Task 8: Show pairs of job seekers who live in the same city but are not the same person.

select 
    A.FullName as Seeker1,
    B.FullName as Seeker2,
    A.City
from 
    JobSeekers A, JobSeekers B
where 
    A.City = B.City AND A.SeekerID <> B.SeekerID;


-- Task 9: Seekers who applied to high-salary jobs not in their city.

select 
    JobSeekers.FullName, Jobs.Title,JobSeekers.City as SeekerCity,Jobs.Location as JobCity,Jobs.Salary
from 
    JobSeekers
JOIN Applications on JobSeekers.SeekerID = Applications.SeekerID
JOIN Jobs on Applications.JobID = Jobs.JobID
where 
    Jobs.Salary > 850 AND JobSeekers.City <> Jobs.Location;


-- Task 10: Show all seekers and job cities they applied to, even if they don’t match.

select 
    JobSeekers.FullName,JobSeekers.City as SeekerCity, Jobs.Location as JobCity
from 
    JobSeekers
JOIN Applications on JobSeekers.SeekerID = Applications.SeekerID
JOIN Jobs on Applications.JobID = Jobs.JobID;

-- Task 11: Show jobs that haven't received any applications.

select 
    Jobs.Title
from 
    Jobs
LEFT JOIN Applications on Jobs.JobID = Applications.JobID
where 
    Applications.AppID IS NULL;

-- Task 12: Seekers who applied to jobs in the same city they live in.

select 
    JobSeekers.FullName,
    Jobs.Title,
    JobSeekers.City
from 
    JobSeekers
JOIN Applications on JobSeekers.SeekerID = Applications.SeekerID
JOIN Jobs on Applications.JobID = Jobs.JobID
where 
    JobSeekers.City = Jobs.Location;


-- Task 13: Pairs of seekers in same city who applied to different jobs.

select 
    A.FullName as Seeker1,
    B.FullName as Seeker2,
    A.City
from 
    JobSeekers A
JOIN Applications AppA on A.SeekerID = AppA.SeekerID
JOIN Jobs J1 on AppA.JobID = J1.JobID
JOIN JobSeekers B on A.City = B.City AND A.SeekerID <> B.SeekerID
JOIN Applications AppB on B.SeekerID = AppB.SeekerID
JOIN Jobs J2 on AppB.JobID = J2.JobID
where 
    J1.JobID <> J2.JobID;


-- Task 14: Show applications where seeker is from a different city than the job.

select 
    JobSeekers.FullName,
    Jobs.Title,
    JobSeekers.City as SeekerCity,
    Jobs.Location as JobCity
from 
    JobSeekers
JOIN Applications on JobSeekers.SeekerID = Applications.SeekerID
JOIN Jobs on Applications.JobID = Jobs.JobID
where 
    JobSeekers.City <> Jobs.Location;


-- Task 15: Show cities where job seekers live but no company is based.

select DISTINCT 
    JobSeekers.City
from 
    JobSeekers
LEFT JOIN Companies on JobSeekers.City = Companies.City
where  
    Companies.CompanyID IS NULL;
