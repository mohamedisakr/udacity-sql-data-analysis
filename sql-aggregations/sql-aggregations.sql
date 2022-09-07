-- SELECT * 
-- FROM accounts
-- WHERE primary_poc IS NOT NULL -- WHERE id BETWEEN 1500 AND  1600 -- WHERE id > 1500 AND  id < 1600
-- -- LIMIT 5

-- SELECT COUNT(a.id)
-- FROM accounts a

-- SELECT COUNT(o.id) orders_count
-- FROM orders o

-- SELECT * -- COUNT(o.id) orders_count
-- FROM accounts a
-- WHERE primary_poc IS NULL

-- SELECT SUM(standard_qty) standard, SUM(gloss_qty) gloss, SUM(poster_qty) poster
-- FROM orders o

-- 07. Quiz: SUM
-- Q 1 : Find the total amount of poster_qty paper ordered in the orders table.
-- SELECT SUM(poster_qty) total_amount_ordered_poster
-- FROM orders o

-- Q 2 : Find the total amount of standard_qty paper ordered in the orders table.
-- SELECT SUM(standard_qty) total_amount_ordered_standard
-- FROM orders o

-- Q 3 : Find the total dollar amount of sales using the total_amt_usd in the orders table.
-- -- SELECT SUM(total_amt_usd) AS total_dollar_sales
-- FROM orders;

-- Q 4 : Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. 
-- This should give a dollar amount for each order in the table.
-- SELECT id, standard_amt_usd + gloss_amt_usd AS total_standard_gloss
-- FROM orders
-- -- LIMIT 5;


-- Q 5 : Find the standard_amt_usd per unit of standard_qty paper. 
-- Your solution should use both an aggregation and a mathematical operator.
-- SELECT  SUM(standard_amt_usd/(standard_qty+0.0001)) -- SUM() --id, standard_amt_usd + gloss_amt_usd AS total_standard_gloss
-- FROM orders
-- -- LIMIT 5;

-- SELECT ROUND(SUM(standard_amt_usd)/SUM(standard_qty), 2) AS standard_price_per_unit
-- FROM orders;

-- 11. Quiz: MIN, MAX, & AVG
-- Q 1 : When was the earliest order ever placed? You only need to return the date.
-- SELECT MIN(occurred_at) AS earliest_order
-- FROM orders
-- LIMIT 5;

-- Q 3 : When did the most recent (latest) web_event occur?
-- SELECT MAX(occurred_at)
-- FROM web_events
-- LIMIT 5;

-- Q 4 : Find the mean (AVERAGE) amount spent per order on each paper type, 
-- as well as the mean amount of each paper type purchased per order. 
-- Your final answer should have 6 values - one for each paper type for the average number of sales, 
-- as well as the average amount.
-- SELECT ROUND(AVG(standard_qty), 2) avg_standard_qty, ROUND(AVG(gloss_qty), 2) avg_gloss_qty, 
-- 		ROUND(AVG(poster_qty), 2) avg_poster_qty,		ROUND(AVG(standard_amt_usd), 2) avg_standard_amt_usd, 
-- 		ROUND(AVG(gloss_amt_usd), 2) avg_gloss_amt_usd, ROUND(AVG(poster_amt_usd), 2) avg_poster_amt_usd
-- FROM orders
-- -- LIMIT 5;

-- Q 5 Find the mean (AVERAGE) amount spent per order on each paper type, 
-- as well as the mean amount of each paper type purchased per order. 
-- Your final answer should have 6 values - one for each paper type for the average number of sales, 
-- as well as the average amount.
-- SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
--            AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
--            AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
-- FROM orders;

-- Q 6 Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced 
-- than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders? 
-- Note, this is more advanced than the topics we have covered thus far to build a general solution, 
-- but we can hard code a solution in the following way.
-- SELECT *
-- FROM (SELECT total_amt_usd
--       FROM orders
--       ORDER BY total_amt_usd
--       LIMIT 3457) AS Table1
-- ORDER BY total_amt_usd DESC
-- LIMIT 2;
-- SELECT * -- id, SUM(standard_qty) standard, SUM(gloss_qty) gloss, SUM(poster_qty) poster
-- FROM orders 
-- LIMIT 5


-- SELECT id, SUM(standard_qty) standard, SUM(gloss_qty) gloss, SUM(poster_qty) poster
-- FROM orders 
-- GROUP BY id
-- ORDER BY id;

-- 14. Quiz: GROUP BY

-- Q 1 Which account (by name) placed the earliest order? 
-- Your solution should have the account name and the date of the order.
-- SELECT a.name , o.occurred_at earliest_order
-- FROM orders o JOIN accounts a 
-- 	ON o.account_id = a.id
-- ORDER BY o.occurred_at ASC 
-- LIMIT 1;

-- SELECT a.name, o.occurred_at
-- FROM accounts a JOIN orders o
-- 	ON a.id = o.account_id
-- ORDER BY occurred_at
-- LIMIT 1;

-- Q 2 Find the total sales in usd for each account. 
-- You should include two columns - the total sales for each company's orders in usd and the company name. 
-- SELECT a.name , SUM(o.total_amt_usd) total_sales
-- FROM orders o JOIN accounts a 
-- 	ON o.account_id = a.id
-- GROUP BY a.name
-- ORDER BY a.name

-- SELECT a.name, SUM(total_amt_usd) total_sales
-- FROM orders o JOIN accounts a
-- 	ON a.id = o.account_id
-- GROUP BY a.name;

-- Q 3 Via what channel did the most recent (latest) web_event occur, 
-- which account was associated with this web_event? 
-- Your query should return only three values - the date, channel, and account name.
-- SELECT w.occurred_at, w.channel, a.name
-- FROM web_events w JOIN accounts a 
-- 	ON w.account_id = a.id
-- ORDER BY w.occurred_at DESC
-- LIMIT 1

-- SELECT w.occurred_at, w.channel, a.name
-- FROM web_events w JOIN accounts a
-- 	ON w.account_id = a.id 
-- ORDER BY w.occurred_at DESC
-- LIMIT 1;

-- Q 4 Find the total number of times each type of channel from the web_events was used. 
-- Your final table should have two columns - the channel and the number of times the channel was used.
-- SELECT channel, COUNT(channel) times_used -- w.occurred_at, w.channel
-- FROM web_events w
-- GROUP BY channel
-- ORDER BY times_used DESC

-- SELECT w.channel, COUNT(*)
-- FROM web_events w
-- GROUP BY w.channel

-- Q 5 Who was the primary contact associated with the earliest web_event?
-- "direct"	5298

-- SELECT a.primary_poc
-- FROM web_events w JOIN accounts a
-- 	ON a.id = w.account_id
-- ORDER BY w.occurred_at
-- LIMIT 1;

-- Q 6 What was the smallest order placed by each account in terms of total usd. 
-- Provide only two columns - the account name and the total usd. 
-- Order from smallest dollar amounts to largest.
-- SELECT a.name , MIN(o.total_amt_usd) smallest_order_placed
-- FROM orders o JOIN accounts a 
--  	ON o.account_id = a.id
-- GROUP BY a.name
-- ORDER BY smallest_order_placed ASC

-- SELECT a.name, MIN(total_amt_usd) smallest_order
-- FROM accounts a JOIN orders o
-- 	ON a.id = o.account_id
-- GROUP BY a.name
-- ORDER BY smallest_order;

-- Q 7 Find the number of sales reps in each region. Your final table should have two columns - 
-- the region and the number of sales_reps. Order from fewest reps to most reps.
-- SELECT r.name, COUNT(s.name) num_sales_reps
-- FROM region r JOIN sales_reps s
-- 	ON r.id = s.region_id
-- GROUP BY r.name 
-- ORDER BY num_sales_reps ASC

-- SELECT r.name, COUNT(*) num_reps
-- FROM region r JOIN sales_reps s
-- 	ON r.id = s.region_id
-- GROUP BY r.name
-- ORDER BY num_reps;

-- 17. Quiz: GROUP BY Part II

-- Q 1 : For each account, determine the average amount of each type of paper they purchased 
-- across their orders. Your result should have 4 columns - 
-- one for the account name and one for the average quantity purchased for each of the paper 
-- types for each account.
-- SELECT a.name, ROUND(AVG(standard_qty), 2) avg_standard, ROUND(AVG(gloss_qty), 2) avg_gloss, 
-- 		ROUND(AVG(poster_qty), 2) avg_poster
-- FROM accounts a JOIN orders o
-- 	ON a.id = o.account_id
-- GROUP BY a.name
-- ORDER BY a.name;

-- Q 2 : For each account, determine the average amount spent per order on each paper type. 
-- Your result should have four columns - 
-- one for the account name and one for the average amount spent on each paper type.
-- SELECT a.name, ROUND(AVG(standard_amt_usd), 2) avg_standard_amt_usd, 
-- 				ROUND(AVG(gloss_amt_usd), 2) avg_gloss_amt_usd,
-- 				ROUND(AVG(poster_amt_usd), 2) avg_poster_amt_usd
-- FROM accounts a JOIN orders o
-- 	ON a.id = o.account_id
-- GROUP BY a.name
-- ORDER BY a.name;

-- Q 3 : Determine the number of times a particular channel was used in the web_events table 
-- for each sales rep. 
-- Your final table should have 3 columns - 
-- the name of the sales rep, the channel, and the number of occurrences. 
-- Order your table with the highest number of occurrences first.

-- SELECT a.name, w.channel, COUNT(w.channel) num_occurrences
-- FROM web_events w JOIN accounts a
-- 	ON w.account_id = a.id 
-- GROUP BY a.name, w.channel
-- ORDER BY num_occurrences DESC;

-- SELECT s.name, w.channel, COUNT(*) num_events
-- FROM accounts a JOIN web_events w
-- 	ON a.id = w.account_id
-- JOIN sales_reps s
-- 	ON s.id = a.sales_rep_id
-- GROUP BY s.name, w.channel
-- ORDER BY num_events DESC;

-- Q 4 : Determine the number of times a particular channel was used in the web_events table for each region. 
-- Your final table should have three columns - 
-- the region name, the channel, and the number of occurrences. 
-- Order your table with the highest number of occurrences first.

-- SELECT r.name region_name, w.channel, COUNT(*) num_events
-- FROM accounts a JOIN web_events w
-- 	ON a.id = w.account_id
-- JOIN sales_reps s
-- 	ON s.id = a.sales_rep_id
-- JOIN region r 
-- 	ON s.region_id = r.id
-- GROUP BY r.name, w.channel
-- ORDER BY num_events DESC;

-- 20. Quiz: DISTINCT

-- Q 1 : Use DISTINCT to test if there are any accounts associated with more than one region.
-- SELECT DISTINCT r.name region_name, a.name account_name
-- FROM accounts a JOIN sales_reps s
-- 	ON s.id = a.sales_rep_id
-- JOIN region r 
-- 	ON s.region_id = r.id
-- -- GROUP BY r.name, w.channel
-- ORDER BY region_name DESC;

-- SELECT DISTINCT id, name
-- FROM accounts;

-- Q 2 : Have any sales reps worked on more than one account?
-- SELECT DISTINCT id, name
-- FROM sales_reps;

-- SELECT account_id, SUM(total_amt_usd) sum_total_amt_usd
-- FROM orders
-- GROUP BY 1
-- HAVING SUM(total_amt_usd) >= 250000
-- ORDER BY 2 DESC;

---------------------------------------
-- HAVING Questions
---------------------------------------

-- Q 1 : How many of the sales reps have more than 5 accounts that they manage?
-- SELECT s.name sales_rep_name, COUNT(a.id) num_accounts
-- FROM accounts a JOIN sales_reps s
-- 	ON s.id = a.sales_rep_id
-- GROUP BY sales_rep_name	
-- HAVING COUNT(a.id) > 5
-- ORDER BY num_accounts DESC

-- Q 2 : How many accounts have more than 20 orders?
-- SELECT a.id, a.name, COUNT(o.id) num_orders
-- FROM orders o JOIN accounts a 
-- 	ON o.account_id = a.id
-- GROUP BY a.id, a.name
-- HAVING COUNT(o.id) > 20
-- ORDER BY num_orders DESC 

-- Q 3 : Which account has the most orders?
-- SELECT a.id, a.name, COUNT(o.id) num_orders
-- FROM orders o JOIN accounts a 
-- 	ON o.account_id = a.id
-- GROUP BY a.id, a.name
-- ORDER BY num_orders DESC 
-- LIMIT 1

-- Q 4 : Which accounts spent more than 30,000 usd total across all orders?
-- SELECT a.id, a.name, SUM(o.total_amt_usd) more_30k_total_amt_usd
-- FROM orders o JOIN accounts a 
-- 	ON o.account_id = a.id
-- GROUP BY a.id, a.name
-- HAVING sum(o.total_amt_usd) > 30000
-- ORDER BY more_30k_total_amt_usd DESC 


-- Q 5 : Which accounts spent less than 1,000 usd total across all orders?
-- SELECT a.id, a.name, SUM(o.total_amt_usd) less_1k_total_amt_usd
-- FROM orders o JOIN accounts a 
-- 	ON o.account_id = a.id
-- GROUP BY a.id, a.name
-- HAVING sum(o.total_amt_usd) < 1000
-- ORDER BY less_1k_total_amt_usd DESC 

-- Q 6 Which account has spent the most with us?
-- SELECT a.id, a.name, SUM(o.total_amt_usd) most_spent
-- FROM orders o JOIN accounts a 
-- 	ON o.account_id = a.id
-- GROUP BY a.id, a.name
-- ORDER BY most_spent DESC 
-- LIMIT 1;

-- Q 7 : Which account has spent the least with us?
-- SELECT a.id, a.name, SUM(o.total_amt_usd) least_spent
-- FROM orders o JOIN accounts a 
-- 	ON o.account_id = a.id
-- GROUP BY a.id, a.name
-- ORDER BY least_spent ASC 
-- LIMIT 1;


-- Q 8 Which accounts used facebook as a channel to contact customers more than 6 times?
-- SELECT a.id, a.name, COUNT(w.channel) facebook_more 
-- FROM web_events w JOIN accounts a 
-- 	ON w.account_id = a.id
-- GROUP BY a.id, a.name, w.channel
-- HAVING COUNT(w.channel) > 6 AND w.channel = 'facebook'
-- ORDER BY facebook_more;-- DESC

-- Q 9 : Which account used facebook most as a channel?
-- SELECT a.id, a.name, COUNT(w.channel) facebook_more 
-- FROM web_events w JOIN accounts a 
-- 	ON w.account_id = a.id
-- WHERE w.channel = 'facebook'
-- GROUP BY a.id, a.name, w.channel
-- ORDER BY facebook_more DESC
-- LIMIT 1;

-- Q 10 : Which channel was most frequently used by most accounts
-- SELECT a.id, a.name, w.channel, COUNT(w.channel) use_of_channel 
-- FROM web_events w JOIN accounts a 
-- 	ON w.account_id = a.id
-- GROUP BY a.id, a.name, w.channel
-- ORDER BY use_of_channel DESC
-- LIMIT 10;

---------------------------------------
-- 27. Quiz: DATE Functions
---------------------------------------

-- Q 1 : Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
-- Do you notice any trends in the yearly sales totals?
-- SELECT DATE_PART('year', occurred_at) order_year, SUM(total_amt_usd) sales_total
-- FROM orders
-- GROUP BY 1
-- ORDER BY 2 DESC

-- Q 2 : 
-- Which month did Parch & Posey have the greatest sales in terms of total dollars? 
-- Are all months evenly represented by the dataset?
-- SELECT DATE_PART('month', occurred_at) order_month, SUM(total_amt_usd) sales_total
-- FROM orders
-- GROUP BY 1
-- ORDER BY 2 DESC

-- SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
-- FROM orders
-- WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
-- GROUP BY 1
-- ORDER BY 2 DESC; 

-- Q 3 : Which year did Parch & Posey have the greatest sales in terms of total number of orders? 
-- Are all years evenly represented by the dataset?
-- SELECT DATE_PART('year', occurred_at) order_year, Count(id) total_orders
-- FROM orders
-- GROUP BY 1
-- ORDER BY 2 DESC

-- Q 4 : Which month did Parch & Posey have the greatest sales in terms of total number of orders? 
-- Are all months evenly represented by the dataset?
-- SELECT DATE_PART('month', occurred_at) order_month, Count(id) total_orders
-- FROM orders
-- WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
-- GROUP BY 1
-- ORDER BY 2 DESC

-- Q 5 : In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT DATE_PART('month', occurred_at) gloss_month, DATE_PART('year', occurred_at) gloss_year, 
		SUM(o.gloss_amt_usd) total_gloss_amt 
FROM orders o JOIN accounts a 
	ON o.account_id = a.id
WHERE a.name = 'Walmart'	
GROUP BY 1, 2  -- DATE_PART('month', occurred_at), gloss_month, DATE_PART('year', occurred_at)
ORDER BY 3 DESC -- total_gloss_amt DESC
LIMIT 1







