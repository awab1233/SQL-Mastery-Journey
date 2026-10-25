-- Stored procedures
CREATE PROCEDURE large_salaries()
SELECT * 
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();


-- DROP procedure IF EXISTS newtemp1
DELIMITER $$
CREATE PROCEDURE newtemp1()
BEGIN
SELECT * 
FROM employee_salary
WHERE salary >= 50000;
SELECT * 
FROM employee_salary
WHERE salary >= 10000;
END $$
DELIMITER ;

CALL newtemp1();

CALL new_procedure();

DELIMITER $$
CREATE PROCEDURE newtemp4(myCustomer INT)
BEGIN
SELECT salary
FROM employee_salary
WHERE employee_id = myCustomer;
END $$
DELIMITER ;

CALL newtemp4(3);

-- Triggers and Events 
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary 
	FOR EACH ROW 
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;


SELECT * FROM employee_demographics; 
-- Columns Name: employee_id / first_name / last_name / age / gender / birth_bay
SELECT * FROM employee_salary;
-- Columns Name: employee_id / first_name / last_name / occupation / salary / dept_id

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (16,'owab', 'mahmoud', 'music', 234000, NULL);

-- Event 

DELIMITER $$
CREATE EVENT deletes_rtails
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE 
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%';
