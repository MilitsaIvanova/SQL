---Course project

---Question 1
--Task: Create a list of all the different (distinct) replacement costs of the films. What's the lowest replacement cost?
select distinct replacement_cost
from film
order by replacement_cost

--Question 2
--Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges: low: 9.99 - 19.99 medium: 20.00 - 24.99 high: 25.00 - 29.99. Question: How many films have a replacement cost in the "low" group?
SELECT
case 
when replacement_cost between 9.99 and 19.99 then 'low'
when replacement_cost<24.99 then 'medium'
when replacement_cost<29.99 then 'high'
end as cost_range,
count(*)
from film
group by cost_range

--Question 3
--Task: Create a list of the film titles including their title, length, and category name ordered descendingly by length. Filter the results to only the movies in the category 'Drama' or 'Sports'. Question: In which category is the longest film and how long is it?

-- SELECT title, length from film
-- select category_id,film_id from film_category
-- select category_id, name from category

select f.title, f.length, fc.category_id, fc.film_id, c.name from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on c.category_id = fc.category_id
where c.name='Drama' or c.name='Sports' 
order by f.length desc

--Question 4
--Task: Create an overview of how many movies (titles) there are in each category (name).Question: Which category (name) is the most common among the films?
select count(*), c.name from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on c.category_id = fc.category_id
group by c.name 
order by count(*) desc

--Question 5
--Task: Create an overview of the actors' first and last names and in how many movies they appear in. Question: Which actor is part of most movies??
select a.first_name, a.last_name, count(*) from actor a 
inner join film_actor fa
on fa.actor_id = a.actor_id
group by a.first_name,a.last_name
order by count(*) desc

--Question 6
--Task: Create an overview of the addresses that are not associated to any customer. Question: How many addresses are that?
select * from address a
left join customer c 
on c.address_id = a.address_id
where c.first_name is null

--Question 7
--Task: Create the overview of the sales to determine from which city (we are interested in the city in which the customer lives, not where the store is) most sales occur. Question: What city is that and how much is the amount?

--select customer_id, address_id from customer
--select city_id, address_id from address
--select city_id, city from city
--select customer_id, amount, payment_id from payment

select sum(p.amount), c.city from payment p
inner join customer cu 
on cu.customer_id=p.customer_id
inner join address a
on cu.address_id = a.address_id
inner join city c 
on c.city_id=a.city_id
group by city
order by sum(p.amount) desc

--Question 8
--Task: Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city". Question: Which country, city has the least sales?
select cou.country||', '||city as country_city,
sum(amount)
from payment p
inner join customer cu 
on cu.customer_id=p.customer_id
inner join address a
on cu.address_id = a.address_id
inner join city c 
on c.city_id=a.city_id
inner join country cou
on cou.country_id = c.country_id
group by cou.country||', '||city
order by sum(amount)

--Question 9
--Task: Create a list with the average of the sales amount each staff_id has per customer. Question: Which staff_id makes on average more revenue per customer?
select amount, customer_id, staff_id from payment


select
staff_id,
round(avg(total),2) as avg_amount
from (
select sum(amount) as total, customer_id,staff_id
from payment
group by customer_id,staff_id) a
group by staff_id

--Question 10
--Task: Create a query that shows average daily revenue of all Sundays. Question: What is the daily average revenue of all Sundays?
select 
avg(total)
from (SELECT
	 sum(amount) as total,
	 date(payment_date),
	 extract(dow from payment_date)as weekday
	  from payment
	  where extract(dow from payment_date)=0
	 group by date(payment_date),weekday) daily

--Question 11
--Task: Create a list of movies - with their length and their replacement cost - that are longer than the average length in each replacement cost group. Question: Which two movies are the shortest on that list and how long are they?
select title, length, replacement_cost 
from film f1
where length>(select avg(length) from film f2
			 where f1.replacement_cost=f2.replacement_cost)
order by length

--Question 12
--Task: Create a list that shows the "average customer lifetime value" grouped by the different districts.
--Example: If there are two customers in "District 1" where one customer has a total (lifetime) spent of $1000 and the second customer has a total spent of $2000 then the "average customer lifetime spent" in this district is $1500. So, first, you need to calculate the total per customer and then the average of these totals per district.
--Question: Which district has the highest average customer lifetime value?

SELECT
district,
ROUND(AVG(total),2) avg_customer_spent
FROM
(SELECT 
c.customer_id,
district,
SUM(amount) total
FROM payment p
INNER JOIN customer c
ON c.customer_id=p.customer_id
INNER JOIN address a
ON c.address_id=a.address_id
GROUP BY district, c.customer_id) sub
GROUP BY district
ORDER BY 2 DESC

--Question 13
--Task: Create a list that shows all payments including the payment_id, amount, and the film category (name) plus the total amount that was made in this category. Order the results ascendingly by the category (name) and as second order criterion by the payment_id ascendingly. Question: What is the total revenue of the category 'Action' and what is the lowest payment_id in that category 'Action'?
select
title, amount, name, payment_id,
(select sum(amount) from payment p
left join rental r
on r.rental_id=p.rental_id
left join inventory i
on i.inventory_id=r.inventory_id
left join film f
 on f.film_id=i.film_id 
 left join film_category fc
 on fc.film_id=f.film_id
 left join category c1
 on c1.category_id=fc.category_id
 where c1.name=c.name)
 from payment p
 left join rental r
 on r.rental_id=p.rental_id
 left join inventory i
 on i.inventory_id=r.inventory_id
 left join film f
 on f.film_id=i.film_id
 left join film_category fc
 on fc.film_id=f.film_id
 left join category c
 on c.category_id=fc.category_id
 order by name,payment_id

--Question 14
--Task: Create a list with the top overall revenue of a film title (sum of amount per title) for each category (name). Question: Which is the top-performing film in the animation category?
SELECT
title,
name,
SUM(amount) as total
FROM payment p
LEFT JOIN rental r
ON r.rental_id=p.rental_id
LEFT JOIN inventory i
ON i.inventory_id=r.inventory_id
LEFT JOIN film f
ON f.film_id=i.film_id
LEFT JOIN film_category fc
ON fc.film_id=f.film_id
LEFT JOIN category c
ON c.category_id=fc.category_id
GROUP BY name,title
HAVING SUM(amount) =     (SELECT MAX(total)
			  FROM 
                                (SELECT
			          title,
                                  name,
			          SUM(amount) as total
			          FROM payment p
			          LEFT JOIN rental r
			          ON r.rental_id=p.rental_id
			          LEFT JOIN inventory i
			          ON i.inventory_id=r.inventory_id
				  LEFT JOIN film f
				  ON f.film_id=i.film_id
				  LEFT JOIN film_category fc
				  ON fc.film_id=f.film_id
				  LEFT JOIN category c1
				  ON c1.category_id=fc.category_id
				  GROUP BY name,title) sub
			   WHERE c.name=sub.name)
