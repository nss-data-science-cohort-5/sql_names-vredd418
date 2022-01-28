-- 1. How many rows are in the names table?

SELECT COUNT(*)
FROM names;

-- 1,957,046 rows

-- 2. How many total registered people appear in the dataset?

SELECT SUM(num_registered)
FROM names;

-- 351,653,025 registered people

-- 3. Which name had the most appearances in a single year in the dataset?

SELECT name, year, num_registered
FROM names
ORDER BY num_registered DESC
LIMIT 1;

-- Linda had 99,689 appearances in 1947

-- 4. What range of years are included?

SELECT min(year), max(year)
FROM names;

-- 1880 to 2018

-- 5. What year has the largest number of registrations?

SELECT year, SUM(num_registered) AS total_registered
FROM names
GROUP BY year
ORDER BY total_registered DESC
LIMIT 1;

-- 1957 with 4,200,022 registered

-- 6. How many different (distinct) names are contained in the dataset?

SELECT COUNT(DISTINCT name)
FROM names;

-- 98,400 distinct names

-- 7. Are there more males or more females registered?

SELECT gender, sum(num_registered) AS total_registered
FROM names
GROUP BY gender
ORDER BY total_registered DESC;

-- More males than females (177,573,793 vs 174,079,232)

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?

SELECT name, gender, SUM(num_registered) AS total_registered
FROM names
GROUP BY name, gender
ORDER BY total_registered DESC;

-- Most popular male name: James with 5,164,280 registered
-- Most popular female name: Mary with 4,125,675 registered

-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?

SELECT name, gender, SUM(num_registered) AS total_registered
FROM names
WHERE year BETWEEN 2000 AND 2009
GROUP BY name, gender
ORDER BY total_registered DESC;

-- Most popular male name: Jacob with 273,844 registered
-- Most popular female name: Mary with 223,690 registered

-- 10. Which year had the most variety in names (i.e. had the most distinct names)?

SELECT COUNT(DISTINCT name) AS name_count, year
FROM names
GROUP BY year
ORDER BY name_count DESC
LIMIT 1;

-- 2008 had 32,518 distinct names

-- 11. What is the most popular name for a girl that starts with the letter X?

SELECT name, SUM(num_registered) AS total_registered
FROM names
WHERE name LIKE 'X%' and gender = 'F'
GROUP BY name
ORDER BY total_registered DESC;

-- Ximena with 26,145 registered 

-- 12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?

SELECT COUNT(DISTINCT name)
FROM names
WHERE name LIKE 'Q%' AND name NOT LIKE 'Qu%';

-- 46 distinct names

-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.

SELECT name, SUM(num_registered) AS total_registered
FROM names
WHERE name = 'Stephen' OR name = 'Steven'
GROUP BY name
ORDER BY total_registered DESC;

-- 'Steven' is more popular that 'Stephen', with 1,286,951 vs 860,972 registered respectively

-- 14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?

SELECT ROUND(SUM(sub_q.name_number)/(SELECT COUNT(DISTINCT name) FROM names)*100, 4) AS unisex_pct
FROM
	(SELECT name, COUNT(DISTINCT gender) AS gender_number, COUNT(DISTINCT name) AS name_number
	 FROM names
	 GROUP by name) AS sub_q
WHERE sub_q.gender_number = 2;

-- 10.95 % of names are unisex

-- 15. How many names have made an appearance in every single year since 1880?

SELECT COUNT(sub_q.name) AS name_count
FROM
	(SELECT year, name, COUNT(DISTINCT(name))
	 FROM names
	 GROUP BY year, name) AS sub_q
GROUP BY sub_q.name
HAVING COUNT(sub_q.name) =  2018 - 1880 + 1;

-- 921 names (not the best way to answer this)

-- 16. How many names have only appeared in one year?

SELECT COUNT(sub_q.name) AS name_count
FROM
	(SELECT year, name, COUNT(DISTINCT(name))
	 FROM names
	 GROUP BY year, name) AS sub_q
GROUP BY sub_q.name
HAVING COUNT(sub_q.name) =  1;

-- 21123 (same as above, not the best way to answer this)

-- 17. How many names only appeared in the 1950s?

SELECT COUNT(sub_q.name) AS name_count
FROM
	(SELECT year, name, COUNT(DISTINCT(name))
	 FROM names
	 GROUP BY year, name) AS sub_q
GROUP BY sub_q.year, sub_q.name
HAVING year::text LIKE '195%' AND year::text NOT LIKE ALL(ARRAY['18%', '190%', '191%', '192%', '193%', '194%', '196%', '197%', '198%', '199%', '2%']);

-- This can't be right

-- 18. How many names made their first appearance in the 2010s?

-- 19. Find the names that have not been used the longest.

-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.