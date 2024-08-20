--Window functions

SELECT *,
round(sum(amount) over (PARTITION by customer_id,staff_id),1)
from payment
order by 1

--Return the list of movies including film_id, title, length, category, average length of movies in that category. Order by film_id
SELECT
film.film_id, title, length, category.name,
round(avg(length) over(PARTITION by category),2)
from film
left join film_category ON film_category.film_id = film.film_id
left join category on category.category_id = film_category.category_id
order by film_id

--Return all payment details including the number of payments that were made by this customer and that amount. Order by payment_id
SELECT
payment_id, customer_id, staff_id, rental_id, amount, payment_date,
count(*) over (PARTITION by customer_id,amount) AS number_payments_with_that_amount
from payment
order by payment_id

--RANK()
select * from(
SELECT
f.title,
c.name,
f.length,
DENSE_RANK() OVER( PARTITION BY name ORDER BY length desc) as rank
from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on c.category_id = fc.category_id
	) a 
	where rank=1
	
--Return the customers' name, the country, and how many payments they have. Use the existing view customer_list
select * from(
select name, country,
count(*),
rank() over (partition by country order by count(*) desc) as rank
from customer_list cl
left join payment p
on p.customer_id=cl.id
group by cl.name, country
) a 
where rank between 1 and 3

--FIRST_VALUE()
select name, country,
count(*),
first_value(count(*)) over (partition by country order by count(*) ASC) as rank,
count(*)-first_value(count(*)) over (partition by country order by count(*) asc) 
from customer_list cl
left join payment p
on p.customer_id=cl.id
group by cl.name, country

--LEAD & LAG
select name, country,
count(*),
LEAD(count(*)) over (partition by country order by count(*) ASC) as rank,
LEAD(count(*)) over (partition by country order by count(*) ASC) - count(*)
FROM customer_list cl
left join payment p
on p.customer_id=cl.id
group by cl.name, country

select name, country,
count(*),
LAG(count(*)) over (partition by country order by count(*) ASC) as rank,
LAG(count(*)) over (partition by country order by count(*) ASC) - count(*)
FROM customer_list cl
left join payment p
on p.customer_id=cl.id
group by cl.name, country

--Calculate the % growth of the revenue of the previous day. Return the revenue of the day and the previous day and the difference
SELECT
sum(amount),
date(payment_date) as day,
lag(sum(amount)) over (order by date(payment_date)) as previous_day,
sum(amount)-lag(sum(amount)) over (order by date(payment_date)) as difference,
round((sum(amount)-lag(sum(amount)) over (order by date(payment_date)))/ lag(sum(amount)) over (order by date(payment_date)) *100,2) as growth
from payment
group by date(payment_date)
