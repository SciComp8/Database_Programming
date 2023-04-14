# Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.
# Hint: the ISNULL(expression, value) function returns a specified value if the expression is NULL. If the expression is NOT NULL, this function returns the expression.

SELECT name 
FROM customer
WHERE ISNULL(referee_id, 0) != 2;
