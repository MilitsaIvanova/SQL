--Calculate the booking amount rollup for the hierarchy of quarter, month, week in month and day
SELECT
extract(quarter from book_date) as quarter,
extract(month from book_date) as month,
to_char(book_date,'w') as week_in_month,
date(book_date),
sum(total_amount)
from bookings
group by
ROLLUP(
	extract(quarter from book_date),
extract(month from book_date),
to_char(book_date,'w'),
date(book_date)
)
order by 1,2,3,4