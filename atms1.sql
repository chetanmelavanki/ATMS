CREATE DATABASE atms;

USE atms; 

CREATE TABLE BRANCH (
    Branch_Id INT(3) PRIMARY KEY,
    Branch_Name VARCHAR(50) NOT NULL,
    Course VARCHAR(10) NOT NULL  -- Store values like 'UG', 'PG', or 'UG,PG'
);

desc branch;
-- Select from BRANCH table
SELECT * FROM BRANCH;

CREATE TABLE FACULTY(
    Faculty_Id VARCHAR(10) PRIMARY KEY,
    Faculty_Name VARCHAR(50) NOT NULL,
    Faculty_DOB DATE NOT NULL,
    Faculty_Address VARCHAR(100) NOT NULL,  
    Branch_Id INT(3),
    Designation VARCHAR(20) NOT NULL,
    Qualification VARCHAR(20) NOT NULL,
    Experience INT(3),
    Faculty_Email VARCHAR(50) NOT NULL,
    Faculty_Phone_No VARCHAR(15) NOT NULL,  
    Salary INT(10),
    Joining_Date DATE NOT NULL,
    FOREIGN KEY (Branch_Id) REFERENCES BRANCH (Branch_Id)
);


desc faculty;
SELECT * FROM FACULTY;


CREATE TABLE STUDENT(
    USN VARCHAR(10) PRIMARY KEY,
    Student_Name VARCHAR(50) NOT NULL,
    Student_DOB DATE NOT NULL,
    Student_Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Student_Email VARCHAR(100) NOT NULL,
    Student_Phone_Number VARCHAR(10) NOT NULL,  
    Date_Of_Admission DATE NOT NULL,
    Student_Qualification VARCHAR(50) NOT NULL,
    Student_Address VARCHAR(100) NOT NULL,
    Branch_Id INT(3) NOT NULL,
    Year_Of_Study VARCHAR(10) NOT NULL,
    FOREIGN KEY (Branch_Id) REFERENCES BRANCH(Branch_Id)
);

desc student;
-- Select from STUDENT table
SELECT * FROM STUDENT;

CREATE TABLE EVENT (
    Event_Id INT(10) AUTO_INCREMENT,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Type VARCHAR(100) NOT NULL,
    Event_Venue VARCHAR(100) NOT NULL,
    Branch_Id INT(3),
    Start_Date DATETIME NOT NULL,
    End_Date DATETIME NOT NULL,
    Semester INT(1) NOT NULL,
    PRIMARY KEY(Event_Id),
    FOREIGN KEY (Branch_Id) REFERENCES BRANCH(Branch_Id)
);

-- Select from EVENT table
SELECT * FROM EVENT;
desc event;

CREATE TABLE SUBJECT(
    Subject_Code VARCHAR(10) PRIMARY KEY,
    Subject_Name VARCHAR(50) NOT NULL,
    Credits INT NOT NULL,  
    Semester INT(1) NOT NULL, 
    Branch_Id INT(3),
    Faculty_Id VARCHAR(10),
    Syllabus VARCHAR(255) NOT NULL,
    FOREIGN KEY (Branch_Id) REFERENCES BRANCH(Branch_Id),
    FOREIGN KEY (Faculty_Id) REFERENCES FACULTY(Faculty_Id)
);

desc subject;
-- Select from SUBJECT table
SELECT * FROM SUBJECT;

CREATE TABLE ASSESSMENT(
    Assessment_Type ENUM('CIE1', 'CIE2', 'CIE3', 'SEE') NOT NULL,
    Date_Of_Assessment DATE NOT NULL,
    USN VARCHAR(10),
    Subject_Code VARCHAR(10),
    Total_Marks INT NOT NULL CHECK (Total_Marks BETWEEN 0 AND 100),  -- CHECK constraint 
    Faculty_Id VARCHAR(10),
    Status ENUM('Pass', 'Fail') NOT NULL,
    PRIMARY KEY (Assessment_Type, Date_Of_Assessment, USN, Subject_Code), 
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (Subject_Code) REFERENCES SUBJECT(Subject_Code),
    FOREIGN KEY (Faculty_Id) REFERENCES FACULTY(Faculty_Id)
);

desc assessment;

-- Select from ASSESSMENT table
SELECT * FROM ASSESSMENT;

CREATE TABLE FACULTY_INVOLVEMENT(
    Faculty_Id VARCHAR(10),
    Event_Id INT(10),
    Faculty_Involvement_Date DATE NOT NULL,
    Faculty_Involvement_Type ENUM('Organizer', 'Speaker', 'Participant', 'Judge', 'Coordinator') NOT NULL,
    Faculty_Involvement_Details TEXT,  -- Additional details about the involvement
    PRIMARY KEY (Faculty_Id, Event_Id, Faculty_Involvement_Date),  -- Composite primary key
    FOREIGN KEY (Faculty_Id) REFERENCES FACULTY(Faculty_Id),
    FOREIGN KEY (Event_Id) REFERENCES EVENT(Event_Id)
);
desc FACULTY_INVOLVEMENT;

ALTER TABLE faculty_involvement MODIFY COLUMN Faculty_Involvement_Type VARCHAR(50);
SELECT Faculty_Id FROM FACULTY;
SELECT * FROM FACULTY WHERE Faculty_Id = 'MCA02';
desc FACULTY_INVOLVEMENT;
-- Select from FACULTY_INVOLVEMENT table
SELECT * FROM FACULTY_INVOLVEMENT;


CREATE TABLE STUDENT_INVOLVEMENT(
    USN VARCHAR(10),
    Event_Id INT(10),
    Student_Involvement_Date DATE NOT NULL,
    Student_Involvement_Type ENUM('Participant', 'Volunteer', 'Speaker', 'Organizer', 'Judge') NOT NULL,
    Student_Involvement_Details TEXT,  -- Additional details about the involvement
    PRIMARY KEY (USN, Event_Id, Student_Involvement_Date),  -- Composite primary key
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (Event_Id) REFERENCES EVENT(Event_Id)
);

desc STUDENT_INVOLVEMENT;
-- Select from STUDENT_INVOLVEMENT table
SELECT * FROM STUDENT_INVOLVEMENT;


CREATE TABLE STUDENT_ALLOCATED(
    USN VARCHAR(10),
    Subject_Code VARCHAR(10),
    Date_Of_Admission DATE NOT NULL,
    Academic_Year VARCHAR(9) NOT NULL,
    Sem INT(1) NOT NULL,  -- New Sem attribute
    PRIMARY KEY (USN, Subject_Code, Academic_Year),  -- Composite primary key
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (Subject_Code) REFERENCES SUBJECT(Subject_Code)
);
desc STUDENT_ALLOCATED;
-- Select from STUDENT_INVOLVEMENT table
SELECT * FROM STUDENT_ALLOCATED;


CREATE TABLE FACULTY_ALLOCATION(
    Faculty_Id VARCHAR(10),
    Subject_Code VARCHAR(10),
    Allocation_Date DATE NOT NULL,
    Academic_Year VARCHAR(9) NOT NULL,
    Sem INT(1) NOT NULL,  -- New Sem attribute
    PRIMARY KEY (Faculty_Id, Subject_Code, Allocation_Date),  -- Composite primary key
    FOREIGN KEY (Faculty_Id) REFERENCES FACULTY(Faculty_Id),
    FOREIGN KEY (Subject_Code) REFERENCES SUBJECT(Subject_Code)
);

desc FACULTY_ALLOCATION;
-- Select from FACULTY_ALLOCATION table
SELECT * FROM FACULTY_ALLOCATION;



CREATE TABLE ADMIN (
    Email VARCHAR(100) PRIMARY KEY,         -- Email address as the unique identifier
    Password VARCHAR(255) NOT NULL,         -- Password field (hashed for security)
    Role ENUM('Admin') DEFAULT 'Admin' NOT NULL -- Role field, always 'Admin'
);

CREATE TABLE FACULTY_USER (
    Faculty_Id VARCHAR(10) NOT NULL,
    Pw VARCHAR(255) NOT NULL,                -- Password field (hashed for security)
    Faculty_Role ENUM('Faculty') NOT NULL,
    PRIMARY KEY (Faculty_Id),                -- Added primary key constraint
    FOREIGN KEY (Faculty_Id) REFERENCES FACULTY(Faculty_Id)
);

CREATE TABLE STUDENT_USER (
    USN VARCHAR(10) NOT NULL,
    Pw VARCHAR(255) NOT NULL,                -- Password field (hashed for security)
    Student_Role ENUM('Student') NOT NULL,
    PRIMARY KEY (USN),                       -- Added primary key constraint
    FOREIGN KEY (USN) REFERENCES STUDENT(USN)
);

INSERT INTO ADMIN (Email, Password, Role)
VALUES ('chetan@gmail.com', 'Admin@123', 'Admin');

INSERT INTO ADMIN (Email, Password, Role)
VALUES ('munni@gmail.com', 'Admin@123', 'Admin');

INSERT INTO ADMIN (Email, Password, Role)
VALUES ('prutwiraj@gamil.com', 'Admin@123', 'Admin');

select *from ADMIN;

select *from STUDENT_USER;

select USN,Pw From STUDENT_USER where USN=?;







