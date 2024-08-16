---inner join challenge
---The airline company wants to understand in which category they sell most tickets in the categories Business, Economy or Comfort
---use tables seats, flights, boarding_passes
select s.fare_conditions as "Fare Conditions",
	count(*) as "Count"
from boarding_passes bp
inner join
	flights f on bp.flight_id = f.flight_id
inner join
	seats s on f.aircraft_code = s.aircraft_code and bp.seat_no = s.seat_no
group by
	s.fare_conditions
order by 2 desc

---full outer join
select *
from boarding_passes b
full outer join tickets t
on b.ticket_no = t.ticket_no
where b.ticket_no is null

--- left outer join
select * from aircrafts_data as a
left join flights f
on a.aircraft_code=f.aircraft_code

---find all aircrafts that have not been used in any flights
select * from aircrafts_data as a
left join flights f
on a.aircraft_code=f.aircraft_code
where f.flight_id is null

---which seat has been chosen most frequently. All seats must be included even if they have never been booked. Are there seats that have never been booked?
select s.seat_no,
count(*)
from seats s
left join boarding_passes b
on s.seat_no=b.seat_no
group by s.seat_no
order by count(*) desc

---Which line (A, B...,H) has been chosen most frequently
select right(s.seat_no,1),
count(*)
from seats s
left join boarding_passes b
on s.seat_no=b.seat_no
group by right(s.seat_no,1)
order by count(*) desc

---right outer join
select *
from flights f
right join aircrafts_data a
on a.aircraft_code = f.aircraft_code
where f.aircraft_code is null

---joins on multiple conditions
select seat_no, avg(amount)
from boarding_passes b
left join ticket_flights t
on b.ticket_no =t.ticket_no
and b.flight_id=t.flight_id
group by seat_no
order by 2 desc

---joining multiple tables
select t.ticket_no, tf.flight_id, scheduled_departure from tickets t
inner join ticket_flights tf
on t.ticket_no = tf.ticket_no
inner join flights f
on f.flight_id=tf.flight_id

---Which passenger (passenger_name) has spent most amount in their bookings (total_amount)?

---Answer: ALEKSANDR IVANOV with 80964000.
select t.passenger_name, sum(total_amount) from tickets t
left join bookings b
on t.book_ref = b.book_ref
group by t.passenger_name
order by sum(total_amount) desc

---Which fare_condition has ALEKSANDR IVANOV used the most?

---Answer: Economy 2131 times.
select count(*), fare_conditions, t.passenger_name from tickets t
inner join bookings b
on t.book_ref = b.book_ref
inner join ticket_flights tf
on t.ticket_no = tf.ticket_no
where t.passenger_name='ALEKSANDR IVANOV'
group by fare_conditions, passenger_name
order by 1 desc

