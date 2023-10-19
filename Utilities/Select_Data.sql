#SELECT
#FROM
#WHERE
#GROUP
#HAVING
#ORDER BY
#Aggregate function: COUNT()/SUM()/AVG()/MIN()/MAX()

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
SELECT var1, SUM(var2)
FROM table1
GROUP BY var1;

SELECT var1, SUM(var2) AS sum_var2 #Add an alias
FROM table1
GROUP BY var1;

#HAVING filters the results of an aggregated function
SELECT var1, SUM(var2) AS sum_var2
FROM table1
GROUP BY var1
HAVING SUM(var2) <= 200; 

SELECT var1, var2
FROM table1
ORDER BY var2;

SELECT var1, var2
FROM table1
ORDER BY var2 DESC;

