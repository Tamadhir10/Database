--Part 2

CREATE DATABASE TrainingDB;
GO
USE TrainingDB;
GO
CREATE TABLE Students (
 StudentID INT PRIMARY KEY,
 FullName NVARCHAR(100),
 EnrollmentDate DATE
)
INSERT INTO Students VALUES
(1, 'Sara Ali', '2023-09-01'),
(2, 'Mohammed Nasser', '2023-10-15');

BACKUP DATABASE TrainingDB TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Full.bak';

-- Insert New Record
INSERT INTO Students VALUES (3, 'Fatma Said', '2024-01-10');

-- Differential Backup
BACKUP DATABASE TrainingDB TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Diff.bak' WITH DIFFERENTIAL;

-- Set Recovery Model to FULL
ALTER DATABASE TrainingDB SET RECOVERY FULL;

-- Transaction Log Backup
BACKUP LOG TrainingDB TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Log.trn';

-- Copy-Only Backup
BACKUP DATABASE TrainingDB TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_CopyOnly.bak' WITH COPY_ONLY;


--Part 3