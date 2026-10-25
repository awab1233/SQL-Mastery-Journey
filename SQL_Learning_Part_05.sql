-- Unions
SELECT first_name, last_name
FROM employee_demographics
UNION 
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name, 'old man' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name, last_name, 'old leady' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT first_name, last_name, 'Highly' AS label
FROM employee_salary 
WHERE salary > 70000
ORDER BY 1,2 -- first_name, last_name
;

-- string functions
SELECT LENGTH('awab');
SELECT UPPER('awab');
SELECT LOWER('AWAB');
SELECT TRIM('	awab	');
SELECT LTRIM('AWAB			');
SELECT RTRIM('			AWAB');
SELECT REPLACE('awab', 'a', 'o');
SELECT LOCATE('l', 'lwab');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

SELECT first_name, birth_date,
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name, 3, 3),
SUBSTRING(birth_date, 9,2) AS birth_days
FROM employee_demographics
ORDER BY LENGTH(first_name)
;

SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics;

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name)
FROM employee_demographics;

SELECT employee_id, dept_id,
CONCAT(employee_id, dept_id)
FROM employee_salary;