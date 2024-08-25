--CTE

--without CTE
SELECT film_id, title, rental_duration
FROM (
	SELECT 
	f.film_id,
	f.title,
	avg(r.return_date-r.rental_date) as rental_duration
	FROM film f
	JOIN inventory i ON f.film_id=i.inventory_id
	join rental r on i.inventory_id=r.inventory_id
	GROUP BY f.film_id, f.title
) AS film_durations
WHERE rental_duration>(
	select avg(rental_duration)
	from(
	SELECT AVG(r.return_date-r.rental_date) as rental_duration
	FROM film f
	JOIN inventory i ON f.film_id=i.inventory_id
	join rental r on i.inventory_id=r.inventory_id
	GROUP BY f.film_id, f.title
	
) AS subquery
);
-- with CTE
WITH rental_duration_cte AS
(SELECT 
	f.film_id,
	f.title,
	avg(r.return_date-r.rental_date) as rental_duration
	FROM film f
	JOIN inventory i ON f.film_id=i.inventory_id
	join rental r on i.inventory_id=r.inventory_id
	GROUP BY f.film_id, f.title)
	
SELECT film_id, title, rental_duration
FROM rental_duration_cte
WHERE rental_duration>(
	select avg(rental_duration)
	from rental_duration_cte)

--Challenge
--Objective: Calculate the total rental count and total rental amount for each customer, and list customers who have rented more than the average number of films.
--In the DVD rental business, we need to understand customer behavior by calculating how many movies each customer has rented and how much they have spent. We will then identify customers who rent movies more frequently than the average customer.
select * from customer
select * from rental
select * from payment

WITH total_amount_cte AS
(select rental.customer_id,count(*),sum(payment.amount)
 from rental
 left join payment
 on rental.customer_id=payment.customer_id
 group by rental.customer_id
)

select customer_id, count, sum
from total_amount_cte
where count>(
select avg(count) 
	from total_amount_cte
)

--multiple CTEs
--Identify customer who have spent more than the avg amount on rentals and list the films they have rented

--CTE for calculating total spending per customer
with customer_spending as(
select c.customer_id, c.first_name, c.last_name, sum(p.amount) as total_spent
	from customer c
	join payment p on c.customer_id=p.customer_id
	group by c.customer_id,c.first_name, c.last_name
),

--define the CTE for finding high-spending customers
high_spending_customers as(
	select cs.customer_id, cs.first_name, cs.last_name, cs.total_spent
	from customer_spending cs
	where cs.total_spent>(select avg(total_spent) from customer_spending)
)

--Use the CTEs to find films rented by high-spending customers
SELECT
hsc.customer_id, hsc.first_name, hsc.last_name, hsc.total_spent, f.film_id, f.title
from high_spending_customers hsc
join rental r on hsc.customer_id=r.customer_id
join inventory i on i.inventory_id=r.inventory_id
join film f on i.film_id=f.film_id;

--Challenge 2
--Objective: Calculate the total rental count and total rental amount for each customer, identify customers who have rented more than the average number of films, and list the details of the films they have rented.
--Context: In the DVD rental business, we need to understand customer behavior by calculating how many movies each customer has rented and how much they have spent. We will then identify customers who rent movies more frequently than the average customer and list the details of the films they have rented.

--Note: High-Rental Customers: Customers who have rented more than the average number of films.

-- Step 1: Create a CTE to calculate the total rental count and total rental amount for each customer
 
WITH customer_totals AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           COUNT(r.rental_id) AS rental_count,
           SUM(p.amount) AS total_amount
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON c.customer_id = p.customer_id AND p.rental_id = r.rental_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
 
-- Step 2: Calculate the average rental count across all customers
 
average_rental_count AS (
    SELECT AVG(rental_count) AS avg_rental_count
    FROM customer_totals
)
,
 
-- Step 3: Identify customers who have rented more than the average number of films (high-rental customers)
 
high_rental_customers AS (
    SELECT ct.customer_id, ct.first_name, ct.last_name, ct.rental_count, ct.total_amount
    FROM customer_totals ct
    JOIN average_rental_count arc ON ct.rental_count > arc.avg_rental_count
)
 
-- Step 4: List the details of the films rented by these high-rental customers
 
SELECT hrc.customer_id, hrc.first_name, hrc.last_name, hrc.rental_count, hrc.total_amount, f.film_id, f.title
FROM high_rental_customers hrc
JOIN rental r ON hrc.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;

--Recursive CTEs
--Challenge
--Objective: Create an employee hierarchy table and use a recursive CTE to find all subordinates of a given employee.
--Context: In a company, employees are managed in a hierarchical structure where each employee may have a manager. We need to find all subordinates of a particular manager, regardless of how many levels down they are in the hierarchy.
--Step 1: Create the employee table with hierarchical relationships.
CREATE TABLE IF NOT EXISTS employee_new (
    employee_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    manager_id INTEGER REFERENCES employee_new(employee_id)
);

-- Insert sample data to establish an employee hierarchy
INSERT INTO employee_new (employee_id, name, manager_id) VALUES
(1, 'Alice', NULL),       -- Alice is the CEO, no manager
(2, 'Bob', 1),            -- Bob reports to Alice
(3, 'Charlie', 1),        -- Charlie reports to Alice
(4, 'David', 2),          -- David reports to Bob
(5, 'Eve', 2),            -- Eve reports to Bob
(6, 'Frank', 3);          -- Frank reports to Charlie

--Use a recursive CTE to find all subordinates of a given employee.
--Step 1: Use a recursive CTE to find all subordinates of a given employee.
WITH RECURSIVE subordinate_tree AS (
    -- Anchor member: Select the given employee with level 1
    SELECT e.employee_id, e.name, e.manager_id, 1 AS level
    FROM employee_new e
    WHERE e.employee_id = 1  -- Start with the given employee (Alice)
    
    UNION ALL
    
    -- Recursive member: Select subordinates of the current set of employees and increment the level
    SELECT e.employee_id, e.name, e.manager_id, st.level + 1 AS level
    FROM employee_new e
    INNER JOIN subordinate_tree st ON e.manager_id = st.employee_id
)
 
-- Step 2: Select all subordinates from the recursive CTE
SELECT employee_id, name, manager_id, level
FROM subordinate_tree;
