-- Case Statements
SELECT first_name, last_name, age,
CASE 
	WHEN age <= '30' THEN 'Youngth'
    WHEN age between 31 and 50 THEN  'old'
    WHEN age >= 50  THEN "On Death's Door"
END as Age_bracket
FROM employee_demographics;


-- Pay Increase and Bouns
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% Bouns
SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END as New_saary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END as bouns
FROM employee_salary;

SELECT * 
FROM parks_departments;

-- subqueries
SELECT * 
FROM employee_demographics
WHERE employee_id IN
			( SELECT employee_id
				FROM employee_salary
				WHERE dept_id = 1 )
;

SELECT first_name, last_name,
			(SELECT AVG(salary)
			FROM employee_salary)
FROM employee_salary;

SELECT gn, AVG(min_age), min_age, AVG(max_age), max_age
FROM (SELECT 
			gender AS gn, 
            AVG(age) as avg_age, 
            COUNT(age) as co_age, 
            MAX(age) as max_age, 
			MIN(age) as min_age
	   FROM employee_demographics
        GROUP BY gn) AS Agg_table
GROUP BY gn;




