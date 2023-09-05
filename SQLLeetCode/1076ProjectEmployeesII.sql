# Approach 1
SELECT p.project_id
FROM Project AS p
GROUP BY p.project_id
HAVING COUNT(p.employee_id) = 
    (SELECT max(p1.employee_num)
    FROM (SELECT project_id, COUNT(employee_id) AS employee_num
         FROM Project
         GROUP BY project_id) AS p1
    );

# Approach 2
SELECT TOP 1 WITH TIES project_id
FROM Project
GROUP BY project_id
ORDER BY COUNT(employee_id) DESC;

# Approach 3
SELECT project_id 
FROM Project 
GROUP BY project_id
HAVING COUNT(employee_id) = (
        SELECT COUNT(employee_id)
        FROM Project
        GROUP BY project_id
        ORDER BY COUNT(employee_id) DESC
        LIMIT 1);
