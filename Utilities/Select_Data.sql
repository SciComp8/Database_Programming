#SELECT
#FROM
#WHERE
#GROUP
#HAVING
#ORDER BY
#Aggregate function: COUNT()/SUM()/AVG()/MIN()/MAX()
#None-aggregate function: ABS()/MOD()/CEILING()/ADDDATE()/ISNULL()/LEFT()/SWITCH()[SQL]
# More: https://www.techonthenet.com/mysql/functions/index.php
  
SELECT var1, var2
FROM table1;

SELECT *
FROM table1;

SELECT var1, var2
FROM table1
WHERE var1='value1' AND var2='value2';

SELECT SUM(var2)
FROM table1;
  
#Do the summation of var2 per categorical level in var1
#We add all non-aggregated variables to the GROUP BY clause
SELECT var1, SUM(var2)
FROM table1
GROUP BY var1;

SELECT var1, SUM(var2) AS sum_var2 #Add an alias
FROM table1
GROUP BY var1;

#More complicated example:
SELECT p.supplier_id, p.product_name, o.product_id, COUNT(o.order_id) AS product_count
FROM Product as p
  INNER JOIN [Order Details] AS o
  ON p.product_id = o.product_id
GROUP BY p.supplier_id, p.product_name, o.product_id
HAVING COUNT(o.order_id) >= 30
ORDER BY p.supplier_id;

#HAVING filters the results of an aggregated function
SELECT var1, SUM(var2) AS sum_var2
FROM table1
GROUP BY var1
HAVING SUM(var2) <= 200; 

#Select products with at least 30 orders
SELECT p.product_name, o.product_id, COUNT(o.order_id) AS product_count
FROM Product as p
  INNER JOIN [Order Details] AS o
  ON p.product_id = o.product_id
GROUP BY p.product_name, o.product_id
HAVING COUNT(o.order_id) >= 30;

SELECT var1, var2
FROM table1
ORDER BY var2;

SELECT var1, var2
FROM table1
ORDER BY var2 DESC;

#Make values in each cell of the column `music_name` all uppercase
SELECT UCASE(music_name) AS uppercase_music_name
FROM table2;

#Take average of 2 columns
SELECT (var1 + var2) / 2 AS avg_var12
FROM table2;

#If-else: recode values within a column
SELECT IFF(var1='Yes', 1, 0) AS var1_01
FROM table2;

SELECT ABS(30 * -1);

#Concatenate the first and last names
SELECT first_name, last_name, first_name & ' ' & last_name AS full_name
FROM table2;

#Create a new column whereby if the first letter of the name is C, the value returns 1; if the first letter of the name is A, the value returns 0
SELECT name, 
CASE WHEN LEFT(name, 1) = 'C' THEN 1
WHEN LEFT(name, 1) = 'A' THEN 0
ELSE NULL
END AS name_01
FROM table2;

