create database ecommerce_platform;
use ecommerce_platform;
create table orders (
order_id int primary key,
customer_id int,
product_name varchar(50),
order_date date
);
insert into orders (order_id, customer_id, product_name, order_date)
values
(101, 200, 'Laptop', '2025-01-15'),
(102, 201, 'Phone', '2025-01-16'),
(103, 202, 'Laptop', '2025-01-17'),
(104, 200, 'Tablet', '2025-01-18'),
(105, 203, 'Phone', '2025-01-19'),
(106, 204, 'Laptop', '2025-01-20');
-- 1. Practical Use of DISTINCT in SQL
/* Question 1: Unique Products:
Write a SQL query that will return a list of unique products ordered by customers (i.e., without duplicates). /*
select distinct product_name
from orders;
/* Question 2: Unique Customers:
Write a SQL query to find out how many unique products were ordered by each customer.
The result should show the customer’s ID and the number of distinct products they’ve ordered. /*
select customer_id, count(distinct product_name) as unique_products
from orders
group by customer_id;
/* Question 3: Distinct Product Count:
Write a query to count the number of distinct products ordered on the platform. This should return a single number. /*
select count(distinct product_name) as total_unique_products
from orders;
/* Question 4: Sorting by Most Recent Orders:
Write a SQL query that returns the most recent distinct products ordered, sorted by the order date in descending order.
Limit the result to the top 3 most recent products. /*
select distinct product_name
from orders
group by product_name
order by max(order_date) desc
limit 3;
insert into orders (order_id, customer_id, product_name, order_date)
values
(107, 205, 'Phone', '2025-02-01'),
(108, 206, 'Tablet', '2025-02-02');
-- 2. Combining DISTINCT, LIMIT, and ORDER BY in SQL
/* Question 1: Top Products in the Last Month:
Write a SQL query to return the top 2 most ordered distinct products from the last month.
Sort the results by order date in descending order and limit the output to the top 2. /*
select distinct product_name, count(*) as total_orders
from orders
where order_date >= date_sub( (select max(order_date) from orders), interval 1 month)
group by product_name
order by total_orders desc
limit 2;
/* Question 2: Unique Products for Specific Customer:
Write a SQL query to return the distinct products ordered by customer 200, sorted by the order date 
in descending order. Limit the result to 3 products. /*
select distinct product_name
from orders
where customer_id = 200 
group by product_name
order by max(order_date) desc
limit 3;
/* Question 3: Top N Products:
Write a SQL query to retrieve the top 5 most ordered products based on the number of distinct orders,
sorted by product name in ascending order. Limit the result to the top 5. /*
select product_name, count(distinct order_id) as order_count
from orders
group by product_name
order by order_count desc, product_name asc
limit 5;
/* Question 4: Unique Orders for Each Product:
Write a SQL query to count the distinct number of orders placed for each product. Sort the results 
by the number of distinct orders in descending order. /*
select product_name, count(distinct order_id) as total_orders
from orders
group by product_name
order by total_orders desc;
-- 3. Optimizing Queries with DISTINCT and Indexing
/* Question 1: Optimizing Query with DISTINCT:
Given a large dataset, write a SQL query to retrieve the distinct products
ordered in the last month. Suggest an optimization strategy using indexes. What columns would you index
to make this query faster? /*
select distinct product_name
from orders
where order_date >= date_sub((select max(order_date) from orders), interval 1 month);
/* Answer 1: In order to otimize this query for large datasets, an index should be created for the columns order_date
and product_name as it reduces the number of rows which will be scanned and makes the performance faster and better
when filtering and retrieving distinct values. /*
/* Question 2: Performance Consideration:
Why is using DISTINCT on large datasets computationally expensive? What
impact does it have on query performance? /*
/* Answer 2: DISTINCT on large datasets is expensive because it requires the scanning and comaprison of each row 
which uses a lot of memory and takes more time than it should so we can use indexing to resolve ths issue 
as it reduces the number or rows scanned and also improves the performance. /*
/* Question 3: Efficient Query Writing:
Write a SQL query that retrieves only the top 3 distinct products ordered by customer 200. 
Use LIMIT and ORDER BY efficiently, and explain why the query is optimized for performance. /*
select product_name, max(order_date)as latest_order
from orders
where customer_id = 200
group by product_name
order by latest_order desc
limit 3;
/* Answer 3: This query is optimized because it uses WHERE to filter rows, it uses group by to group the rows,
it uses order by to sort the data in descending order and finally it uses limit to restrict the output. /*
-- 4. Query Optimization and Analysis with DISTINCT, LIMIT, and ORDER BY
/* Question 1: Execution Plan Analysis:
Write a SQL query that returns the most popular products ordered in the last 30 s. Use DISTINCT, LIMIT, and ORDER BY
to fetch the top 10 products. Use the EXPLAIN keyword to analyze the execution plan and 
identify potential performance issues. /*
select distinct product_name, count(*) as total_orders
from orders
where order_date >= date_sub(
(select max(order_date) from orders), interval 30 second
)
group by product_name
order by total_orders desc
limit 10;
/* Answer 1: First of all, I analyzed the query using EXPLAIN keyword to understand the execution plan and identify 
potential performance issues, then afterwards , I ran the query after removing the EXPLAIN keyword and the query ran successfully. /*
/* Question 2: Optimizing Sorting and Filtering:
If the database grows even further, which column(s) would you recommend indexing to improve the speed
of queries involving ORDER BY, DISTINCT, and LIMIT? /*
/* Answer 2: 
Let's take Question 1's query as an example, so in order to that query, if there are millions of rows 
in that database now, we need indexing of columns for that in order run the query faster than earlier and 
save time by jumping to the recent rows without scanning the whole table.
Now, which columns should be included in indexing, both of the column named order_date and product_name should be
included in indexing as by indexing order_date -> orders will quickly get filtered of the last 30 seconds and by
indexing product_name -> the rows will be grouped by product_name of orders. /*
/* Question 3: Alternative Query Approaches:
Write an optimized version of a query that retrieves the top 5 most ordered products in the last 30 s. Discuss why
your query is more efficient than using DISTINCT without optimization. /*
select product_name, count(*) as total_orders
from orders
where order_date >= date_sub(
(select max(order_date) from orders), interval 30 second
)
group by product_name
order by total_orders desc
limit 5;
/* Answer 3: 
We have used here WHERE clause which filters the query by reducing the number of rows which needs to be checked,
we have used max(order_date) in order to find the most recent orders in the last 30 seconds which helped in filtering 
the data, we have used order by to sort the data efficiently in descending order, we have used the limit clause to 
show only top 5 products and finally most important one , we have used group by to group the rows by product_name
which already filters and show only unique values and this clause is used with aggregate functions, so this is more
efficient than to use distinct without optimization. /*
-- 5. Real-World Scenario and Complex Query Creation
/* Question 1: Complex Query Creation:
Write a SQL query that retrieves the top 10 most recent distinct products ordered, sorted by the order date 
in descending order. Make sure to limit the result to 10 products. /*
select product_name, max(order_date) as latest_order_date
from orders
group by product_name
order by latest_order_date desc
limit 10;
/* Question 2: Query Optimization:
Discuss how you would optimize the query if the orders table had millions of rows. What indexing strategies would you 
apply to ensure efficient query execution? /*
/* Answer 2: To optimize the query which should create indexes for columns, for example we should index column 
product_name and order_date if we want to find the the recent orders of products, because by composite indexing of 
both , we will b able to find recent orders by filtering automatically with the help of order_date and then we can
group the orders by product_name with the help of indexing of product_name column. /*
/* Question 3: Additional Enhancements:
Imagine that the query needs to be enhanced to show the customer who made the most recent purchase for each product. 
How would you modify your query to include this information? /*
select customer_id, product_name, order_date
from orders
where order_date = (
select max(o2.order_date)
from orders o2
where o2.product_name = orders.product_name
)
order by order_date desc
limit 10;
/* Answer 3: To modify the above mentioned query we will add a subquery, the subquery will show the latest order date 
for each product and the outer query will show the customer_id of those products./*














