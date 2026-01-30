use world;
select * from city limit 5;
select * from country limit 5;
-- Question 1: Write an SQL query to find the country with the maximum population in the table.
select name, population
from country
order by population desc
limit 1;
-- Question 2: Write an SQL query to sum the populations of all cities per country.
select countrycode, sum(population) as total_population
from city
group by countrycode;
-- Question 3: Find the top 3 countries with the highest population density.
select name, population / surfacearea as population_density
from country
where surfacearea > 0
order by population_density desc
limit 3;
use sakila;
select * from payment limit 5;
-- Question 4: Write an SQL query to find the customer_id who has the highest number of rentals.
select customer_id, count(*) as total_rentals
from rental
group by customer_id
order by total_rentals desc
limit 1;
-- Question 5: Write an SQL query to identify the month with the most rentals.
select rental_date as month, count(*) as total_rentals
from rental
group by month
order by total_rentals desc
limit 1;
-- Question 6: Find the total revenue generated per day.
select payment_date as payment_day, sum(amount) as total_revenue
from payment
group by payment_day;
-- Question 7: Find the store that generated the highest total revenue.
select staff.store_id, sum(payment.amount) as total_revenue
from payment
join staff
on payment.staff_id = staff.staff_id
group by staff.store_id
order by total_revenue desc
limit 1;
-- Question 8: Find the customers who have made exactly 5 payments.
select customer_id as customer
from payment
group by  customer
having count(*) = 5;




