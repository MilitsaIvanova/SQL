--Challenge
--This query has a very bad performance. Test indexes on different columns and compare their performance. Also considder an index on multiple columns.

--it takes 20 seconds to complete without any indexes
SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   )
DROP INDEX index_departure_airport
--15 seconds				   
 CREATE INDEX index_flight_no
 ON flights
 (flight_no)
 
--19 seconds
 CREATE INDEX index_departure_airport
 ON flights
 (departure_airport)
 
 --0.292 seconds
 CREATE INDEX index_multiple_columns
 ON flights
 (departure_airport, flight_no)