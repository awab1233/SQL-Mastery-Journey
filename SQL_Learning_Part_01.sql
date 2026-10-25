SELECT first_name,
last_name,
birth_date,
age,
(age + 10) * 10 - 20
FROM employee_demographics;
#PEMDAS

SELECT DISTINCT first_name ,gender FROM employee_demographics;