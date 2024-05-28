create database employees;

CREATE TABLE EmployeeInfo
(EmployeeID int, FirstName varchar (50), LastName varchar (50), Age int, Gender varchar (50));

CREATE TABLE EmployeeSalary
(EmployeeID int,JobTitle varchar (50), Salary int);


Insert into EmployeeInfo VALUES
(1001,'roshan','vs',21,'male'),
(1002, 'suji', 'B', 30, 'Female'),
(1003, 'harita', 'vs', 29, 'Female'),
 (1004, 'leela', 'M', 32, 'Feale'),
(1005, 'sudhir', 'G' ,31, 'Male'),
(1006, 'viji', 'B', 35, 'Female'),
(1007, 'rajnaa', 'A', 32, 'Female'),
 (1008,'kamari', 'K', 38, 'Female'),
(1009, 'jarvis', ' ', 31, 'Male');


Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000);


