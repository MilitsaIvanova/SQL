---case when
select
total_amount,
to_char(book_date, 'Dy'),
case
	when to_char(book_date,'Dy')='Mon' then 'Monday special'
	when total_amount < 30000 then 'Special deal'
	else 'no special at all'
end
from bookings

SELECT
count(*) as flights,
CASE
	when actual_departure is null then 'no departure time'
	when actual_departure-scheduled_departure < '00:05' then 'On time'
	when actual_departure-scheduled_departure < '01:00' then 'A little bit late'
	else 'Late'
end as is_late
from flights
group by is_late

--Challenge 1
--How many tickets you have sold in the categories low price, mid price and high price ticket.

select
count(*),
case
	when total_amount < 20000 then 'low price ticket'
	when total_amount < 150000 then 'mid price ticket'
	else 'high price ticket'
end as ticket_price
from bookings
group by ticket_price

--Challenge 2
-- How many flights have departed in each season
select 
count(*) as flights,
case
 	when extract(month from scheduled_departure) IN (12,1,2) then 'Winter'
	when extract(month from scheduled_departure) <=5 then 'Spring'
	when extract(month from scheduled_departure)<=8 then 'Summer'
	else 'Fall'
 end as seasons
from flights
group by seasons


--Coalesce
select
COALESCE(actual_arrival-scheduled_arrival, '0:00')
from flights

--Cast -change data type CAST(value/column AS data type)
SELECT
coalesce(cast(actual_arrival-scheduled_arrival as varchar),'not arrived' )
from flights

SELECT
cast(ticket_no as bigint)
from tickets

---REPLACE (flight_no, 'PG', '')
SELECT
cast(replace(passenger_id,' ','') as bigint)
from tickets

SELECT
flight_no,
cast(replace(flight_no, 'PG', '') as bigint)
from flights

