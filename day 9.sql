create table director(
director_id SERIAL PRIMARY key,
director_account_name VARCHAR(20) UNIQUE,
first_name VARCHAR(50),
last_name VARCHAR(50) DEFAULT 'Not specified',
date_of_birth date,
address_id INT REFERENCES address(address_id))

create table online_sales(
transaction_id SERIAL PRIMARY key,
customer_id INT REFERENCES customer(customer_id),
film_id INT REFERENCES film(film_id),
amount numeric(5,2) NOT NULL,
promotion_code VARCHAR(10) DEFAULT 'None')

insert into online_sales
(customer_id, film_id, amount, promotion_code)
values(124,65,14.99, 'PROMO2022'),  (225,231,12.99, 'JULYPROMO'),(119,53,15.99,'SUMMERDEAL')

alter table director
alter column director_account_name TYPE VARCHAR(30),
alter column last_name drop DEFAULT,
alter column last_name set not null,
add column if not exists email VARCHAR(40)

alter table director
rename column director_account_name to account_name

alter table director
rename to directors

SELECT * from directors

create table songs(
	song_id serial primary key,
	song_name VARCHAR(30) not null,
	genre VARCHAR(30) DEFAULT 'Not defined',
	price numeric(4,2) check (price>=1.99) ,
	release_date DATE constraint date_check check(release_date between '01-01-1950' and current_date)
)
select * from songs

alter table songs
drop constraint songs_price_check

alter table songs
add CONSTRAINT songs_price_check check(price>=0.99)

insert into songs
(song_id, song_name, price, release_date)
values(4, 'SQL song',0.99,'2022-01-07')