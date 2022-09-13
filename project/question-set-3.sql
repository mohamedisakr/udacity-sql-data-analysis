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
-- Though you could perform this with two queries. 
-- Imagine you wanted your query to update based on when new data is put in the database. 
-- Therefore, you do not want to hard code the average into your query. 
-- You only need the Track table to complete this query.

-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
/*
WITH average_song_length AS 
(
	SELECT SUM(milliseconds) / COUNT(trackid) AS avg_milli
	FROM track
)	

SELECT name track_name, milliseconds song_length
FROM track
WHERE milliseconds > (SELECT avg_milli FROM average_song_length)
ORDER BY milliseconds DESC
*/


-- Question 3
-- Write a query that determines the customer that has spent the most on music for each country. 
-- Write a query that returns the country along with the top customer and how much they spent. 
-- For countries where the top amount spent is shared, provide all customers who spent this amount.

-- You should only need to use the Customer and Invoice tables.
/*
SELECT c.country, SUM(i.total) total_spent, c.firstname, c.lastname, c.customerid
FROM customer c JOIN invoice i
	ON c.customerid = i.customerid --AND c.country = i.billingcountry
-- WHERE c.customerid = 47
GROUP BY 1, 3, 4, 5
ORDER BY 2 DESC
*/

-- other solution
/*
WITH tab1 AS 
( 
	SELECT c.CustomerId, c.FirstName, c.LastName, c.Country, SUM(i.Total) TotalSpent 
	FROM Customer c JOIN Invoice i ON c.CustomerId = i.CustomerId 
	GROUP BY c.CustomerId ) 
SELECT tab1.* 
FROM tab1 JOIN 
( SELECT CustomerId, FirstName, LastName, Country, MAX(TotalSpent) AS TotalSpent 
 FROM tab1 
 GROUP BY 1,2,3,4-- Country 
) tab2 
 ON tab1.Country = tab2.Country 
 WHERE tab1.TotalSpent = tab2.TotalSpent 
 ORDER BY Country
*/ 

