/*
SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema';
*/

-- SELECT * 
-- FROM public.Employee;

-- SELECT * 
-- FROM album

-- SELECT COUNT(name)
-- FROM Track
-- WHERE Composer = 'U2'

-- SELECT MAX(Total)
-- FROM Invoice
-- WHERE BillingCountry = 'Spain'

-- SELECT Title
-- FROM Employee
-- WHERE Lastname = 'Johnson'

/*---------------------------------------------------------------------
-- 05. SQL: Question Set 1
---------------------------------------------------------------------*/
-- Question 1: Which countries have the most Invoices?
-- Use the Invoice table to determine the countries that have the most invoices. 
-- Provide a table of BillingCountry and Invoices ordered by the number of invoices for each country. 
-- The country with the most invoices should appear first.
/*
SELECT billingcountry, COUNT(customerid) invoices_count
FROM Invoice 
GROUP BY 1
ORDER BY 2 DESC
*/


-- Question 2: Which city has the best customers?
-- We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns the 1 city that has the highest sum of invoice totals. 
-- Return both the city name and the sum of all invoice totals.
/*
SELECT billingcity, SUM(total) sum_all_totals
FROM Invoice 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
*/

-- Question 3: Who is the best customer?
-- The customer who has spent the most money will be declared the best customer. 
-- Build a query that returns the person who has spent the most money. 
-- I found the solution by linking the following three: Invoice, InvoiceLine, and Customer tables to 
-- retrieve this information, but you can probably do it with fewer!
/*
SELECT c.CustomerId, c.FirstName || ' ' || c.LastName AS Full_Name, SUM(Total) spent_most
FROM Customer c JOIN Invoice i
	ON c.customerid = i.customerid
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1
*/


-- SELECT customerid, COUNT(customerid)  -- invoiceid
-- FROM invoice
-- GROUP BY 1
-- ORDER BY 2 DESC


/*--------------------------------------------------------------
-------------- 06. SQL: Question Set 2 -------------------------
--------------------------------------------------------------*/

-- Question 1
-- Use your query to return the email, first name, last name, and Genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email address starting with A.
-- Rock Music ==> genreid = 1
/*
SELECT DISTINCT c.email, c.firstname, c.lastname, g.name
FROM customer c JOIN invoice i
	ON c.customerid = i.customerid
JOIN invoiceline il 
	ON i.invoiceid = il.invoiceid
JOIN track t 
	ON il.trackid = t.trackid
JOIN genre g 
	ON t.genreid = g.genreid
WHERE g.genreid = 1	
ORDER BY 1 ASC
*/


-- Question 2: Who is writing the rock music?
-- Now that we know that our customers love rock music, 
-- we can decide which musicians to invite to play at the concert.

-- Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

-- You will need to use the Genre, Track , Album, and Artist tables.
/*
SELECT a.artistid, a.name, COUNT(t.trackid)
FROM artist a JOIN album b
	ON a.artistid = b.artistid
JOIN track t
	ON t.albumid = b.albumid
JOIN genre g
	ON t.genreid = g.genreid
WHERE g.genreid = 1	
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10
*/

-- Question 3
-- First, find which artist has earned the most according to the InvoiceLines?

-- Now use this artist to find which customer spent the most on this artist.

-- Notice, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
-- so you need to use the InvoiceLine table to find out how many of each product was purchased, 
-- and then multiply this by the price for each artist.

-- For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, Album, and Artist tables.

/*
-- First, find which artist has earned the most according to the InvoiceLines?
SELECT a.artistid, a.name, SUM(il.unitprice * il.quantity) amount_spent
FROM artist a JOIN album b
	ON a.artistid = b.artistid
JOIN track t
	ON t.albumid = b.albumid
JOIN invoiceline il
	ON t.trackid = il.trackid
-- JOIN invoice i
-- 	ON il.invoiceid = i.invoiceid
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10
-- */

-- Now use this artist to find which customer spent the most on this artist.
/*
WITH most_earned_artist AS 
(
	SELECT a.artistid, a.name, SUM(il.unitprice * il.quantity) amount_spent
	FROM artist a JOIN album b
		ON a.artistid = b.artistid
	JOIN track t
		ON t.albumid = b.albumid
	JOIN invoiceline il
		ON t.trackid = il.trackid
	GROUP BY 1, 2
	ORDER BY 3 DESC
	LIMIT 1
)

SELECT DISTINCT cte.name, cte.amount_spent, c.customerid, c.firstname || ' ' || c.lastname AS full_name --, SUM(il.unitprice * il.quantity) amount_spent
FROM customer c JOIN invoice i
	ON c.customerid = i.customerid
JOIN invoiceline il 
	ON i.invoiceid = il.invoiceid
JOIN track t
	ON il.trackid = t.trackid
JOIN album b
	ON t.albumid = t.albumid
JOIN artist a
	ON b.artistid = a.artistid --AND b.artistid = cte.artistid
JOIN most_earned_artist cte 
	ON a.artistid = cte.artistid
GROUP BY 1, 2, 3, 4
ORDER BY 3 DESC
*/

-- SELECT artistid, name, amount_spent
-- FROM most_earned_artist

-- SELECT c.customerid, c.firstname || ' ' || c.lastname AS full_name , SUM(il.unitprice * il.quantity) amount_spent
-- FROM customer c JOIN invoice i
-- 	ON c.customerid = i.customerid
-- JOIN invoiceline il 
-- 	ON i.invoiceid = il.invoiceid
-- GROUP BY 1	
-- ORDER BY 3 DESC

-------------------------------------
------ other solution ---------------
-- https://github.com/kev1nch0e/Udacity-Business-Analytics/blob/master/Project%203:%20Query%20a%20Digital%20Music%20Store%20Database/SQL%20Queries/Query4.sql
-------------------------------------

WITH most_earned_artist AS 
(
	SELECT ar.ArtistId, ar.Name AS artist_name,  SUM(il.UnitPrice * il.Quantity) AS earned
	FROM artist ar JOIN Album al ON ar.ArtistId = al.ArtistId
	JOIN Track t				 ON al.AlbumId = t.AlbumId
	JOIN InvoiceLine il			 ON t.TrackId = il.TrackId
	GROUP BY 1, 2
	ORDER BY 3 DESC
	LIMIT 1
)

SELECT ar.ArtistId,  ar.Name AS artist_name,  g.Name AS genre_type,  SUM(il.UnitPrice * il.Quantity) AS earned
FROM Artist ar JOIN Album al	  		ON ar.ArtistId = al.ArtistId
				JOIN Track t	  		ON al.AlbumId = t.AlbumId
				JOIN Genre g			ON t.GenreId = g.GenreId
				JOIN InvoiceLine il		ON t.TrackId = il.TrackId
WHERE ar.Name = (SELECT  artist_name
				 FROM most_earned_artist)
GROUP BY 1, 2, 3
ORDER BY 4 DESC;

