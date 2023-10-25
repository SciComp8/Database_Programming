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

# Alternative solution: left join from a subquery that returns the maximum salary in each department
SELECT d.Name AS Department, e.Name As Employee, e.Salary AS Salary
FROM Employee AS e
LEFT JOIN Department AS d
ON e.DepartmentId = d.Id
WHERE (e.DepartmentId, e.Salary) in 
  (SELECT DepartmentId, max(Salary)
   FROM Employee
   GROUP BY DepartmentId);
