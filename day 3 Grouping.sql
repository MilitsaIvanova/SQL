--Day 3
SELECT
ROUND(avg(amount),2) as average,
sum(amount)
from payment

--Min, Max, Avg (rounden,2), Sum of the replacement cost of the films

select 
MIN(replacement_cost),
MAX(replacement_cost),
ROUND(avg(replacement_cost),2) as AVG,
SUM(replacement_cost)
from film

--Group by
SELECT
customer_id,
sum(amount)
from payment
where customer_id>3
group by customer_id
order by sum(amount) desc

--Which of the two employees (staff_id) is responsible for more payments? Which of the two is responsible for a higher overall payment amount? How do these amounts change if we don't consider amounts equal to 0?

select 
staff_id,
count(*),
sum(amount) as payment_amount
from payment
where amount != 0
group by staff_id
--staff_id = 1 has more payments
--staff 2 has a higher payment amount
-- when considered the non null amounts staff 1 still has more payments

--Group by multiple columns
-- Which employee had the highest sales amount in a single day? Which employee had the most sales in a single day (not counting payments with amount =0)?

SELECT
staff_id,
date(payment_date),
sum(amount),
count(*)
from payment
where amount != 0
group by staff_id,date(payment_date)
order by sum(amount) desc

--Having

SELECT
staff_id,
date(payment_date),
sum(amount),
count(*)
from payment
where amount != 0
group by staff_id,date(payment_date)
having count(*) >200
order by sum(amount) desc

----Focus on the days 2020-04-28, 2020-04-29,2020-04-30. What is the avg payment amount grouped by customer and day with more than 1 payment (per customer and day). Order by avg amount in a desc order

select
customer_id,
date(payment_date),
round(avg(amount),2) as avg_amount,
count(*)
from payment
where date(payment_date) in ('2020-04-28', '2020-04-29','2020-04-30')
group by customer_id, date(payment_date)
having count(*)>1
order by avg_amount desc







