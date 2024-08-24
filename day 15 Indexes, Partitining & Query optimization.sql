--Day 15 Indexes, Partitining & Query optimization
CREATE USER sarah
with PASSWORD 'sarah1234';

create role alex
with login PASSWORD 'alex1234';


--CREATE users

CREATE USER ria
WITH PASSWORD 'ria123'

CREATE USER mike
WITH PASSWORD 'mike123'

--Create roles
CREATE ROLE read_only;
CREATE ROLE read_update;

--Grant usage (already granted)
GRANT USAGE
ON SCHEMA public
TO read_only

--Grant SELECT on tables
GRANT SELECT 
ON ALL TABLES IN SCHEMA public
TO read_only;
--
GRANT read_only to mike

--Assign read_only to read_update role
GRANT read_only
TO read_update

--Grant all privileges on all tables in public to role
GRANT ALL
ON ALL TABLES IN SCHEMA public
TO read_update

--Revoke some privileges
REVOKE DELETE,INSERT
ON ALL TABLES IN SCHEMA public
FROM read_update

--Assign role to users
GRANT read_update
TO ria

--DROP roles
DROP ROLE mike;

--can't be droped because some objects depend on it
DROP ROLE read_update;

--Removing dependencies
DROP OWNED BY read_update;
DROP ROLE read_update;


--In this challenge you need to create a user, a role and add privileges.

--Your tasks are the following:

--Create the user mia with password 'mia123'
CREATE USER mia
WITH PASSWORD 'mia123'
--Create  the role analyst_emp;
CREATE ROLE analyst_emp

--Grant SELECT on all tables in the public schema to that role.
GRANT SELECT 
ON ALL TABLES
IN SCHEMA public
TO analyst_emp

--Grant INSERT and UPDATE on the employees table to that role.
GRANT INSERT, UPDATE
ON employees
TO analyst_emp

--Add the permission to create databases to that role.
ALTER ROLE analyst_emp CREATEDB

--Assign that role to mia and test the privileges with that user.
GRANT analyst_emp TO mia

--Indexes
--16 secs for this query to complete without the index
SELECT 
(select avg(amount) from payment p2
 where p2.rental_id=p1.rental_id)
 FROM payment p1
 
 --less than a second with the index
 CREATE INDEX index_rental_id_payment
 ON payment
 (rental_id)
 
 DROP INDEX index_rental_id_payment
 
