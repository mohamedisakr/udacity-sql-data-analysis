-- SELECT channel , AVG(event_count) avg_event_count
-- FROM 
-- 	(SELECT DATE_TRUNC('day', occurred_at) AS day, channel, COUNT(channel) event_count
-- 	 FROM web_events
-- 	 GROUP BY 1, 2
-- 	) sub
-- GROUP BY 1
-- ORDER BY 2 DESC

-- SELECT channel, day, AVG(event_count) avg_event_count
-- FROM 
-- 	(SELECT DATE_TRUNC('day', occurred_at) AS day, channel, COUNT(channel) event_count
-- 	 FROM web_events
-- 	 GROUP BY 1, 2
-- 	) sub
-- GROUP BY 1, 2
-- ORDER BY 3 DESC

---------------------------------
-- 07. Quiz: More On Subqueries
---------------------------------

-- find only the orders that took place in the same month and year as the first order, 
-- and then pull the average for each type of paper qty in this month.
-- SELECT DATE_TRUNC('month', occurred_at) month_order, DATE_TRUNC('year', occurred_at) year_order, 
-- 		ROUND(AVG(standard_qty), 2) avg_standard, ROUND(AVG(gloss_qty), 2) avg_gloss, 
-- 		ROUND(AVG(poster_qty), 2) avg_poster
-- FROM orders
-- WHERE DATE_TRUNC('month', occurred_at) = (
-- 	SELECT DATE_TRUNC('month', MIN(occurred_at)) AS min_month
-- 	FROM orders
-- )
-- GROUP BY occurred_at, DATE_TRUNC('month', occurred_at) -- occurred_at
-- -- ORDER BY avg_standard DESC, avg_gloss DESC, avg_poster DESC

-- SELECT AVG(standard_qty) avg_standard, AVG(gloss_qty) avg_gloss, AVG(poster_qty) avg_poster
-- FROM orders
-- WHERE DATE_TRUNC('month', occurred_at) = 
--      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

-- SELECT SUM(total_amt_usd)
-- FROM orders
-- WHERE DATE_TRUNC('month', occurred_at) = 
--       (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

-- SELECT * 
-- FROM
-- 	(SELECT SUM(total_amt_usd)
-- 	 FROM orders
-- 	 WHERE DATE_TRUNC('month', occurred_at) = 
-- 		  (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders)) sub


-----------------------------------------
-- Quiz: Subquery Mania
-----------------------------------------

-- Q 1 : Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
-- SELECT region_name, MAX(total_amt) max_total_amt
-- FROM (	SELECT s.name sales_rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
-- 	FROM sales_reps s JOIN region r
-- 		ON s.region_id = r.id
-- 	JOIN accounts a 
-- 		ON a.sales_rep_id = s.id
-- 	JOIN orders o 
-- 		ON o.account_id = a.id
-- 	GROUP BY 1, 2) sub --s.name, r.name
-- -- 	ORDER BY 3 DESC) sub
-- GROUP BY 1
-- ORDER BY 2 DESC
	
-- Q 2 : For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
-- SELECT region_name, MAX(total_amt) max_total_amt, order_count
-- FROM (	SELECT s.name sales_rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt, COUNT(o.id) order_count
-- 	FROM sales_reps s JOIN region r
-- 		ON s.region_id = r.id
-- 	JOIN accounts a 
-- 		ON a.sales_rep_id = s.id
-- 	JOIN orders o 
-- 		ON o.account_id = a.id
-- 	GROUP BY 1, 2) sub --s.name, r.name
-- -- 	ORDER BY 3 DESC) sub
-- GROUP BY 1, 3
-- ORDER BY 3 DESC

-- SELECT r.name, COUNT(o.total) total_orders
-- FROM sales_reps s JOIN accounts a
-- 	ON a.sales_rep_id = s.id
-- JOIN orders o	
-- 	ON o.account_id = a.id
-- JOIN region r
-- 	ON r.id = s.region_id
-- GROUP BY r.name
-- HAVING SUM(o.total_amt_usd) = (SELECT MAX(total_amt)
-- 								FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
-- 												FROM sales_reps s
-- 												JOIN accounts a
-- 												ON a.sales_rep_id = s.id
-- 												JOIN orders o
-- 												ON o.account_id = a.id
-- 												JOIN region r
-- 												ON r.id = s.region_id
-- 												GROUP BY r.name) sub)


-- Q 3 : How many accounts had more total purchases than the account name which has bought 
-- the most standard_qty paper throughout their lifetime as a customer?

-- SELECT a.name, SUM(standard_qty)
-- FROM accounts a JOIN orders o	
-- 	ON o.account_id = a.id
-- GROUP BY a.name	
-- HAVING SUM(o.standard_qty) = (	SELECT MAX((stand_qty)) 
-- 								FROM (
-- 									SELECT SUM(o.standard_qty) stand_qty
-- 									FROM orders o
-- 								) innerStatement
-- 							)

-- First, we want to find the account that had the most standard_qty paper. 
-- The query here pulls that account, as well as the total amount:
-- SELECT a.name account_name, SUM(o.standard_qty) total_standard_qty, SUM(o.total) total
-- FROM accounts a JOIN orders o
-- 	ON o.account_id = a.id
-- GROUP BY 1
-- ORDER BY 2 DESC
-- LIMIT 1;

-- Second, use First to pull all the accounts with more total sales:
-- SELECT a.name
-- FROM orders o JOIN accounts a
-- 	ON a.id = o.account_id
-- GROUP BY 1
-- HAVING SUM(o.total) > (SELECT total 
--                       FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
--                             FROM accounts a
--                             JOIN orders o
--                             ON o.account_id = a.id
--                             GROUP BY 1
--                             ORDER BY 2 DESC
--                             LIMIT 1) sub);
							

-- Third, Second has a list of all the accounts with more total orders. 
-- We can get the count with just another simple subquery.
-- SELECT COUNT(*) num_accounts
-- FROM (SELECT a.name
--           FROM orders o
--           JOIN accounts a
--           ON a.id = o.account_id
--           GROUP BY 1
--           HAVING SUM(o.total) > (SELECT total 
--                       FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
--                             FROM accounts a
--                             JOIN orders o
--                             ON o.account_id = a.id
--                             GROUP BY 1
--                             ORDER BY 2 DESC
--                             LIMIT 1) inner_tab)
--                 ) counter_tab;


-- Q 4 : For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, 
-- how many web_events did they have for each channel?

-- Here, we first want to pull the customer with the most spent in lifetime value.
-- SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
-- FROM orders o JOIN accounts a
-- 	ON a.id = o.account_id
-- GROUP BY a.id, a.name
-- ORDER BY 3 DESC
-- LIMIT 1;

-- we want to look at the number of events on each channel this company had, which we can match with just the id.
-- SELECT a.name, w.channel, COUNT(*)
-- FROM accounts a JOIN web_events w
-- 	ON a.id = w.account_id AND a.id =  (SELECT id
-- 										FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
-- 											  FROM orders o
-- 											  JOIN accounts a
-- 											  ON a.id = o.account_id
-- 											  GROUP BY a.id, a.name
-- 											  ORDER BY 3 DESC
-- 											  LIMIT 1) inner_table)
-- GROUP BY 1, 2
-- ORDER BY 3 DESC;

-- Q 5 : What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
-- SELECT id account_id, name account_name, ROUND(AVG(total_spent), 2)
-- FROM 
-- 	(SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
-- 	FROM orders o JOIN accounts a 
-- 		ON a.id = o.account_id
-- 	GROUP BY 1, 2
-- 	ORDER BY 3 DESC
-- 	LIMIT 10) sub
-- GROUP BY 1, 2	
-- ORDER BY 3 DESC

-- Q 6 : What is the lifetime average amount spent in terms of total_amt_usd, 
-- including only the companies that spent more per order, on average, than the average of all orders.

-- First, we want to pull the average of all accounts in terms of total_amt_usd:
-- SELECT AVG(o.total_amt_usd) avg_all
-- FROM orders o

-- Then, we want to only pull the accounts with more than this average amount.
-- SELECT o.account_id, AVG(o.total_amt_usd)
-- FROM orders o
-- GROUP BY 1
-- HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
--                                   FROM orders o)
							   
-- Finally, we just want the average of these values.
SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
       FROM orders o
       GROUP BY 1
       HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                                      FROM orders o)) temp_table;









