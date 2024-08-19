--Update
update songs
set genre='Pop music'
where song_id=4

select * from songs

select * from film
order by rental_rate 

update film
set rental_rate=1.99
where rental_rate=0.99

--Update the customer table: 1. Add the column initials(varchar(10)) 2. Update the values to the actual initials for example Frank Smith should be F.S.
alter TABLE customer
add column if not exists initials VARCHAR(10)

select * from customer

update customer
set initials=LEFT(first_name,1) ||'.'||Left(last_name,1)||'.'

--Delete
DELETE FROM payment
where payment_id in (17064,17067)
returning *

--Create AS
CREATE TABLE customer_address
AS
SELECT first_name, last_name, email, address, city
from customer c
LEFT JOIN address a
on a.address_id=c.address_id
left join city ci
on ci.city_id=a.city_id

--Create a table customer_spendings with the two names of the customer and the total_amount spent
select customer_id, amount from payment
select first_name, last_name from customer

CREATE TABLE customer_spendings
AS
select 
c.first_name||' '||c.last_name as name,
sum(p.amount) as total_amount
from customer c
left join payment p
on p.customer_id=c.customer_id
group by first_name, last_name

--VIEW
DROP TABLE customer_spendings

CREATE VIEW customer_spendings
AS
select 
c.first_name||' '||c.last_name as name,
sum(p.amount) as total_amount
from customer c
left join payment p
on p.customer_id=c.customer_id
group by first_name, last_name

select * from customer_spendings

--Create a view called films_category that shows a list of the film titles including their title, length and category name ordered descendingly by the length. Filter the results to only the movies in the category 'Action' and 'Comedy'.

select title, length, film_id from film
select category_id, film_id from film_category
select category_id,  from category

CREATE VIEW films_category
AS
select title, length, c.name 
from film f
left join film_category fc
on fc.film_id=f.film_id
left join category c
on c.category_id=fc.category_id
where c.name in ('Action','Comedy')
order by length desc

--MATERIALIZED VIEW
CREATE MATERIALIZED VIEW mv_film_category
AS
select title, length, c.name 
from film f
left join film_category fc
on fc.film_id=f.film_id
left join category c
on c.category_id=fc.category_id
where c.name in ('Action','Comedy')
order by length desc

update film 
set length=192
where title='SATURN NAME'

refresh MATERIALIZED view mv_film_category

--1) Rename the view to v_customer_information.

--2) Rename the customer_id column to c_id.

--3) Add also the initial column as the last column to the view by replacing the view.

CREATE VIEW v_customer_info
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id
--1)
ALTER VIEW v_customer_info
RENAME TO v_customer_information

--2)
ALTER VIEW v_customer_information
RENAME COLUMN customer_id TO c_id

--3)
CREATE OR REPLACE VIEW v_customer_information
as
SELECT cu.customer_id as c_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country,
	left(cu.first_name,1)||'.'||left(cu.last_name,1)||'.' as initials
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id

select * from v_customer_information


