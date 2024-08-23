select * from album;
show databases;
use music_database;
select * from artist;
select * from customer;
select * from genre;
select * from invoice;
select * from invoice_line;
select * from track;


-- Q1:who is the senior most employee based on job role?

SELECT 
    *
FROM
    employee
ORDER BY levels DESC
LIMIT 1;

-- Q2: which countries have the most invoices?

SELECT 
    COUNT(*) AS c, billing_country
FROM
    invoice
GROUP BY billing_country
ORDER BY c DESC;

-- Q3: what are top 3 values of total invoices?

select
    total
FROM
    invoice
ORDER BY total DESC
LIMIT 3;

-- Q4: which city has the highest customers? we would like to throw a promotional music festival in the city.
-- we made the most money. write a query tha returns one city that has highest sum of invoice totals.
-- Return both the city name & sum of all invoice totals

select sum(total) as invoice_total, billing_city 
from invoice
group by billing_city
order by invoice_total desc limit 1;

-- Q5:Who is the best customer?The customer who has spent the most money will be declared the best customer. 
--  write a query that returns the person who has spent the most money.

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total 
from customer
join invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id 
order by total desc
limit 1;


-- Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email starting with A

select distinct email, first_name, last_name 
from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id IN(
	select track_id from track
	join genre on track.genre_id=genre.genre_id
	where genre.name like 'Rock'
) 
order by email;

-- Q7: Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total 
-- track count of the top 10 rock bands.

select artist.artist_id,artist.name,count(artist.artist_id) as number_of_songs
from track
join album on album.album_id=track.album_id
join artist on artist.artist_id=album.artist_id
join genre on genre.genre_id=track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc limit 10;

-- Q8: Return all the track names that have a song length longer than the average song length.
-- Return the name and milliseconds for each track order by the song length with the longest
-- songs listed first.

select name, milliseconds
from track 
where milliseconds> (
	select avg(milliseconds) as average_track_length
	from track)
order by milliseconds desc;

