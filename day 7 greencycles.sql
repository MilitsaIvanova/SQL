--Day 7
--UNION
select first_name, 'actor' as origin from actor
union
select first_name, 'customer' from customer
union 
select first_name, 'staff' from staff
order by 2 desc

---Subqueries
SELECT
*
from payment 
where amount>(select avg(amount) from payment)

select
*
from payment
where customer_id in (select customer_id from customer where first_name like 'A%')

--Challenge Subqueries in WHERE
--Select all of the films where the length is longer than the average of all films
SELECT
*
from film
where length>(select avg(length) from film)

--Return all the films that are available in the inventory in store 2 more than 3 times
select * from film
where film_id in
(select
film_id
from inventory
where store_id=2
group by film_id
having count(*)>3)

--Return all customers first names and last names that have made a payment on '2020-01-25'
select first_name, last_name from customer
where customer_id in (select customer_id
					 from payment where date(payment_date)='2020-01-25')
--Return all customers first_names and email addresses that have spent a more than 30$
select first_name, email
from customer
where customer_id in (select customer_id 
					 from payment
					 group by customer_id
					  having sum(amount)>30
					 )
--Return all the customers' first and last names that are from California and have spent more than 100 in total

--Return all the customers' first and last names that are from California and have spent more than 100 in total
select first_name, last_name
from customer
where customer_id in (select customer_id 
					 from payment
					 group by customer_id
					  having sum(amount)>100
					 )
and customer_id in (select customer_id
				   from customer
				   inner join address
				   on address.address_id=customer.address_id
					where district='California')
					
---Subqueries in FROM
select avg(total_amount)
from
(select customer_id, sum(amount) as total_amount from payment
group by customer_id) as subquery

--What is the avg total amount spent per day (avg daily revenue)?
select 
avg(amount_per_day)
from
(select
 sum(amount) as amount_per_day,
date(payment_date)
from payment
group by date(payment_date)) A

--Subqueries in SELECT
select *,(select round(avg(amount),2) from payment)
from payment

--Show all of the payments together with how much the payment amount is below the max payment amount

select *, ((select max(amount) from payment)-amount) as diff
from payment

--Correlated subqueries in WHERE
--Show only those payments that have the highest amount per customer
select
*
from payment p1
where amount = (select max(amount) from payment p2
			   where p1.customer_id=p2.customer_id)
order by customer_id

--Show only the movie titles, their associated film_id and replacement_cost with the lowest replacement_costs for in each rating category- also show the rating
select title, film_id, replacement_cost, rating
from film f1
where replacement_cost =(select min(replacement_cost) from film f2
						where f1.rating=f2.rating)
						
--Show only those movies that have the highest length in each rating category- also show the rating
select title, film_id, replacement_cost, rating
from film f1
where length =(select max(length) from film f2
						where f1.rating=f2.rating)

--Correlated subqueries in SELECT
--Show all the payments plus the total amount for every customer as well as the number of payments of each customer
select
payment_id, customer_id, staff_id, amount,
(select sum(amount) as sum_amount
from payment p2
where p1.customer_id=p2.customer_id),
(select count(amount) as count_payments
			 from payment p2
			 where p1.customer_id = p2.customer_id)
from payment p1
order by customer_id, amount desc
--Show only those films with the highest replacement costs in their category plus show the avg replacement cost in their rating category
select title, film_id, replacement_cost, rating,
(select avg(replacement_cost) from film f3
where f3.rating=f1.rating)
from film f1
where replacement_cost =(select max(replacement_cost) from film f2
						where f1.rating=f2.rating)
						
--Show only those payments with the highest payment for each customer's first name-including the payment_id of that payment
select first_name, amount, payment_id
from payment p1
inner join customer c
on p1.customer_id=c.customer_id
where amount =(select max(amount) from payment p2
			  where p1.customer_id=p2.customer_id)








