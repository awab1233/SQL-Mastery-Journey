SELECT * FROM employee_demographics 
WHERE birth_date < '1962-12-03';

SELECT * FROM employee_demographics
WHERE birth_date < '1982-12-03';

SELECT * FROM employee_demographics
WHERE gender != 'Female';

SELECT * FROM employee_demographics
WHERE (first_name = 'jerry' AND age = 61) OR NOT gender = 'male';

SELECT * FROM employee_demographics
WHERE first_name LIKE 'a____';

SELECT * FROM employee_demographics
WHERE first_name LIKE '%a%';

SELECT * FROM employee_demographics
WHERE birth_date LIKE '19%';

