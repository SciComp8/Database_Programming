SELECT email
FROM person
GROUP BY email
HAVING COUNT(*) > 1; # or HAVING COUNT(email) > 1;
