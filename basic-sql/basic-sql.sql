-- select occurred_at, account_id, channel
-- from web_events
-- LIMIT 15

-- Write a query to return the 10 earliest orders in the orders table. 
-- Include the id, occurred_at, and total_amt_usd.
-- SELECT id,occurred_at,total_amt_usd
-- FROM orders
-- LIMIT 10;
-- SELECT id, occurred_at, total_amt_usd
-- FROM orders
-- ORDER BY occurred_at
-- LIMIT 10;

-- Write a query to return the top 5 orders in terms of largest total_amt_usd. 
-- Include the id, account_id, and total_amt_usd.
-- SELECT id, account_id, total_amt_usd
-- FROM orders
-- ORDER by total_amt_usd DESC
-- LIMIT 5;
-- SELECT id, account_id, total_amt_usd
-- FROM orders
-- ORDER BY total_amt_usd DESC 
-- LIMIT 5;


-- Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. 
-- Include the id, account_id, and total_amt_usd.
-- SELECT id, account_id, total_amt_usd
-- FROM orders
-- ORDER by total_amt_usd ASC
-- LIMIT 20;
-- 
-- SELECT id, account_id, total_amt_usd
-- FROM orders
-- ORDER BY total_amt_usd
-- LIMIT 20;


-- Write a query that displays the order ID, account ID, and total dollar amount for all the orders, 
-- sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).
-- SELECT id, account_id, total_amt_usd
-- FROM orders
-- ORDER BY account_id ASC, total_amt_usd DESC;

-- Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).
-- SELECT id, account_id, total_amt_usd
-- FROM orders
-- ORDER BY total_amt_usd DESC, account_id ASC;

-- Compare the results of these two queries above. How are the results different when you switch the column 
-- you sort on first?

-- Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.
-- SELECT * -- id, account_id, total_amt_usd
-- FROM orders
-- WHERE gloss_amt_usd >= 1000
-- LIMIT 5;

-- Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
-- SELECT * -- id, account_id, total_amt_usd
-- FROM orders
-- WHERE gloss_amt_usd < 500
-- LIMIT 10;

-- Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table.
-- SELECT NAME,website,primary_poc
-- FROM accounts
-- WHERE NAME = 'Exxon Mobil'
-- LIMIT 10;


-- SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
-- FROM orders
-- LIMIT 10;

-- Create a column that divides the standard_amt_usd by the standard_qty to find the unit price 
-- for standard paper for each order. Limit the results to the first 10 orders, and include the 
-- id and account_id fields.

-- SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
-- FROM orders
-- LIMIT 10;

-- Write a query that finds the percentage of revenue that comes from poster paper for each order. 
-- You will need to use only the columns that end with _usd. (Try to do this without using the total 
-- column.) Display the id and account_id fields also.

-- SELECT id, account_id,  COALESCE(poster_amt_usd/nullif(poster_qty,0),0)*100 AS std_percent -- (standard_amt_usd/standard_qty) AS unit_price
-- FROM orders
-- LIMIT 20;

-- SELECT id, account_id, poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
-- FROM orders
-- LIMIT 10;

-- Use the accounts table to find

-- All the companies whose names start with 'C'.
-- SELECT * 
-- FROM accounts
-- WHERE name LIKE 'C%'

-- All companies whose names contain the string 'one' somewhere in the name.
-- SELECT * 
-- FROM accounts
-- WHERE name LIKE '%one%'

-- All companies whose names end with 's'.
-- SELECT * 
-- FROM accounts
-- WHERE name LIKE '%s'

-- Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
-- SELECT name, primary_poc, sales_rep_id
-- FROM accounts
-- WHERE name IN ('Walmart', 'Target', 'Nordstrom');

-- Use the web_events table to find all information regarding individuals who were contacted via the channel of 
-- organic or adwords.
-- SELECT *
-- FROM web_events
-- WHERE channel IN ('organic', 'adwords');

-- Use the accounts table to find the account name, primary poc, and sales rep id for all stores 
-- except Walmart, Target, and Nordstrom.
-- SELECT name, primary_poc, sales_rep_id
-- FROM accounts
-- WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

-- Use the web_events table to find all information regarding individuals who were contacted via 
-- any method except using organic or adwords methods.
-- SELECT *
-- FROM web_events
-- WHERE channel NOT IN ('organic', 'adwords');

-- All the companies whose names do not start with 'C'.
-- SELECT * 
-- FROM accounts
-- WHERE name NOT LIKE 'C%'

-- All companies whose names do not contain the string 'one' somewhere in the name.
-- SELECT * 
-- FROM accounts
-- WHERE name NOT LIKE '%one%'

-- All companies whose names do not end with 's'.
-- SELECT * 
-- FROM accounts
-- WHERE name NOT LIKE '%s'

-- Write a query that returns all the orders where the standard_qty is over 1000, 
-- the poster_qty is 0, and the gloss_qty is 0.
-- SELECT * 
-- FROM orders
-- WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0

-- Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
-- SELECT * 
-- FROM accounts
-- WHERE name LIKE 'C%' AND name NOT LIKE  '%s'

-- When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? 
-- -- Figure out the answer to this important question by writing a query that displays the order date and 
-- gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see 
-- if the BETWEEN operator included the begin and end values or not.
-- SELECT occurred_at, gloss_qty
-- FROM orders
-- WHERE gloss_qty BETWEEN 24 AND 29
-- ORDER BY gloss_qty DESC

-- Use the web_events table to find all information regarding individuals who were contacted via the 
-- organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.
-- SELECT *
-- FROM web_events
-- WHERE channel IN ('organic', 'adwords') AND (occurred_at BETWEEN '2016-01-01' AND '2017-01-01')
-- ORDER BY occurred_at DESC;

-- Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. 
-- Only include the id field in the resulting table.
-- SELECT id as order_id
-- FROM orders
-- WHERE gloss_qty > 4000 OR poster_qty > 4000;


-- Write a query that returns a list of orders where the standard_qty is zero and either 
-- -- the gloss_qty or poster_qty is over 1000.
-- SELECT id as order_id
-- FROM orders
-- WHERE standard_qty = 0 AND (  gloss_qty > 1000 OR poster_qty > 1000 )


-- Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', 
-- but it doesn't contain 'eana'.
-- SELECT * 
-- FROM accounts
-- WHERE 
-- 	(name LIKE 'C%' OR name LIKE 'W%') 
-- 	AND 
-- 	((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND (primary_poc NOT LIKE '%eana%'))

-- SELECT orders.*
-- FROM orders
-- JOIN accounts ON orders.account_id = accounts.id;

-- SELECT acc.name, ord.occurred_at
-- FROM orders AS ord JOIN accounts AS acc
-- 	ON ord.account_id = acc.id
-- LIMIT 20;

-- SELECT *
-- FROM orders AS ord JOIN accounts AS acc
--  	ON ord.account_id = acc.id
-- LIMIT 20;

-- Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the 
-- website and the primary_poc from the accounts table.
-- SELECT acc.website, acc.primary_poc, ord.standard_qty, ord.gloss_qty, ord.poster_qty
-- FROM orders AS ord JOIN accounts AS acc
--  	ON ord.account_id = acc.id

-- Provide a table for all web_events associated with account name of Walmart. 
-- There should be three columns. 
-- Be sure to include the primary_poc, time of the event, and the channel for each event. 
-- Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
-- SELECT w.channel, w.occurred_at, a.name, a.primary_poc
-- FROM web_events AS w JOIN accounts AS a 
-- 	ON w.account_id = a.id
-- WHERE a.name = 'Walmart';
-- SELECT a.primary_poc, w.occurred_at, w.channel, a.name
-- FROM web_events w
-- JOIN accounts a
-- ON w.account_id = a.id
-- WHERE a.name = 'Walmart';


-- SELECT * 
-- FROM accounts
-- LIMIT 5

-- Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to account name.
-- the region name, the sales rep name, and the account name.
-- SELECT r.name AS RegionName, s.name AS SalesRepName, a.name AS AccountName
-- FROM sales_reps AS s JOIN region AS r
--    ON s.region_id = r.id
--  JOIN accounts AS a 
--    ON s.id = a.sales_rep_id;
-- SELECT r.name region, s.name rep, a.name account
-- FROM sales_reps s JOIN region r
-- 	ON s.region_id = r.id
-- JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- ORDER BY a.name;

-- Provide the name for each region for every order, as well as the account name and the 
-- unit price they paid (total_amt_usd/total) for the order. 
-- Your final table should have 3 columns: region name, account name, and unit price. 
-- A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
-- region name, account name, and unit price.
-- SELECT r.name, (o.total_amt_usd/(o.total+0.001)) AS unit_price, a.name
-- FROM sales_reps AS s JOIN region r
--    ON s.region_id = r.id
--  JOIN accounts a 
--    ON s.id = a.sales_rep_id
--  JOIN orders AS o 
--    ON o.account_id = a.id 
-- SELECT r.name region, a.name account, 
--        o.total_amt_usd/(o.total + 0.01) unit_price
-- FROM region r JOIN sales_reps s
-- 	ON s.region_id = r.id
-- JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- JOIN orders o
-- 	ON o.account_id = a.id;

-- 19. Quiz: Last Check
-------------------------

-- Q 1 : Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- This time only for the Midwest region. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to account name.
-- SELECT r.name region_name, s.name sales_rep_name, a.name account_name
-- FROM region r JOIN sales_reps s
-- 	ON s.region_id = r.id
-- JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- JOIN orders o
-- 	ON o.account_id = a.id
-- ORDER BY account_name;

-- Q 2 : Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to account name.

-- SELECT r.name region_name, s.name sales_rep_name, a.name account_name
-- FROM region r JOIN sales_reps s
-- 	ON s.region_id = r.id
-- JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- JOIN orders o
-- 	ON o.account_id = a.id
-- WHERE r.name = 'Midwest' AND split_part(s.name,' ', 1) LIKE 'S%'
-- ORDER BY account_name;

-- Q 3 : Provide a table that provides the region for each sales_rep along with their associated accounts. 
-- This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
-- Your final table should include three columns: the region name, the sales rep name, and the account name. 
-- Sort the accounts alphabetically (A-Z) according to account name.

-- SELECT r.name region_name, s.name sales_rep_name, a.name account_name
-- FROM region r JOIN sales_reps s
-- 	ON s.region_id = r.id
-- JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- JOIN orders o
-- 	ON o.account_id = a.id
-- WHERE r.name = 'Midwest' AND split_part(s.name,' ',2) LIKE 'K%' --AND last_name LIKE 'K%' -- s.name LIKE 'K%'
-- ORDER BY account_name;

-- Q 4 : Provide the name for each region for every order, as well as the account name and the 
-- unit price they paid (total_amt_usd/total) for the order. 
-- However, you should only provide the results if the standard order quantity exceeds 100. 
-- Your final table should have 3 columns: region name, account name, and unit price. 
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

-- SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.001) unit_price
-- FROM region r JOIN sales_reps s
-- 	ON s.region_id = r.id
-- JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- JOIN orders o
-- 	ON o.account_id = a.id
-- WHERE o.standard_qty > 100
-- ORDER BY unit_price DESC;

-- Q 5 : Provide the name for each region for every order, as well as the account name and the unit price 
-- they paid (total_amt_usd/total) for the order. However, you should only provide the results 
-- if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
-- Your final table should have 3 columns: region name, account name, and unit price. 
-- Sort for the smallest unit price first. 
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

-- SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.001) unit_price
-- FROM region r JOIN sales_reps s
-- 	ON s.region_id = r.id
-- JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- JOIN orders o
-- 	ON o.account_id = a.id
-- WHERE o.standard_qty > 100 AND poster_qty > 50
-- ORDER BY unit_price ASC;

-- Q 6 : Provide the name for each region for every order, as well as the account name and the unit price 
-- they paid (total_amt_usd/total) for the order. 
-- However, you should only provide the results if the standard order quantity exceeds 100 
-- and the poster order quantity exceeds 50. 
-- Your final table should have 3 columns: region name, account name, and unit price. 
-- Sort for the largest unit price first. 
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

-- SELECT r.name region, a.name account, ROUND(o.total_amt_usd/(o.total + 0.001), 2) unit_price
-- FROM region r JOIN sales_reps s
-- 	ON s.region_id = r.id
-- JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- JOIN orders o
-- 	ON o.account_id = a.id
-- WHERE o.standard_qty > 100 AND poster_qty > 50
-- ORDER BY unit_price DESC;

-- Q 7 : What are the different channels used by account id 1001? 
-- Your final table should have only 2 columns: account name and the different channels. 
-- You can try SELECT DISTINCT to narrow down the results to only the unique values.

-- SELECT DISTINCT w.channel, a.name
-- FROM web_events w JOIN accounts a
-- 	ON w.account_id = a.id
-- WHERE a.id = 1001;

-- Q 8 : Find all the orders that occurred in 2015. 
-- Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a JOIN orders o
	ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;




