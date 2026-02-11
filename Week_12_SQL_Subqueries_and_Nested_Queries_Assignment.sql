create database corporate_sales_db;
use corporate_sales_db;
create table Employee (
emp_id int primary key,
emp_name varchar(50),
department_id int,
salary int
);
insert into Employee (emp_id, emp_name, department_id, salary)
values
(101, 'Abhishek', 1, 60000),
(102, 'Shubham', 2, 50000),
(103, 'Adyut', 1, 70000),
(104, 'Shashank', 3, 55000),
(105, 'Naresh', 2, 72000),
(106, 'Sakshi', 3, 48000),
(107, 'Kusum', 1, 41000),
(108, 'Sejal', 2, 56000),
(109, 'Bhomika', 1, 69000),
(110, 'Vikash', 1, 71000),
(111, 'Vikram', 3, 59000),
(112, 'Anku', 2, 54000),
(113, 'Jimmy', 1, 64000),
(114, 'Hritik', 3, 52000),
(115, 'Swapnil', 2, 54000);
create table Department (
department_id int primary key,
department_name varchar(10)
);
insert into Department (department_id, department_name)
values
(1, 'IT'),
(2, 'HR'),
(3, 'Sales');
create table Sales (
sale_id int primary key,
emp_id int,
sale_amount int,
sale_date datetime
);
insert into Sales (sale_id, emp_id, sale_amount, sale_date)
values
(4, 104, 4500, '2024-01-09'),
(5, 105, 8000, '2024-01-11'),
(6, 106, 2500, '2024-01-12'),
(7, 107, 3000, '2024-01-15'),
(8, 108, 4200, '2024-01-16'),
(9, 109, 6500, '2024-01-18'),
(10, 110, 3100, '2024-01-19'),
(11, 111, 4400, '2024-01-22'),
(12, 112, 6000, '2024-01-23'),
(13, 113, 6700, '2024-01-25'),
(14, 114, 5100, '2024-01-29'),
(15, 115, 4900, '2024-01-31');
-- Basic Level
/* Ques 1: Retrieve the names of employees who earn more than the average salary of all employees. /*
select emp_name
from employee
where salary > (select avg(salary)
from employee);
/* Ques 2: Find the employees who belong to the department with the highest average salary. /*
select emp_name
from employee
where department_id = (select distinct department_id
from employee
group by department_id
order by avg(salary) desc
limit 1);
/* Ques 3: List all employees who have made at least one sale. /*
select emp_name
from employee
where emp_id in (
select emp_id
from sales
);
/* Ques 4: Find the employee with the highest sale amount. /*
select emp_name
from employee 
where emp_id in
(select emp_id 
from sales 
where sale_amount = (select max(sale_amount)
from sales)
);
/* Ques 5: Retrieve the names of employees whose salaries are higher than Shubham's salary. /*
select emp_name 
from employee
where salary > (select salary
from employee 
where emp_name = 'Shubham');
-- Intermediate Level
/* Ques 6: Find employees who work in the same department as Abhishek. /*
select emp_name
from employee
where department_id = (select department_id
from employee
where emp_name = 'Abhishek')
and
emp_name <> 'Abhishek';
/* Ques 7: List departments that have at least one employee earning more than $60,000. /*
select department_name
from department
where department_id in (
select distinct department_id
from employee
where salary > 60000
);
/* Ques 8: Find the department name of the employee who made the highest sale. /*
select department_name
from department
where department_id = (
select department_id
from employee
where emp_id = (
select  emp_id
from sales
order by sale_amount desc
limit 1));
/* Ques 9: Retrieve employees who have made sales greater than the average sale amount. /*
select emp_name 
from employee
where emp_id in
(select emp_id
from sales
group by emp_id
having sum(sale_amount) >(
select avg(sale_amount)
from sales));
/* Ques 10: Find the total sales made by employees who earn more than the average salary. /*
select sum(sale_amount) as total_sales
from sales
where emp_id in
(select emp_id
from employee
where salary >
(select avg(salary)
from employee))
group by emp_id;
-- Advanced Level
/* Ques 11: Find employees who have not made any sales. /*
select e.emp_name
from employee as e
left join sales as s
on e.emp_id = s.emp_id
where s.sale_amount is null;
/* Ques 12: List employees who work in departments where the average salary is above $55,000. /*
select distinct emp_name
from employee
where department_id in (
select department_id
from employee 
group by department_id
having avg(salary) > 55000);
/* Ques 13: Retrieve department names where the total sales exceed $10,000. /*
select department_name
from department
where department_id in (
select department_id
from employee as e 
join sales as s
on e.emp_id = s.emp_id
group by department_id
having sum(sale_amount) > 10000);
/* Ques 14: Find the employee who has made the second-highest sale. /*
select emp_name
from employee
where emp_id in (
select emp_id
from sales 
where sale_amount = (
select max(sale_amount) as second_highest_sale
from sales
where sale_amount < (
select max(sale_amount)
from sales)));
/* Ques 15: Retrieve the names of employees who have a salary greater than the highest sales amount recorded. /*
select emp_name
from employee
where salary > 
(select max(sale_amount)
from sales);





