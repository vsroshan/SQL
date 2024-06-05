DELIMITER $$
CREATE PROCEDURE getemployee ()
BEGIN

SELECT * FROM EmployeeDemographics;
END$$
DELIMITER ;

call getemployee ();


DELIMITER $$
CREATE PROCEDURE findemployee (IN id INT)
BEGIN 
SELECT *
FROM EmployeeDemographics
WHERE EmployeeID = id;
END
$$
DELIMITER ;



call findemployee(1002);