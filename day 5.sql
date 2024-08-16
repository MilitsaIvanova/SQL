---Math functions and operators
SELECT
round(9.0/4,2)
---Modulo 
Select
10%4
--- abs(x), round(x,d), ceiling(x), floor(x)

---Create a list of the film including the relation of rental rate/ replacement cost where the rental rate is less than 4% of the replacement cost. Create a list of that film_ids together with the % rounded to 2 decimal places. For example 3.54%

select
film_id,
round(round(rental_rate/replacement_cost,4)*100,2) as percentage
from film
where rental_rate/replacement_cost < 0.04
order by percentage

---case when
SELECT
amount,
case
when amount< 2 then 'low amount'
when amount <5 then 'medium amount'
else 'high amount'
end
from payment

--Challenge 3
--Create a tier list of the movies

SELECT
title,
case
	when rating in ('PG','PG-13') or film.length >210 then 'Great rating or long (tier 1)'
	when description Like '%Drama%' and film.length >90 then 'Long drama (tier 2)'
	when description like '%Drama%' and film.length < 90 then 'Short drama (tier 3)'
	when rental_rate <1 then 'Very cheap (tier 4)'
end as tier_list
from film
where 
case
	when rating in ('PG','PG-13') or film.length >210 then 'Great rating or long (tier 1)'
	when description Like '%Drama%' and film.length >90 then 'Long drama (tier 2)'
	when description like '%Drama%' and film.length < 90 then 'Short drama (tier 3)'
	when rental_rate <1 then 'Very cheap (tier 4)'
end is not null
limit 10


--case when & sum
select
sum(case
when rating in ('PG','G') then 1
else 0
end) as no_of_ratings_with_g_or_pg
from film

--pivoting
select
rating,
count(*)
from film group by rating

SELECT
sum(case when rating ='G' then 1 else 0 end) as "G",
sum(case when rating ='PG-13' then 1 else 0 end) as "PG-13",
sum(case when rating ='NC-17' then 1 else 0 end) as "NC-17",
sum(case when rating ='R' then 1 else 0 end) as "R",
sum(case when rating ='PG' then 1 else 0 end) as "PG"
from film

---Challenge COALESCE and CAST
SELECT
rental_date,
return_date
from rental
order by rental_date desc

SELECT
coalesce(cast(return_date as varchar),'not returned' )
from rental
order by coalesce(cast(return_date as varchar),'not returned' ) desc




