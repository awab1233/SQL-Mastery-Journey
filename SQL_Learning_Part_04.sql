-- having
SELECT AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager'
GROUP BY occupation
HAVING AVG(salary) > 70000;

-- limit, aliasing
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 0,11;

SELECT gender, AVG(age) as av_age
FROM employee_demographics
GROUP BY gender
HAVING av_age > 40 ;

-- joins
SELECT * FROM
employee_demographics;

SELECT * FROM
employee_salary;

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;

-- self join
SELECT 
em1.employee_id AS santa,
em1.first_name AS first_name_santa,
em1.last_name AS last_name_santa,
em2.employee_id AS fanta,
em2.first_name AS fist_name_fanta,
em2.last_name AS last_name_fanta
FROM employee_salary em1
JOIN employee_salary em2
	ON em1.employee_id + 1 = em2.employee_id;
    
-- joing multiple tables together
SELECT * 
FROM parks_departments;

SELECT * 
FROM employee_salary;

SELECT *
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id;

