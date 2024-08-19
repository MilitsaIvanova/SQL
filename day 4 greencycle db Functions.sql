--upper, lower, length functions
select 
upper(email) as email_upper,
lower(email) as email_lower,
email,
length(email)
from customer
where length(email)<30

--find names with either first_name or last_name > 10 chars. List the customers in lower case.
select
lower(first_name),
lower(last_name),
lower(email)
from customer
where length(first_name)>10 or length(last_name)>10 

--LEFT and RIGHT functions - extracting letters from left or right of the string
select
right(left(first_name,3),1),
first_name
from customer
--Extract the last 5 chars of the email address

select
right(email,5),
email
from customer
--How can you extract just the dot from the email address?

select
left(right(email,4),1) as dots,
email
from customer

--Concatenate
select
left(first_name,1) || '.' ||left(last_name,1)||'.' as initials,
first_name,
last_name
from customer

--Create a list of the anonymized version of the email addresses
--M***@sakilacustomer.org
select
left(email,1)||'***'||right(email,19) as anonymized_email,
email
from customer

--Position function
select
left(email,position('@' in email)-1),
email
from customer

select
left(email,position(last_name in email)-2),
email
from customer


--You have only the email and the last name of the customers. Extract the first name from the email and concatenate it with the last name in the form: "Last name, First name"

select
right(left(email, position('@' in email)-1),length(left(email, position('@' in email)-1))-position('.' in email))  ||', '||
left(email, position(last_name in email)-2)as full_name
from customer

select
last_name||', '||left(email,position('.' in email)-1),
last_name
from customer

--Substring function
select
substring (email from 1 for position('.' in email)-1),
substring(email from position('.' in email)+1 for position('@' in email)-position('.' in email)-1)
from customer

--Anonymized version of the email: M***.S***@sakilacustomer.org and ***Y.S***@sakilacustomer.org
select
left(email,1) || '***'
||substring(email from position('.' in email) for 2 ) ||'***'
|| substring(email from position('@' in email))
from customer

select
'***'
|| right(substring (email from 1 for position('.' in email)-1),1)
||'.'
||substring(email from position('.' in email)+1 for 1 )
||'***'
||substring(email from position('@' in email))
from customer

--Extract function

select
extract (month from rental_date),
count(*)
from rental
group by extract (month from rental_date)
order by count(*) desc

--payments table. What's the month with the highest total payment amount? What's the day of week with the highest total payment amount? What's the highest amount one customer has spent in a week?

select 
extract(month from payment_date)as month,
sum(amount) as payment_amount
from payment
group by month
order by sum(amount) desc

select 
extract(dow from payment_date) as day_of_week,
sum(amount) 
from payment
group by day_of_week
order by sum(amount) desc

select 
customer_id,
extract(week from payment_date) as week,
sum(amount) as total_payment
from payment
group by week, customer_id
order by sum(amount) desc

--TO_CHAR
select
*,
extract(month from payment_date),
TO_CHAR(payment_date, 'Day Month YYYY')
from payment

--sum payments and group in the following formats:
--Fri, 24/01/2020, May 2020, Thu, 02:44

select
sum(amount),
TO_CHAR(payment_date, 'Dy, DD/MM/YYYY')
from payment
GROUP by TO_CHAR(payment_date, 'Dy, DD/MM/YYYY')
order by sum(amount)

select
sum(amount),
TO_CHAR(payment_date, 'Mon, YYYY')
from payment
GROUP by TO_CHAR(payment_date, 'Mon, YYYY')
order by sum(amount)

select
sum(amount),
TO_CHAR(payment_date, 'Dy, HH:MI')
from payment
GROUP by TO_CHAR(payment_date, 'Dy, HH:MI')
order by sum(amount) desc

--Intervals and Timestamps
SELECT
current_timestamp,
current_timestamp-rental_date
from rental

SELECT
current_timestamp,
extract(day from return_date-rental_date)*24
+extract(hour from return_date-rental_date) || ' hours'
from rental

SELECT
current_timestamp,
to_char(return_date-rental_date, 'DD')
from rental

--Create a list for the support team of all rental durations of customer with customer_id= 35. Which customer has the longest avg rental duration?

select
return_date-rental_date,
customer_id
from rental
where customer_id=35

select
avg(return_date-rental_date),
customer_id
from rental
group by customer_id 
order by avg(return_date-rental_date) desc




