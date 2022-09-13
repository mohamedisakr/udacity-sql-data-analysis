/*--------------------------------------------------------------
-------------- 07. (Advanced) SQL: Question Set 3 --------------
--------------------------------------------------------------*/

-- Question 1
-- We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. 
-- Write a query that returns each country along with the top Genre. 
-- For countries where the maximum number of purchases is shared return all Genres.
-- For this query, you will need to use the Invoice, InvoiceLine, Customer, Track, and Genre tables.
/*
SELECT COUNT(i.invoiceid) purchases, c.country, g.name genre_name, g.genreid
FROM customer c JOIN invoice i			ON c.customerid = i.customerid
				JOIN invoiceline il 	ON i.invoiceid = il.invoiceid
				JOIN track t 			ON il.trackid = t.trackid
				JOIN genre g 			ON t.genreid = g.genreid
GROUP BY 2, 3, 4 
ORDER BY 1 DESC
-- */

-- SELECT DISTINCT country FROM customer

-- other solution
/*
WITH t1 AS 
(
	SELECT
		COUNT(i.InvoiceId) Purchases, c.Country, g.Name, g.GenreId
	FROM Invoice i
		JOIN Customer c ON i.CustomerId = c.CustomerId
		JOIN InvoiceLine il ON il.Invoiceid = i.InvoiceId
		JOIN Track t ON t.TrackId = il.Trackid
		JOIN Genre g ON t.GenreId = g.GenreId
	GROUP BY 2, 3, 4 --c.Country, g.Name
	ORDER BY c.Country, Purchases DESC
)

SELECT t1.*
FROM t1
JOIN (
	SELECT MAX(Purchases) AS MaxPurchases, Country, Name, GenreId
	FROM t1
	GROUP BY 2, 3, 4  -- Country
	)t2
ON t1.Country = t2.Country
WHERE t1.Purchases = t2.MaxPurchases;
*/

-- Question 2: 
-- Return all the track names that have a song length longer than the average song length. 
-- Though you could perform this with two queries. Imagine you wanted your query to update based 
-- on when new data is put in the database. Therefore, you do not want to hard code the average into your query. 
-- You only need the Track table to complete this query.

-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
WITH average_song_length AS 
(
	SELECT SUM(milliseconds) / COUNT(trackid)
	FROM track
)	

SELECT name, milliseconds
FROM track
WHERE milliseconds > average_song_length
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

/*
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
*/
