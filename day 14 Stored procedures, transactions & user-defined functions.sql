--Day 14 Stored procedures, transactions and user-defined functions

--User-defined functions
CREATE FUNCTION count_rr(min_r decimal(4,2),max_r decimal(4,2))
RETURNS INT
LANGUAGE plpgsql
AS
$$
DECLARE 
movie_count INT;
BEGIN
SELECT COUNT(*)
INTO movie_count
FROM film
WHERE rental_rate BETWEEN min_r AND max_r;
RETURN movie_count;
END;
$$

SELECT count_rr(3,6)

--Create a function which expects the customer's first and last name and returns the total amount of payments this customer has made
CREATE OR REPLACE FUNCTION name_search(f_name TEXT,l_name TEXT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
total_amount numeric;
BEGIN
select sum(amount) 
INTO total_amount 
from payment
left join customer
on customer.customer_id=payment.customer_id
where first_name=f_name and last_name=l_name;
return total_amount;
END;
$$

SELECT name_search('AMY','LOPEZ')

--transactions

CREATE TABLE acc_balance (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
    amount DEC(9,2) NOT NULL    
);

INSERT INTO acc_balance
VALUES 
(1,'Tim','Brown',2500),
(2,'Sandra','Miller',1600)

SELECT * FROM acc_balance;

BEGIN;
UPDATE acc_balance
SET amount=amount-100
where id=1;
UPDATE acc_balance
SET amount=amount+100
where id=2;
COMMIT;

--swap the positions and salaries of Miller McQuarter and Christalle McKenny
BEGIN;
UPDATE employees
SET position_title='Head of Sales'
where emp_id=2;
UPDATE employees
SET position_title='Head of BI'
where emp_id=3;
UPDATE employees
SET salary=12587.00
where emp_id=2;
UPDATE employees
SET salary=14614.00
where emp_id=3;
COMMIT;

select * from employees

--ROLLBACK
BEGIN;
UPDATE acc_balance
SET amount=amount-100
where id=1;
SAVEPOINT op2;
ROLLBACK to SAVEPOINT op2;
ROLLBACK;

COMMIT;

select * from acc_balance

--STORED PROCEDURES
create or replace PROCEDURE sp_transfer(tr_amount INT, sender INT, recipient INT)
LANGUAGE plpgsql
AS
$$
begin
--subtract from sender's balance
update acc_balance
set amount=amount-tr_amount
where id=sender;

--add to recipient's balance
update acc_balance
set amount=amount+tr_amount
where id=recipient;

commit;

end;
$$

CALL sp_transfer(100,1,2)

select * from acc_balance

--Create a stored procedure called emp_swap that accepts two param emp1 and emp2 and swaps the two employees' position and salary.
create or replace PROCEDURE emp_swap(emp1 INT, emp2 INT)
LANGUAGE plpgsql
AS
$$
DECLARE
emp1_position TEXT; 
emp2_position TEXT;
emp1_salary decimal(8,2);
emp2_salary decimal(8,2);
begin
--save values in variables
select position_title 
into emp1_position 
from employees where emp_id=emp1;

select position_title 
into emp2_position 
from employees where emp_id=emp2;

select salary
into emp1_salary
from employees where emp_id=emp1;

select salary
into emp2_salary
from employees where emp_id=emp2;

--swap values
update employees
set position_title=emp2_position
where emp_id=emp1;

update employees
set position_title=emp1_position
where emp_id=emp2;

update employees
set salary=emp2_salary
where emp_id=emp1;

update employees
set salary=emp1_salary
where emp_id=emp2;

commit;

end;
$$

select * from employees
order by emp_id

CALL emp_swap(1,2)
