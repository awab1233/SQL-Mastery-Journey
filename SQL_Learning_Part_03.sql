-- group by
SELECT *
FROM employee_demographics;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;

SELECT salary, occupation
FROM employee_salary
GROUP BY salary, occupation;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age), COUNT(gender)
FROM employee_demographics
GROUP BY gender
;

-- order by
SELECT * 
FROM employee_demographics
ORDER BY gender, age;

SELECT * 
FROM employee_demographics
ORDER BY first_name DESC; -- ASC

SELECT *
FROM employee_demographics
ORDER BY 5, 2;