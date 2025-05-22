create database College

use College

-- DEPARTMENT
CREATE TABLE Department (
    Department_id INT PRIMARY KEY,
    D_name VARCHAR(100)
);

-- HOSTEL
CREATE TABLE Hostel (
    Hostel_id INT PRIMARY KEY,
    Hostel_name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Pin_code VARCHAR(10),
    No_of_seats INT
);

-- STUDENT
CREATE TABLE Student (
    S_id INT PRIMARY KEY,
    F_name VARCHAR(50),
    L_name VARCHAR(50),
    Phone_no VARCHAR(15),
    DOB DATE,
    Hostel_id INT,
    Department_id INT,
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- COURSE
CREATE TABLE Course (
    Course_id INT PRIMARY KEY,
    Course_name VARCHAR(100),
    Duration VARCHAR(20),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- SUBJECT
CREATE TABLE Subject (
    Subject_id INT PRIMARY KEY,
    Subject_name VARCHAR(100)
);

-- FACULTY
CREATE TABLE Faculty (
    F_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Mobile_no VARCHAR(15),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- FACULTY_SUBJECT 
CREATE TABLE Faculty_Subject (
    F_id INT,
    Subject_id INT,
    PRIMARY KEY (F_id, Subject_id),
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

-- STUDENT_COURSE 
CREATE TABLE Student_Course (
    S_id INT,
    Course_id INT,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);

-- STUDENT_SUBJECT 
CREATE TABLE Student_Subject (
    S_id INT,
    Subject_id INT,
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

-- EXAM
CREATE TABLE Exam (
    Exam_code INT PRIMARY KEY,
    Date DATE,
    Time TIME,
    Room VARCHAR(10),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

-- STUDENT_EXAM 
CREATE TABLE Student_Exam (
    S_id INT,
    Exam_code INT,
    PRIMARY KEY (S_id, Exam_code),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Exam_code) REFERENCES Exam(Exam_code)
	);





INSERT INTO Department VALUES (1, 'Computer Science');


INSERT INTO Hostel VALUES (1, 'Sunrise Hostel', 'Delhi', 'Delhi', '110001', 100);


INSERT INTO Student VALUES (101, 'Alice', 'Verma', '9876543210', '2003-04-12', 1, 1);


INSERT INTO Course VALUES (201, 'B.Tech CSE', '4 Years', 1);


INSERT INTO Subject VALUES (301, 'Data Structures');


INSERT INTO Faculty VALUES (401, 'Dr. Sharma', '9988776655', 'Computer Science', 75000.00, 1);


INSERT INTO Faculty_Subject VALUES (401, 301);


INSERT INTO Student_Course VALUES (101, 201);


INSERT INTO Student_Subject VALUES (101, 301);


INSERT INTO Exam VALUES (501, '2024-12-01', '10:00:00', 'C101', 1);


INSERT INTO Student_Exam VALUES (101, 501);
