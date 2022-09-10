/*
-------------- 03. Quiz: LEFT & RIGHT --------------
*/

-- Q 1 : In the accounts table, there is a column holding the website for each company. 
-- The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. 
-- Pull these extensions and provide how many of each website type exist in the accounts table.
/*
SELECT RIGHT(website, 3) extensions, COUNT(RIGHT(website, 3)) extension_count
FROM accounts
GROUP BY 1 -- , 2, 3 -- RIGHT(website, 3)
ORDER BY 2 DESC
*/


-- Q 2 : There is much debate about how much the name (or even the first letter of a company name) matters. 
-- Use the accounts table to pull the first letter of each company name to see the distribution of 
-- company names that begin with each letter (or number).

/*
SELECT LEFT(name, 1) company_name_first_letter, COUNT(LEFT(name, 1)) first_letter_count
FROM accounts
GROUP BY 1 -- LEFT(name, 1)
ORDER BY 2 DESC -- first_letter_count DESC -- company_name_first_letter --, 
*/

/*
WITH company_name_first_letter_statistics AS
(
	SELECT LEFT(name, 1) company_name_first_letter, COUNT(LEFT(name, 1)) first_letter_count
	FROM accounts
	GROUP BY LEFT(name, 1)
	ORDER BY first_letter_count DESC
)

-- Sum all first letter count for all first letter
SELECT SUM(first_letter_count) first_letter_all_statistics
FROM company_name_first_letter_statistics
*/

-- Q 3 : Use the accounts table and a CASE statement to create two groups: 
-- one group of company names that start with a number and a second group of those company names that start with a letter. 
-- What proportion of company names start with a letter?

-- SELECT (CASE LEFT(name, 1) --company_name_first_letter, COUNT(LEFT(name, 1)) first_letter_count
-- 		WHEN isnumeric(LEFT(name, 1)) THEN 'Num'
-- 		ELSE 'Alpha'
-- 		END) start_with_group
-- FROM accounts

/*
WITH two_groups AS
(
		SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                          THEN 1 ELSE 0 END AS num, 
            		 CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                          THEN 0 ELSE 1 END AS letter
         FROM accounts
)

SELECT SUM(num) nums, SUM(letter) letters
FROM two_groups;
*/

-- Q 4 : Consider vowels as a, e, i, o, and u. 
-- What proportion of company names start with a vowel, and what percent start with anything else?

/*
WITH vowels_consonant_groups AS
(
		SELECT name, CASE WHEN LEFT(LOWER(name), 1) IN ('a','e','i','o','u') 
                          THEN 1 ELSE 0 END AS vowels, 
            		 CASE WHEN LEFT(LOWER(name), 1) IN ('a','e','i','o','u') 
                          THEN 0 ELSE 1 END AS consonants
         FROM accounts
)

SELECT SUM(vowels) total_vowels, SUM(consonants) total_consonants, SUM(vowels) + SUM(consonants) AS population 
FROM vowels_consonant_groups
*/

/*

SELECT (SUM(vowels) / (SUM(vowels) + SUM(consonants))) AS vowel_percent, 
		(SUM(consonants) / (SUM(vowels) + SUM(consonants))) AS consonant_percent --, SUM(vowels) + SUM(consonants) AS population
FROM vowels_consonant_groups

vowels_consonant_percentage AS
(
	SELECT SUM(vowels) AS total_vowels, SUM(consonants) AS total_consonants, SUM(vowels) + SUM(consonants) AS population
	FROM vowels_consonant_groups
)

SELECT (total_vowels / population) AS vowel_percent, (total_consonants / population) AS consonant_percent
FROM vowels_consonant_percentage
*/


/*
-- Quizzes POSITION & STRPOS
*/

-- Q 1 : Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.
/*
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, 
   		RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;
*/

-- Q 2 Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
-- SELECT LEFT(name, STRPOS(name, ' ') -1 ) first_name, 
--    		RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
-- FROM sales_reps;

/*
-- 09. Quiz: CONCAT
*/

-- Q 1 & 2 : Each company in the accounts table wants to create an email address for each primary_poc. 
-- The email address should be the first name of the primary_poc . last name primary_poc @ company name .com

SELECT website, CONCAT(LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ),'.',
   		RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')), '@', 
		RIGHT(website, LENGTH(website) - STRPOS(website, '.'))) email
FROM accounts;

-- Q 3 : We would also like to create an initial password, which they will change after their first log in. 
-- The first password will be the 
-- 1. first letter of the primary_poc's first name (lowercase), then 
-- 2. the last letter of their first name (lowercase), 
-- 3. the first letter of their last name (lowercase), 
-- 4. the last letter of their last name (lowercase), 
-- 5. the number of letters in their first name, 
-- 6. the number of letters in their last name, and 
-- 7. then the name of the company they are working with, all capitalized with no spaces.

WITH poc_info AS
(
	SELECT UPPER(LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 )) first_name, 
   			UPPER(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' '))) last_name, 
			UPPER(name) company_name
	FROM accounts
)

SELECT 
-- 		first_name,  last_name,
-- 		LEFT(first_name, 1) first_letter_first_name, -- 1
-- 		RIGHT(first_name, 1) last_letter_first_name, -- 2
--    		LEFT(last_name, 1) first_letter_last_name, -- 3
-- 		RIGHT(last_name, 1) last_letter_last_name, -- 4
-- 		LENGTH(first_name) length_first_name, -- 5
-- 		LENGTH(last_name) length_last_name, -- 6
-- 		company_name,
		LEFT(first_name, 1) || '' || RIGHT(first_name, 1) || '' || LEFT(last_name, 1) || '' || RIGHT(last_name, 1) || '' ||
			LENGTH(first_name) || '' || LENGTH(last_name) || '' || translate(company_name, ' ', '') AS initial_password
FROM poc_info;








