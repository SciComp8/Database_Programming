#When we join the tables, there always needs to be a column that is common to both of the tables
#Inner joins: return only the records where data exists in the joined field in both tables
#Left joins: return all of the records from the table on the left along with matching records form the table on the right
#Right joins: return all of the records from the table on the right along with matching records form the table on the left
#When more than one table is involved in a query, table references (e.g., full name or alias) must precede variable names in the SELECT clause

#Inner join
SELECT first_table.var_1, second_table.var_2
FROM first_table
  INNER JOIN second_table
  ON first_table.common_var = second_table.common_var;

#More simplified syntax using 'USING', if the common field between two tables has the same name
SELECT first_table.var_1, second_table.var_2
FROM first_table
  INNER JOIN second_table
    USING(common_var);

#Left join
SELECT first_table.var_1, second_table.var_2
FROM first_table
  LEFT JOIN second_table
  ON first_table.common_var = second_table.common_var;

#More simplified syntax using 'USING', if the common field between two tables has the same name
SELECT first_table.var_1, second_table.var_2
FROM first_table
  LEFT JOIN second_table
    USING(common_var);

SELECT f.var_1, s.var_2
FROM first_table AS f
  INNER JOIN second_table AS s
  ON f.common_var = s.common_var;

#Find how many times a product is ordered
SELECT p.product_name, o.product_id, COUNT(o.order_id) AS product_count
FROM Product as p
  INNER JOIN [Order Details] AS o
  ON p.product_id = o.product_id
GROUP BY p.product_name, o.product_id;

#Join two tables on multiple common fields
SELECT f.var_1, s.var_2
FROM first_table AS f
  INNER JOIN second_table AS s
  ON f.common_var_1 = s.common_var_1
    AND f.common_var_2 = s.common_var_2;

#Join 3 tables: treat the first pair of tables joined as if it is a new table, then put parentheses around it, and add more join syntax after it
SELECT f.var_1, s.var_2, t.var_3
FROM (first_table AS f
  INNER JOIN second_table AS s
  ON f.common_var_1 = s.common_var_1)

  INNER JOIN third_table AS t
  ON s.common_var_1 = t.common_var_1
    AND s.common_var_2 = t.common_var_2;


