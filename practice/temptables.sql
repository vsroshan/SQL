DROP TEMPORARY TABLE IF EXISTS employeedetiles;
CREATE TEMPORARY TABLE employeedetiles AS 
SELECT 
    jobtitle,
    AVG(Salary) AS avg_salary
FROM 
    employees.EmployeeDemographics 
JOIN 
    employees.EmployeeSalary 
ON 
    EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID 
GROUP BY 
    jobtitle 
HAVING 
    COUNT(Salary) > 450000 
ORDER BY 
    avg_salary;
    select * from employeedetiles;