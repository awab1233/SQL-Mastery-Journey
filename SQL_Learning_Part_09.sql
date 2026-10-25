-- CTEs

WITH CTE_examples (Gender, Sum_sal, Avg_sal, Max_sal, Min_sal, Count_sal)AS
(
SELECT gender, SUM(salary) sum_sal, AVG(salary) avg_sal, MAX(salary) max_sal,
		MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)

SELECT AVG(avg_sal)
FROM CTE_examples
;

SELECT AVG(avg_sal)
FROM (
SELECT gender, SUM(salary) sum_sal, AVG(salary) avg_sal, MAX(salary) max_sal,
		MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) examples_squ
;

WITH CET_example1 AS
(
SELECT employee_id, gender, birth_date
FROM employee_demographics
WHERE birth_date > '1985-12-09'
),

CET_example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT * 
FROM CET_example1
JOIN CET_example2
	ON CET_example1.employee_id = CET_example2.employee_id
;

-- Temporary Tables
CREATE TEMPORARY TABLE tem_new
(first_name VARCHAR(50),
last_name VARCHAR(50),
favorite_movie VARCHAR(50)
);

SELECT * FROM tem_new;

INSERT INTO tem_new
VALUES('awab','murwan','ku nfo panda');

SELECT * FROM tem_new;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT * 
FROM salary_over_50k;
