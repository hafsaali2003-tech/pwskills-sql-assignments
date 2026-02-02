use da_offline;
select * from sales_transaction_dataset;
ALTER TABLE sales_transaction_dataset
DROP COLUMN `MyUnknownColumn_[4]`,
DROP COLUMN `MyUnknownColumn_[5]`;
/* Question 1: Basic Filtering with WHERE
Write a query to find all transactions where the amount is greater than $1000. /*
select *
from sales_transaction_dataset
where amount > 1000;
/* Question 2: Using Logical Operators (AND, OR)
 Find all transactions in the Electronics category where the amount is more than $500. /*
 select *
 from sales_transaction_dataset
 where category = 'Electronics' and amount > 500;
 /* Question 3: Filtering with Date Condition
 Retrieve all transactions that occurred after March 1, 2024. /*
 select *
 from sales_transaction_dataset
 where str_to_date(transaction_date, '%d-%m-%Y') > '2024-03-01';
 /* Question 4: Handling Multiple Conditions
Find transactions where the amount is between $500 and $1000 AND the category is Furniture. /*
select *
from sales_transaction_dataset
where amount between 500 and 1000 
and category = 'Furniture';
/* Question 5: Using NULL Filtering
If some transactions have missing payment methods, find those transactions. /*
select transaction_id
from sales_transaction_dataset
where payment_method is null;
/* Question 6: Sorting Results with ORDER BY
Retrieve all transactions sorted by amount in descending order. /*
select *
from sales_transaction_dataset
order by amount desc;
/* Question 7: Counting Transactions per Category (GROUP BY)
Find the number of transactions in each category. /*
select category, count(*) as transactions
from sales_transaction_dataset
group by category;
/* Question 8: Using HAVING to Filter Aggregated Data
Retrieve categories that have more than 3 transactions. /*
select category, count(*) as transactions
from sales_transaction_dataset
group by category
having count(*) > 3;
/* Question 9: Finding the Total Revenue per Region
Calculate the total sales amount per region, displaying only regions where total sales exceed $3000. /*
select region, sum(amount) as total_revenue
from sales_transaction_dataset
group by region
having sum(amount) > 3000;
/* Question 10: Advanced Query: Filtering High-Value Transactions with Aggregates
Find the regions where the average transaction amount is greater than $800, but only for categories that
have more than 3 transactions. /*
select region, avg(amount) as avg_sales, count(*) as total_transactions
from sales_transaction_dataset
group by region
having avg(amount) > 800 and count(*) > 3;









 
 
 
 