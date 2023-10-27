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
#OVER clause: defines window partitions to form the groups of rows or specifies the orders of rows in a partition. The OVER clause consists of three clauses: partition, order, and frame clauses. A frame is the subset of the current partition.
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





