create database viewdb
use viewdb

CREATE TABLE Customer (
 CustomerID INT PRIMARY KEY,
 FullName NVARCHAR(100),
 Email NVARCHAR(100),
 Phone NVARCHAR(15),
 SSN CHAR(9)
);
CREATE TABLE Account (
 AccountID INT PRIMARY KEY,
 CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
 Balance DECIMAL(10, 2),
 AccountType VARCHAR(50),
 Status VARCHAR(20)
);
CREATE TABLE [Transaction] (
 TransactionID INT PRIMARY KEY,
 AccountID INT FOREIGN KEY REFERENCES Account(AccountID),
 Amount DECIMAL(10, 2),
 Type VARCHAR(10), -- Deposit, Withdraw
 TransactionDate DATETIME
);
CREATE TABLE Loan (
 LoanID INT PRIMARY KEY,
 CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
 LoanAmount DECIMAL(12, 2),
 LoanType VARCHAR(50),
 Status VARCHAR(20)
)

CREATE VIEW CustomerServiceView AS
SELECT 
    c.FullName,
    c.Phone,
    a.AccountID,
    a.Status
FROM 
    Customer c
JOIN 
    Account a ON c.CustomerID = a.CustomerID;


CREATE VIEW FinanceView AS
SELECT 
    AccountID,
    Balance,
    AccountType
FROM 
    Account;


CREATE VIEW LoanOfficerView AS
SELECT 
    LoanID,
    CustomerID,
    LoanAmount,
    LoanType,
    Status
FROM 
    Loan;


CREATE VIEW TransactionSummaryView AS
SELECT 
    AccountID,
    Amount,
    Type,
    TransactionDate
FROM 
    [Transaction]
WHERE 
    TransactionDate >= DATEADD(DAY, -30, GETDATE());
