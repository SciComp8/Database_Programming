# Approach 1:
DELETE p 
FROM Person p, Person q 
WHERE p.id > q.id AND p.email = q.email; 

# Approach 2:
DELETE p
FROM person p
JOIN person q
    ON p.email = q.email AND p.id > q.id;  
