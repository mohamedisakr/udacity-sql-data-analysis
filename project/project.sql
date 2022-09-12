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
