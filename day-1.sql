-- single line comments

/*
Multiline 
Comments
*/

## This is also used for single line comment in sql

/*
Usage of Comments

1. Documentation: Comments can be used to document the purpose of a SQL query or the logic 
behind complex operations.
2.Debugging: You can temporarily disable parts of your SQL code by commenting them out, 
which is useful for debugging.
3. Collaboration: When working in teams, comments help communicate the intent and 
functionality of the code to other developers.
*/


-- ---------------------------------------------- Database Queries -----------------------------------------------

-- create a database
Create database Sahyog;

-- to work on it, you need to use it first
use sahyog;

-- delete database
-- to execute query(ctrl+enter)
drop database Sahyog;

-- SQL is not a case sensitive language, ex- AGE or Age or age will be treated as same word

-- ---------------------------------------- Database Analysis ----------------------------------------

/*
T1 : Student(id,name,std,address,age)

T2 : Teachers(TeacherID,Name,Subject,Experience,Email)

T3 : Classes(ClassID,ClassName,Section,TotalStudents,TeacherID)

T4 : Subjects(SubjectID,SubjectName,Credits,ClassID)

T5 : Exams(ExamID,ExamName,Date,TotalMarks,ClassID)

T6 : Attendance(AttendanceID,StudentID,ClassID,Date,Status)

T7 : Grades(GradeID,StudentID,SubjectID,Marks)

T8 : Library(BookID,Title,Author,ISBN,AvailableCopies)

T9 : ExtracurricularActivities(ActivityID,ActivityName,Description,ClassID)

T10: ParentDetails(ParentID,StudentID,ParentName,Relationship,ContactNumber)

*/

-- --------------------------------------- Basic Concepts -----------------------------------------------------

/*
Data types: ensure types ofdata and size of data to br stored in an attributes'
               ex. int ,varchar(10),date..
              
Constraint : used to apply some rules /restriction on a attribute
             ex. unique,not nyll,primary key

Commands : used to interact with database and tables as - DDL,DML,DQL,DCL,TCL
           ex. ceate,insert,select,drop

Clause :used to add some extra information/condition in commmnad 
         ex. select * from student;,
             select* from student where name="kavya".
*/

-- --------------------------------------- Table Related Queries ---------------------------------

-- Table-1 Student

create table Student(
id int primary key,  -- primary key = unique + not null
name varchar(100) not null,
std varchar(10) not null,
address varchar(200),
age int
);

-- to display/retrive table data
select * from student;

-- to insert a single record
insert into Student(id,name,std,address,age)
values 
(1,'Vikram', '1st', 'Dombivli',5);

-- to insert a single record without writing attributes name
insert into Student
values 
(2,'Pranay', '1st', 'Dombivli',5);

-- to insert multiple records together
insert into Student
values 
(3,'Yusuf', '1st', 'Dombivli',5),
(4,'Shoeb', '1st', 'Dombivli',5),
(5,'Kajal', '1st', 'Dombivli',5),
(6,'Trisha', '1st', 'Dombivli',5),
(7,'Khushi', '1st', 'Dombivli',5),
(8,'Mitali', '1st', 'Dombivli',5),
(9,'Anjali', '1st', 'Dombivli',5),
(10,'Priya', '1st', 'Dombivli',5);

-- to remove complete records from table
truncate table student;

-- to remove complete records and attributes from table
drop table student;


-- Table 2: Teachers
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    Name VARCHAR(100),
    Subject VARCHAR(50),
    Experience INT,
    Email VARCHAR(100)
);

-- to display/retrive table data
select * from Teachers;

INSERT INTO Teachers (TeacherID, Name, Subject, Experience, Email) VALUES
(1, 'Mr. Rajesh Kumar', 'Mathematics', 10, 'rajesh.kumar@example.com'),
(2, 'Ms. Anita Desai', 'Science', 8, 'anita.desai@example.com'),
(3, 'Mr. Sanjay Gupta', 'English', 12, 'sanjay.gupta@example.com'),
(4, 'Ms. Priya Sharma', 'History', 5, 'priya.sharma@example.com'),
(5, 'Mr. Rakesh Mehta', 'Geography', 15, 'rakesh.mehta@example.com');

-- to remove complete records from table
truncate table Teachers;

-- to remove complete records and attributes from table
drop table Teachers;


-- -------------------------------------- Foreign Key -------------------------------------------------------------

/*
What is a Foreign Key in SQL?

--> A Foreign Key is a column (or a set of columns) in one table that refers to the Primary Key in another table.
--> It helps establish a parent-child relationship between tables.
--> A foreign key ensures that the value in the referencing column must exist in the referenced table's primary key.
--> It is used to enforce referential integrity in the database.

Why Use Foreign Keys?

--> To logically connect related data across multiple tables.
--> To avoid data redundancy and maintain normalized database design.
--> To maintain data accuracy and consistency through relationships.
--> To restrict invalid data entries (e.g., preventing a student being assigned to a non-existent class).

Key Properties of Foreign Key:

--> A foreign key refers to a primary key (or unique key) in another table.
--> Multiple foreign keys can exist in a table.
--> The referencing column can accept NULL values (unless explicitly marked NOT NULL).
--> Prevents insertion of invalid values (i.e., values not present in the parent table).
--> Can use ON DELETE or ON UPDATE rules like CASCADE, SET NULL, RESTRICT, etc.
--> Helps implement one-to-many and many-to-one relationships.

Real-World Example – School Database Relationships:

1.  Classes ------- Teachers  
    --> Each class is assigned a teacher.  
    --> Foreign Key: Classes.teacher_id → Teachers.teacher_id

2.  Subjects ------- Classes  
    --> Each subject is taught in a specific class.  
    --> Foreign Key: Subjects.class_id → Classes.class_id

3.  Exams --------- Classes  
    --> Exams are scheduled for each class.  
    --> Foreign Key: Exams.class_id → Classes.class_id

4.  Attendance ---- Classes, Students  
    --> Attendance records are maintained per student per class.  
    --> Foreign Keys: Attendance.student_id → Students.student_id  
                    Attendance.class_id → Classes.class_id

5.  Grades -------- Students, Subjects  
    --> Grades are assigned to students per subject.  
    --> Foreign Keys: Grades.student_id → Students.student_id  
                    Grades.subject_id → Subjects.subject_id

Conclusion:

--> Foreign Keys are essential to maintain structured, connected, and meaningful relational data.
--> They make the database more reliable by enforcing valid references between records.

*/


-- Table 3: Classes
CREATE TABLE Classes (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(10),
    Section CHAR(1),
    TotalStudents INT,
    TeacherID INT,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

-- to display/retrive table data
select * from Classes;

INSERT INTO Classes (ClassID, ClassName, Section, TotalStudents, TeacherID) VALUES
(1, '10th', 'A', 30, 1),
(2, '9th', 'B', 25, 2),
(3, '11th', 'C', 20, 3),
(4, '8th', 'A', 28, 4),
(5, '12th', 'B', 22, 5);

-- to remove complete records from table
truncate table Classes;

-- to remove complete records and attributes from table
drop table Classes;


-- Table 4: Subjects
CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY,
    SubjectName VARCHAR(50),
    Credits INT,
    ClassID INT,
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- to display/retrive table data
select * from Subjects;

INSERT INTO Subjects (SubjectID, SubjectName, Credits, ClassID) VALUES
(1, 'Mathematics', 4, 1),
(2, 'Science', 4, 2),
(3, 'English', 3, 3),
(4, 'History', 3, 4),
(5, 'Geography', 3, 5);

-- to remove complete records from table
truncate table Subjects;

-- to remove complete records and attributes from table
drop table Subjects;

-- Table 5: Exams
CREATE TABLE Exams (
    ExamID INT PRIMARY KEY,
    ExamName VARCHAR(50),
    Date DATE,
    TotalMarks INT,
    ClassID INT,
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- to display/retrive table data
select * from Exams;

INSERT INTO Exams (ExamID, ExamName, Date, TotalMarks, ClassID) VALUES
(1, 'Mid Term Exam', '2023-10-15', 100, 1),
(2, 'Final Exam', '2023-12-20', 100, 2),
(3, 'Unit Test', '2023-11-10', 50, 3),
(4, 'Quarterly Exam', '2023-09-25', 75, 4),
(5, 'Annual Exam', '2024-03-15', 100, 5);

-- to remove complete records from table
truncate table Exams;

-- to remove complete records and attributes from table
drop table Exams;

-- Table 6: Attendance 
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    StudentID INT,
    ClassID INT,
    Date DATE,
    Status ENUM('Present', 'Absent'),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- to display/retrive table data
select * from Attendance;

INSERT INTO Attendance (AttendanceID, StudentID, ClassID, Date, Status) VALUES
(1, 1, 1, '2023-10-01', 'Present'),
(2, 2, 2, '2023-10-01', 'Absent'),
(3, 3, 3, '2023-10-01', 'Present'),
(4, 4, 4, '2023-10-01', 'Present'),
(5, 5, 5, '2023-10-01', 'Absent');

-- to remove complete records from table
truncate table Attendance;

-- to remove complete records and attributes from table
drop table Attendance;

-- Table 7: Grades
CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    StudentID INT,
    SubjectID INT,
    Marks INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- to display/retrive table data
select * from Grades;

INSERT INTO Grades (GradeID, StudentID, SubjectID, Marks) VALUES
(1, 1, 1, 85),
(2, 2, 2, 78),
(3, 3, 3, 90),
(4, 4, 4, 88),
(5, 5, 5, 92);

-- to remove complete records from table
truncate table Grades;

-- to remove complete records and attributes from table
drop table Grades;

-- Table 8: Library
CREATE TABLE Library (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    ISBN VARCHAR(20),
    AvailableCopies INT
);

-- to display/retrive table data
select * from Library;

INSERT INTO Library (BookID, Title, Author, ISBN, AvailableCopies) VALUES
(1, 'The Alchemist', 'Paulo Coelho', '978-0061122415', 5),
(2, 'To Kill a Mockingbird', 'Harper Lee', '978-0061120084', 3),
(3, '1984', 'George Orwell', '978-0451524935', 4),
(4, 'Pride and Prejudice', 'Jane Austen', '978-1503290563', 2),
(5, 'The Great Gatsby', 'F. Scott Fitzgerald', '978-0743273565', 6);

-- to remove complete records from table
truncate table Library;

-- to remove complete records and attributes from table
drop table Library;

-- Table 9: ExtracurricularActivities
CREATE TABLE ExtracurricularActivities (
    ActivityID INT PRIMARY KEY,
    ActivityName VARCHAR(100),
    Description TEXT,
    ClassID INT,
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- to display/retrive table data
select * from ExtracurricularActivities;

INSERT INTO ExtracurricularActivities(ActivityID, ActivityName, Description, ClassID) VALUES
(1, 'Basketball', 'Team sport played on a court.', 1),
(2, 'Debate Club', 'A club for debating current issues.', 2),
(3, 'Science Club', 'A club for science enthusiasts.', 3),
(4, 'Drama Club', 'A club for aspiring actors.', 4),
(5, 'Art Club', 'A club for artists and creative minds.', 5);

-- to remove complete records from table
truncate table ExtracurricularActivities;

-- to remove complete records and attributes from table
drop table ExtracurricularActivities;

-- Table 10: ParentDetails
CREATE TABLE ParentDetails (
    ParentID INT PRIMARY KEY,
    StudentID INT,
    ParentName VARCHAR(100),
    Relationship VARCHAR(50),
    ContactNumber VARCHAR(15),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- to display/retrive table data
select * from ParentDetails;

INSERT INTO ParentDetails (ParentID, StudentID, ParentName, Relationship, ContactNumber) VALUES
(1, 1, 'Mr. Anil Sharma', 'Father', '9876543210'),
(2, 2, 'Mrs. Sunita Patel', 'Mother', '9876543211'),
(3, 3, 'Mr. Raj Verma', 'Father', '9876543212'),
(4, 4, 'Mrs. Kavita Iyer', 'Mother', '9876543213'),
(5, 5, 'Mr. Vikram Singh', 'Father', '9876543214');

-- to remove complete records from table
truncate table ParentDetails;

-- to remove complete records and attributes from table
drop table ParentDetails;








































