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

SELECT AVG(standard_qty) avg_standard, AVG(gloss_qty) avg_gloss, AVG(poster_qty) avg_poster
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
     (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

SELECT * 
FROM
	(SELECT SUM(total_amt_usd)
	 FROM orders
	 WHERE DATE_TRUNC('month', occurred_at) = 
		  (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);)
