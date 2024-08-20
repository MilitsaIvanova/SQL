--OVER() with ORDER BY
--Return the running total of how late the flights are (diff between actual_arrival and scheduled arrival) ordered by flight_id including departure airport
select flight_id, departure_airport,
sum(actual_arrival-scheduled_arrival) over (ORDER BY flight_id)
from flights
--Calculate the same running total but partition also by the departure airport
select flight_id, departure_airport,
sum(actual_arrival-scheduled_arrival) over (PARTITION BY departure_airport ORDER BY flight_id)
from flights