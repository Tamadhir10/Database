--1) DDL
--to enter the database 
use Test
--to create database 
Create database Company

use Company

--backup for the database 
BACKUP DATABASE Company 
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\'
WITH FORMAT,
	INIT,
	COMPRESSION,
	STATS = 10;

--Drop the database 
DROP database Company

--Restor the database 

RESTORE DATABASE Company
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\'
WITH FILE = 1,
	INIT,
	NORECOVERY;

--create table 

create table Employee
(
	SSN int primary key identity(1,1), 
	Fname nvarchar(20) not null,
	Lname nvarchar(20) not null,
	Gender bit default 0,
	DOB date,
	)

create table Department
(
	DNUM int primary key identity(100,1), 
	Dname nvarchar(20) not null,
	HiringDate date,
	)
create table Department_Location
(
	DNUM int, 
	Dlocation nvarchar(20) not null,
	foreign key (DNUM) references Department  (DNUM),
	primary key (DNUM , Dlocation)
	)

create table Project
(
	PNumber int primary key identity(1,1), 
	Pname nvarchar(20) not null,
	Loc nvarchar(20) ,
	DNUM int,
	foreign key (DNUM) references Department(DNUM)
	
	)


create table Employee_Project
(
	PNumber int, 
	SSN int,
	Hrs int not null,
	foreign key (SSN) references Employee(SSN),
	foreign key (PNumber) references Project(PNumber),
	primary key (SSN , PNumber)

	
	)


create table Employee_DEPN
(
	SSN int, 
	Dname nvarchar(20) not null,
	Gunder bit default 0,
	DOB date,
	foreign key (SSN) references Employee(SSN),
	primary key (SSN , Dname)


	
	)


Alter table Employee add DNUM int foreign key references Department(DNUM)


insert into Employee(Fname ,Lname,Gender,DOB ) values('Ali','AlAjmi',0,'11-3-1998'),
('Mohammed','AlBadi',0,'4-5-1995'),
('Ahmed','AlAmri',0,'11-3-1996')

insert into Department(Dname,HiringDate) values('IT','11-3-2013'),
('HR','4-5-2022'),
('BA','11-3-2023')


insert into Department_Location(DNUM,Dlocation) values('100','GroundFloor')
,('200','2ndFloor'),
('300','GroundFloor')


insert into Project ( Pname,Loc,DNUM) values ('Automation','Bahwan',300),
('Hiring','PDO',200),
('Build Software','Bahwan',100)



insert into Employee_Project(PNumber, SSN ,Hrs) values('Automation',3,90),
('Hiring',2,144),
('Hiring',1,720)


insert into Employee_DEPN(SSN, Dname, Gunder,DOB ) values(3,'Ahmed',0,'11-3-1996'),
(1,'Ali',0,'11-3-1998'),
(3,'Mohammed',0,'4-5-1995')

