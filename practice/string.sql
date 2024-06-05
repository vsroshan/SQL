select firstname,length(firstname)
from EmployeeDemographics;
select firstname,upper(firstname)
from EmployeeDemographics;
SELECT LTRIM('    sky   ');
SELECT rTRIM('    sky   ');
SELECT TRIM('    sky   ');

SELECT firstname, LEFT(firstname, 2)
FROM employeedemographics;
SELECT firstname, replace(firstname,'a','z')
FROM employeedemographics;

SELECT firstname, lastname,
 CONCAT (firstname,' ', lastname) AS fullname
 FROM employeedemographics;
