SELECT DISTINCT
amount
from payment;

--Filtering data with where
SELECT
*
from payment
where amount=0;

--How many payment were made by the customer with customer_id=100? #24
SELECT 
count(*)
from payment
where customer_id=100;
--What is the last name of our customer with first name 'ERICA'? #MATTHEWS
select first_name,last_name
from customer
where first_name='ERICA';

--How many rentals have not been returned yet (return date is null) #183

select
count (*)
from rental
where return_date is null;

-- List of all the payment_ids with amount <=2. Include paymend_id and the amount
select
payment_id, amount
from payment
where amount<=2
limit 10;

SELECT *
from payment
where amount=10.99
or amount = 9.99
and customer_id=439
order by amount;


SELECT *
from payment
where amount=9.99 
and customer_id=439;

SELECT *
from payment
where (amount=10.99
or amount = 9.99)
and customer_id=426
order by amount;

--List of all the payment of the customer 322, 346, 354 where the amount is either < 2, or >10. Order by customer (ascending) and amount (descending).
select *
from payment
where 
(customer_id=322 or customer_id=346 or customer_id=354)
and 
(amount<2 or amount>10)
order by customer_id, amount desc

--Between and
select * from rental
where rental_date between '2005-05-24' and '2005-05-26'
order by rental_date desc;

--Find faulty payments. How many payments have been made on January 26th and 27th 2020 with an amount between 1.99 and 3.99? #104

select 
count (*)
from payment
where amount between 1.99 and 3.99
and payment_date between '2020-01-26' and '2020-01-27 23:59:59'

--How many movies are there that contain the 'Documentary' in the description? # 101

select
count(*)
from film
where description like '%Documentary%'

--How many customers with a first name that is 3 letters long and either 'X' or a 'Y' as the last letter in the last name? #3
select
count (*)
from customer
where first_name like '___'
and 
(last_name like '%X' or last_name like '%Y')

--Comments and aliases
-- or /* ........ */

--aliases- renames the column in the data output just for this specific query
select 
count(*) as number_of_movie
from film

-- Final challenge for today

--How many movies are there that contain 'Saga' in the description and where the title strats either with 'A' or ends with 'R'? Use the alias 'no_of_movies' #14

select
count (*) as no_of_movies
from film
where description like '%Saga%'
and (title like 'A%' or title like '%R')

--Create a list of all customers where the first name contains 'ER' and has an 'A' as the second letter.Order by the last name descendingly #5

select *
from customer
where first_name like '%ER%'
and first_name like '_A%'
order by last_name DESC

--How many payments are there where the amount is either 0 or is between 3.99 and 7.99 and in the same time has happened on 2020-05-01? #27
SELECT 
count(*)
from payment
where(amount=0 
or amount between 3.99 and 7.99)
and payment_date between '2020-05-01 00:00' and '2020-05-01 23:59'








