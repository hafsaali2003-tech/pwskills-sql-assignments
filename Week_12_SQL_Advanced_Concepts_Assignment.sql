/* Question 1: What is the syntax of a window function? /*
/* Answer 1:  select *, row_number() over (partition by column order by column) /*
/* Question 2: What is the purpose of the FIRST_VALUE() and LAST_VALUE() functions? /*
/* Answer 2: FIRST_VALUE() returns the first value in a window (partition) based on the specified order by
and LAST_VALUE() returns the last value in a window (partition) based on the specified order by. /*
use da_offline;
create table Employee_db (
employee_id int primary key,
name varchar(50),
department varchar(10),
salary int,
hire_date date
);
insert into Employee_db (employee_id, name, department, salary, hire_date)
values
(1, 'Alice', 'HR', 55000, '2020-01-15'),
(2, 'Bob', 'HR', 80000, '2019-05-16'),
(3, 'Charlie', 'HR', 70000, '2018-07-30'),
(4, 'Dev', 'Finance', 48000, '2021-01-10'),
(5, 'Imran', 'IT', 68000, '2017-12-25'),
(6, 'Jack', 'Finance', 60000, '2019-11-05'),
(7, 'Jason', 'IT', 45000, '2018-03-15'),
(8, 'Kiara', 'IT', 70000, '2022-06-18'),
(9, 'Michael', 'IT', 42000, '2019-05-20'),
(10, 'Nalini', 'Finance', 41500, '2021-08-24'),
(11, 'Nandini', 'Finance', 52000, '2017-03-25');
create table Department_db (
department_id int primary key,
department_name varchar(10),
Location varchar(50)
);
insert into Department_db (department_id, department_name, Location)
values
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'Chicago');
/* Question 3: Write an SQL query to assign a unique rank to each employee based on salary (highest first) using ROW_NUMBER(). /*
select employee_id, name, salary, 
row_number() over (order by salary desc) as salary_rnk
from employee_db;
/* Question 4: Write a query to find each employee's department and their department-wise rank based on salary. /*
select name, department, salary,
rank() over (partition by department order by salary desc) as dept_rnk
from employee_db; 
/* Question 5: What will happen if we use DENSE_RANK() instead of RANK() ? /*
/* Answer 5: DENSE_RANK() does not skip rank numbers after a tie but RANK() skips the next rank after a tie. /*
/* Question 6: Write a query to calculate a running total of salaries across all employees (ordered by hire_date). /*
select name, hire_date, salary,
sum(salary) over (order by hire_date) as running_total
from employee_db;
/* Question 7: Write a query to show each employee’s salary and the difference from the highest salary in their department. /*
select a.name, a.department, a.salary, b.highest_salary - a.salary as diff_from_highest
from
(select name, department, salary 
from employee_db) as a
join
(select department, max(salary) as highest_salary
from employee_db
group by department) as b 
on a.department = b.department;
-- another method 
select name, department, salary,
max(salary) over (partition by department) -  salary as diff_from_highest
from employee_db;
/* Question 8: Write a query to compute a 3-period moving average of salaries based on hire date. /*
select name, hire_date, salary,
avg(salary) over (
order by hire_date
rows between 2 preceding and current row
) as moving_avg
from employee_db;
/* Question 9: Write a query using CUME_DIST() to find the cumulative distribution of salaries. /*
select name, salary,
cume_dist() over (order by salary) as cumulative_distribution
from employee_db;
/* Question 10: Write a query to retrieve the last hired employee in each department using LAST_VALUE() . /*
select name, department, hire_date,
last_value(name) over (
partition by department
order by hire_date
rows between unbounded preceding and unbounded following
) as last_hired_employee
from employee_db;
/* Question 11: What happens when you use RANGE instead of ROWS in a window function? Provide an example query. /*
/* Answer 11: RANGE basically includes rows with the same order by value , it is value based
whereas ROW includes a fixed number of rows, it is position based. /*
select name, salary,
sum(salary) over (
order by salary
range between unbounded preceding and current row
) as cumulative_salary
from employee_db;
/* Question 12: Write an SQL query to list employees whose salary is above their department’s average salary. Use a subquery
with a window function. /*
select * from 
(select name, department, salary,
avg(salary) over (partition by department) as dept_avg_salary 
from employee_db) as e
where salary > dept_avg_salary;
/* Question 13: Write a query to join the employees and departments tables and calculate each employee’s rank within their
department based on salary. (Hint: Use Table 2 ). /*
select e.name, d.department_name, e.salary,
rank() over (partition by e.department order by e.salary desc) as dept_rnk 
from employee_db as e 
join department_db as d
on e.department = d.department_name;











