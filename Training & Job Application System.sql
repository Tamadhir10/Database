create database unionDB

use unionDB

-- Trainees Table
CREATE TABLE Trainees (
 TraineeID INT PRIMARY KEY,
 FullName VARCHAR(100),
 Email VARCHAR(100),
 Program VARCHAR(50),
 GraduationDate DATE
);

-- Job Applicants Table
CREATE TABLE Applicants (
 ApplicantID INT PRIMARY KEY,
 FullName VARCHAR(100),
 Email VARCHAR(100),
 Source VARCHAR(20), -- e.g., "Website", "Referral"
 AppliedDate DATE
);

-- Insert into Trainees
INSERT INTO Trainees VALUES
(1, 'Layla Al Riyami', 'layla.r@example.com', 'Full Stack .NET', '2025-04-30'),
(2, 'Salim Al Hinai', 'salim.h@example.com', 'Outsystems', '2025-03-15'),
(3, 'Fatma Al Amri', 'fatma.a@example.com', 'Database Admin', '2025-05-01');


-- Insert into Applicants
INSERT INTO Applicants VALUES
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'),
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'), -- same person as 
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28');


-- 1. Unique people who either trained or applied
SELECT FullName, Email FROM Trainees
UNION
SELECT FullName, Email FROM Applicants;

-- Observation:
-- UNION removes duplicates based on all selected columns.

-- 2. Using UNION ALL to show all
SELECT FullName, Email FROM Trainees
UNION ALL
SELECT FullName, Email FROM Applicants;

-- Observation:
-- Duplicate entries appear if the same person is in both tables.
-- Explanation: UNION ALL does not eliminate duplicates.

-- 3. People in both tables (INTERSECT or JOIN)
-- If your DB supports INTERSECT:
SELECT FullName, Email FROM Trainees
INTERSECT
SELECT FullName, Email FROM Applicants;

-- Simulated using JOIN (universal method):
SELECT t.FullName, t.Email
FROM Trainees t
INNER JOIN Applicants a ON t.Email = a.Email;



-- 4. DELETE test
DELETE FROM Trainees WHERE Program = 'Outsystems';

-- Observation:
-- Rows where Program is 'Outsystems' are deleted.
-- Table and structure still exist.

-- 5. TRUNCATE test
TRUNCATE TABLE Applicants;

-- Observation:
-- All data is removed instantly.
-- Cannot be rolled back in most databases (non-transactional).
-- Table structure remains intact.

-- 6. DROP test
DROP TABLE Applicants;

-- Observation:
-- Table is deleted completely.
-- SELECT on Applicants now results in "Table does not exist" error.



-- 4. What is a SQL Transaction?
-- A transaction is a group of SQL statements that execute as a single unit.
-- It follows ACID properties to ensure reliability.

-- BEGIN TRANSACTION starts it.
-- COMMIT saves all changes.
-- ROLLBACK undoes changes if an error occurs.

-- 5. Transaction Script with failure
BEGIN TRANSACTION;

INSERT INTO Applicants VALUES 
(104, 'Zahra Al Amri', 'zahra.a@example.com', 'Referral', '2025-05-10');

-- This will fail due to duplicate ID (if 104 already exists)
INSERT INTO Applicants VALUES 
(104, 'Error User', 'error@example.com', 'Website', '2025-05-11');

-- COMMIT; -- Will not be reached if error occurs
-- ROLLBACK; -- Rollback must be handled in application or manually

-- NOTE: Use error-handling in your DB client or app to trigger rollback


-- 7. ACID Theory

-- A - Atomicity
-- All operations in a transaction succeed or all fail.
-- Ex: Transferring money from A to B. Both debit and credit must happen, or none.

-- C - Consistency
-- Data must always be valid according to constraints.
-- Ex: An order shouldn't be inserted without a valid customer ID.

-- I - Isolation
-- Concurrent transactions should not interfere.
-- Ex: Two users booking the same seat should not get it due to proper isolation.

-- D - Durability
-- Once committed, data persists even after crashes.
-- Ex: A confirmed hotel booking stays even after server restart.
