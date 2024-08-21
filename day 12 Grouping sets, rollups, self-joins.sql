--Grouping sets
SELECT
staff_id,
to_char(payment_date,'Month') as month,
sum(amount)
from payment 
group by 
	grouping sets(
		(staff_id),
		(month),
		(staff_id,month)
	)
order by 1,2

--Return the sum of the amount for each customer (first name, last name) and each staff_id. Also add the overall revenue per customer.
SELECT
first_name,
last_name,
staff_id,
sum(amount)
from payment p
left join customer c
on p.customer_id = c.customer_id
group by
	grouping sets(
		(first_name, last_name),
		(first_name, last_name,staff_id)
	)
order by 1, 3

--Create a column which calculates the share of revenue each staff_id makes per customer
SELECT
first_name,
last_name,
staff_id,
sum(amount),
round(100*sum(amount)/FIRST_VALUE(SUM(amount)) over (PARTITION by first_name, last_name order by sum(amount) DESC),2)
from payment p
left join customer c
on p.customer_id = c.customer_id
group by
	grouping sets(
		(first_name, last_name),
		(first_name, last_name,staff_id)
	)
order by 1, 3

--CUBE and ROLLUP
select 
'Q'||to_char(payment_date, 'Q') as quarter,
extract(month from payment_date) as month,
date(payment_date),
sum(amount)
from payment
group by
ROLLUP(
	'Q'||to_char(payment_date, 'Q'),
extract(month from payment_date),
date(payment_date)
)
order by 1, 2,3


--CUBE & ROLLUP
select 
customer_id,
staff_id,
date(payment_date),
sum(amount)
from payment
group by
cube(
	customer_id,
staff_id,
date(payment_date)
)
order by 1,2,3

--Write a query that returns all grouping sets in all combinations of customer_id, date and title with the aggregation of the payment amount.
select customer_id, rental_id, amount from payment
select title, film_id from film
select rental_id, customer_id, inventory_id from rental
select inventory_id, film_id from inventory

select p.customer_id, date(payment_date), title,
sum(amount)
from payment p
left join rental r
on r.rental_id = p.rental_id
left join inventory i
on i.inventory_id = r.inventory_id
left join film f
on f.film_id=i.film_id
group by
cube(
	p.customer_id, date(payment_date), title
)
order by 1,2,3

--self-join

CREATE TABLE employee (
	employee_id INT,
	name VARCHAR (50),
	manager_id INT
);

INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);
	
select * from employee
	
SELECT
emp.employee_id,
emp.name as employee,
mng.name as manager,
mng2.name as manager_of_manager
from employee emp
left join employee mng
on emp.manager_id=mng.employee_id
left join employee mng2
on mng.manager_id=mng2.employee_id

-- Find all the pairs of films with the same length
select f1.title,
f2.title,
f1.length
from film f1
left join film f2
on f1.length = f2.length
where f1.title != f2.title
order by 3 desc

--cross join
select
staff_id,
store.store_id,
last_name,
store.store_id*staff_id
from staff
cross join store

--natural join
select * from payment
NATURAL inner join customer

select * from payment
NATURAL left join customer