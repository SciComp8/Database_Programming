#The window function allow us to add aggreate values to non-grouped result sets, 
#so that we leave the non-aggregated variables the way they are, and add columns that contain aggregated values
#We can add 'down-column' calculations (e.g., average, max, min, sum) to non-grouped results, based on certain rows of the data

#OVER()
#Example: add the overall average to each row
SELECT 
  patient_id, 
  start_date, 
  end_date,
  DATEDIFF(end_date, start_date) AS duration_days,
  AVG(DATEDIFF(end_date, start_date)) OVER() AS avg_duration
FROM date_table;

#SUM() function is used as a window function
SELECT
    first_name,
    last_name,
    salary,
    SUM(salary) OVER() AS sum_salary
FROM employees;

#SQL window function types
##Value window functions
FIRST_VALUE()
LAG()
LAST_VALUE()
LEAD()
##Ranking window functions
CUME_DIST()
DENSE_RANK()
NTILE()
PERCENT_RANK()
RANK()
ROW_NUMBER()
##Aggregate window functions
AVG()
COUNT()
MAX()
MIN()
SUM()
  
#Window function syntax
#window_function_name: ROW_NUMBER(), RANK(), SUM(), AVG(), COUNT(), MAX(), MEAN(), etc
#expression: target expression or column on which the window function operates
#OVER clause: defines window partitions to form the groups of rows or specifies the orders of rows in a partition. The OVER clause consists of three clauses: partition, order, and frame clauses. A frame is the subset of the current partition
window_function_name ( expression ) OVER (
    partition_clause
    order_clause
    frame_clause
)
#Example: populate the group-specific average within each row
SELECT 
  patient_id, 
  start_date, 
  end_date,
  DATEDIFF(end_date, start_date) AS duration_days,
  AVG(DATEDIFF(end_date, start_date)) OVER(PARTITION BY tx_group) AS group_avg_duration
FROM date_table;

#partition clause: divides the rows into partitions to which the window function applies. 
PARTITION BY expr1, expr2, ...
#If the PARTITION BY clause is not specified, then the whole result set is treated as a single partition.

#RANK clause: assigns a rank to each row in the partition of a result set; The same column values receive the same ranks. When multiple rows share the same rank, the rank of the next row is not consecutive
#Example: add the individual-level rank for salary
SELECT 
	first_name, 
	last_name, 
	salary, 
	RANK() OVER (ORDER BY salary DESC) salary_rank
FROM 
	employees;

#DENSE_RANK clause: different from RANK(), DENSE_RANK() always generates consecutive rank values
SELECT 
	first_name, 
	last_name, 
	salary, 
	DENSE_RANK() OVER (ORDER BY salary DESC) salary_rank
FROM 
	employees;

#Find employees who have the highest salary in their departments
SELECT *
FROM (
	SELECT 
		first_name, 
		last_name, 
		department_name,
		salary, 
		DENSE_RANK() OVER (
			PARTITION BY department_name
			ORDER BY salary DESC) salary_rank
	FROM 
		employees AS e
		INNER JOIN departments AS d 
			ON d.department_id = e.department_id
	) AS t
WHERE salary_rank = 1;

#LAG(): access data of the previous row, or from the second row before the current row, or from the third row before current row; very useful for calculating the difference between the current row and the previous row
#Example: returns both the current and previous year’s salary of all employees
SELECT 
	employee_id, 
	fiscal_year, 
	salary,
	LAG(salary) OVER (
		PARTITION BY employee_id 
		ORDER BY fiscal_year) AS previous_salary
FROM basic_pays;
#PARTITION BY clause: divide the result set into groups by employee ID
#ORDER BY clause: sort the rows by fiscal year in ascending order within each group
#LAG(): the first row in each group was NULL because there was no previous year’s salary; The second and third rows got the salary from the first and second rows and populate them into the previous_salary column

SELECT 
	employee_id, 
	fiscal_year, 
	salary,
	LAG(salary,1,0) OVER (
		PARTITION BY employee_id 
		ORDER BY fiscal_year) AS previous_salary
FROM basic_pays;
#LAG(salary,1,0): retrieve the salary in the previous row; and if no preceding row is found, 0 is returned

#A more complicated case:
SELECT 
	employee_id, 
	fiscal_year, 
	salary,
	previous_salary,
	CONCAT(ROUND(( salary - previous_salary ) * 100 / previous_salary, 0),'%')  YoY
FROM
	( SELECT 
		employee_id, 
		fiscal_year, 
		salary,
		LAG(salary,1,0) OVER (
			PARTITION BY employee_id 
			ORDER BY fiscal_year) AS previous_salary
	FROM
		basic_pays
	) AS t;    


