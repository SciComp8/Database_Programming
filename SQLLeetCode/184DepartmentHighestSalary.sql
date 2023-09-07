# a WITH clause defines a temporary data set whose output is available to be referenced in subsequent queries.
WITH max_salary AS (
    SELECT departmentId, max(salary) AS max_salary
    FROM Employee
    GROUP BY departmentId
)

SELECT d.name department, e.name employee, e.salary
FROM max_salary AS ms
JOIN employee AS e
    ON ms.departmentId = e.departmentid AND ms.max_salary = e.salary
JOIN department AS d
  ON e.departmentId = d.id;
