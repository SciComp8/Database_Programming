#Main idea: left join 2 tables from a subquery that returns the maximum salary in each department
SELECT d.Name AS Department, e.Name As Employee, e.Salary AS Salary
FROM Employee AS e
LEFT JOIN Department AS d
ON e.DepartmentId = d.Id
WHERE (e.DepartmentId, e.Salary) in 
  (SELECT DepartmentId, max(Salary)
   FROM Employee
   GROUP BY DepartmentId);

#Alternative solution:
SELECT *
FROM (
	SELECT 
		d.Name AS Department, 
		e.Name As Employee, 
		e.Salary AS Salary,
		DENSE_RANK() OVER (
			PARTITION BY e.DepartmentId
			ORDER BY e.salary DESC) AS salary_rank
	FROM 
		Employees AS e
		LEFT JOIN Department AS d 
			ON e.DepartmentId = d.Id
	) AS t
WHERE salary_rank = 1;
