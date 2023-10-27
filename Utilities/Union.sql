#Append the results from one query to the results from another query -> connect tables from top to bottom
#Prerequisite: we must have identical columns to append
#**Duplicate rows** between top set of results and botton set of results are **removed**

#Syntax
SELECT var1, var2, var3
FROM table1

UNION

SELECT var1, var2, var3
FROM table2;

#Example
SELECT * 
FROM company1

UNION

SELECT *
FROM company2;

#Union all: duplicate rows between top set of results and botton set of results are NOT removed
#Example
SELECT * 
FROM company1

UNION ALL

SELECT *
FROM company2;
