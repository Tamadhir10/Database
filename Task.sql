create database Entertanment

use Entertanment

CREATE TABLE Users ( 
  UserID INT PRIMARY KEY, 
  FullName VARCHAR(100), 
  JoinDate DATE, 
  SubscriptionType VARCHAR(50) 
); 
CREATE TABLE Movies ( 
  MovieID INT PRIMARY KEY, 
  Title VARCHAR(100), 
  Genre VARCHAR(50), 
  ReleaseYear INT, 
  DurationMinutes INT 
); 
CREATE TABLE WatchHistory ( 
  WatchID INT PRIMARY KEY, 
  UserID INT, 
  MovieID INT, 
  WatchDate DATE, 
  WatchDuration INT); 

  --Users
  
INSERT INTO Users VALUES  
(1, 'Alice Johnson', '2023-01-15', 'Premium'), 
(2, 'Bob Smith', '2023-03-20', 'Standard'), 
(3, 'Charlie Lee', '2023-02-05', 'Basic'), 
(4, 'Diana Ray', '2023-04-10', 'Premium'), 
(5, 'Ethan Park', '2023-01-25', 'Standard'); 
-- Movies 
INSERT INTO Movies VALUES 
(101, 'The Great Heist', 'Action', 2022, 120), 
(102, 'Laugh Out Loud', 'Comedy', 2023, 90), 
(103, 'Deep Dive', 'Documentary', 2021, 75), 
(104, 'Speed Chase', 'Action', 2023, 110), 
(105, 'Tears of Time', 'Drama', 2020, 105); 
-- WatchHistory 
INSERT INTO WatchHistory VALUES 
(1001, 1, 101, '2023-05-01', 115), 
(1002, 1, 102, '2023-05-02', 90), 
(1003, 2, 103, '2023-05-03', 75), 
(1004, 3, 104, '2023-05-01', 100), 
(1005, 4, 105, '2023-05-04', 105); 



--1. Display all users and their subscription types. 

select FullName,SubscriptionType from Users

--2. List all movies and their durations. 
select Title, DurationMinutes from Movies;

--3. Show all watch history records. 
select * from WatchHistory;

--4. Find the titles and genres of all movies released after 2020. 
select Title, Genre from Movies where ReleaseYear > 2020;

--5. Show names of users who joined after February 2023.
select FullName from Users where JoinDate > '2023-02-28'

--6. List movie titles that are longer than 100 minutes. 
select Title from Movies where DurationMinutes > 100

--7. View all watch records by a specific user (e.g., UserID = 1). 
select * from Users where UserID = 1

--8. Show all user names sorted by join date (newest first). 
select FullName from Users Order by JoinDate desc

--9. Retrieve movies that belong to the 'Action' genre. 
select * from Movies where Genre = 'Action'

--10. Find all watch entries that happened on '2023-05-01'. 
select * from WatchHistory where WatchDate = '2023-05-01'

--11. Display full information of movies released in 2023. 
select * from Movies where ReleaseYear = 2023

--12. Show names and subscription types of users who are not 'Basic' subscribers. 
select FullName, SubscriptionType  from Users where SubscriptionType <> 'Basic'

--13. Retrieve all users whose names contain the letter 'a' (case insensitive for SQL Server). 
select * from Users where FullName like '%a%' 

--14. List movie titles that are exactly 90 minutes long. 
select Title from Movies where DurationMinutes = 90

--15. Show all watch history entries where the watch duration was more than 100 minutes.
select * from WatchHistory where WatchDuration > 100 

--16. View user names who joined in January 2023. 
select FullName from Users where MONTH(JoinDate) = 1 AND YEAR(JoinDate) = 2023

--17. Display all movies sorted by title in alphabetical order. 
select * from Movies order by Title ASC 






