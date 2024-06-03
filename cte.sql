with cteemployee as
( SELECT EmployeeDemographics.EmployeeID as edid,EmployeeDemographics.FirstName,EmployeeDemographics.LastName
,EmployeeDemographics.Gender,EmployeeDemographics.Age,EmployeeSalary.EmployeeID as esid,EmployeeSalary.Salary
FROM EmployeeDemographics 
INNER JOIN employeesalary ON EmployeeDemographics.employeeid = employeesalary.employeeid)

select firstname,lastname,age from cteemployee;