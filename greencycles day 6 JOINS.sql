---inner join
select payment.*, 
first_name, 
last_name
from payment
inner join customer
on payment.customer_id = customer.customer_id

select payment.*,
first_name,
last_name,
email
from payment
inner join staff
on staff.staff_id=payment.staff_id
where staff.staff_id=1

---Challenge JOINS: What are the customers (first, last name, phone number, district from Texas)? Are there any (old) addresses that are not related to any customer?
select first_name, last_name, phone, district from customer c
left join address a
on c.address_id=a.address_id
where district='Texas'

select * from address a
left join customer c
on c.address_id = a.address_id
where c.customer_id is null

---Challenge: Which customers are from Brazil? Get first, last name, email and country from all customers from Brazil.
select first_name,last_name,email, ci.city_id, co.country
from customer c
left join address a
on c.address_id=a.address_id
left join city ci
on ci.city_id=a.city_id
left join country co
on co.country_id=ci.country_id
where country='Brazil'

---Which title has GEORGE LINTON rented the most often?

---Answer: CADDYSHACK JEDI - 3 times.
select first_name, last_name,title,count(*)
from customer cu
inner join rental re
on cu.customer_id=re.customer_id
inner join inventory inv
on inv.inventory_id=re.inventory_id
inner join film fi
on fi.film_id=inv.film_id
where first_name='GEORGE' and last_name='LINTON'
group by title, first_name,last_name
order by 4 desc
