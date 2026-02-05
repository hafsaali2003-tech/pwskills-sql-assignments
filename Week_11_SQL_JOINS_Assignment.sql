create database retail_company;
use retail_company;
create table Customers (
CustomerId int primary key,
CustomerName varchar(50),
City varchar(50)
);
insert into Customers (CustomerId, CustomerName, City)
values
(1, 'Arjun Mehta', 'Mumbai'),
(2, 'Priya Sharma', 'Delhi'),
(3, 'Soham Mishra', 'Bengaluru'),
(4, 'Sneha Kapoor', 'Pune'),
(5, 'Karan Singh', 'Jaipur');
create table Orders (
OrderId int primary key,
CustomerId int,
OrderDate date,
Amount int
);
insert into Orders (OrderId, CustomerId, OrderDate, Amount)
values
(101, 1, '2024-09-01', 4500),
(102, 2, '2024-09-05', 5200),
(103, 1, '2024-09-07', 2100),
(104, 3, '2024-09-10', 8400),
(105, 7, '2024-09-12', 7600);
create table Payments (
PaymentId varchar(10) primary key,
CustomerId int,
PaymentDate date,
Amount int
);
insert into Payments (PaymentId, CustomerId, PaymentDate, Amount)
values
('P001', 1, '2024-09-02', 4500),
('P002', 2, '2024-09-06', 5200),
('P003', 3, '2024-09-11', 8400),
('P004', 4, '2024-09-15', 3000);
create table Employees (
EmployeeId int primary key,
EmployeeName varchar(50),
ManagerId int null
);
insert into Employees (EmployeeId, EmployeeName, ManagerId)
values
(1, 'Amit Khanna', null),
(2, 'Neha Joshi', 1),
(3, 'Vivek Rao', 1),
(4, 'Rahul Das', 2),
(5, 'Isha Kulkarni', 2);
/* Question 1: Retrieve all customers who have placed at least one order. /* 
select distinct co.CustomerId, co.CustomerName
from Customers as co 
join Orders as o 
on co.CustomerId = o.CustomerId; 
/* Question 2: Retrieve all customers and their orders, including customers who have not 
placed any orders. /*
select co.customerid, co.customername, o.orderid, o.orderdate, o.amount
from customers as co
left join orders as o
on co.customerid = o.customerid;
/* Retrieve all orders and their corresponding customers, including orders placed by 
unknown customers. /*
select co.customername, o.orderid, o.orderdate, o.amount
from orders as o 
left join customers as co 
on o.customerid = co.customerid;
/* Question 4: Display all customers and orders, whether matched or not. /*
select coalesce(co.customerid, o.customerid) as customerid, co.city, co.customername, o.orderid, o.orderdate, o.amount
from customers as co 
left join orders as o
on co.customerid = o.customerid
union 
select  coalesce(co.customerid, o.customerid), co.city, co.customername, o.orderid, o.orderdate, o.amount
from customers as co 
right join orders as o
on co.customerid = o.customerid
order by customerid;
/* Question 5: Find customers who have not placed any orders. /*
select co.customerid, co.customername
from customers as co 
left join orders as o
on co.customerid = o.customerid
where o.orderid is null;
/* Question 6: Retrieve customers who made payments but did not place any orders. /*
select distinct p.customerid
from payments as p
left join orders as o
on p.customerid = o.customerid
where o.orderid is null;
/* Question 7: Generate a list of all possible combinations between Customers and Orders. /*
select c.customerid as customers_table_id, c.customername, c.city, o.orderid, o.orderdate, o.amount, 
o.customerid as orders_table_id
from customers as c
cross join orders as o;
/* Question 8: Show all customers along with order and payment amounts in one table. /*
select c.customerid, c.customername, o.amount as order_amount, p.amount as payment_amount 
from customers as c 
left join orders as o
on c.customerid = o.customerid
left join payments as p
on c.customerid = p.customerid;
/* Question 9: Retrieve all customers who have both placed orders and made payments. /*
select distinct c.customerid, c.customername
from customers as c 
join orders as o
on c.customerid = o.customerid
join payments as p
on c.customerid = p.customerid;






