/*
 Having Clause
*/
SELECT jobtitle,avg(Salary) FROM employees.EmployeeDemographics
JOIN employees. EmployeeSalary
ON EmployeeDemographics. EmployeeID = EmployeeSalary. EmployeeID
group by salary
HAVING COUNT (salary) > 450000
order by avg(salary) ;
