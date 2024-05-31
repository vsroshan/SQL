SELECT FirstName + ' ' + LastName AS FullName From EmployeeDemographics;
SELECT Demo. EmployeeID, Sal. Salary
FROM  EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
ON Demo. EmployeeID = Sal. EmployeeID;