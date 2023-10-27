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

#Window function syntax
window_function_name ( expression ) OVER (
    partition_clause
    order_clause
    frame_clause
)

#window_function_name: ROW_NUMBER(), RANK(), SUM(), AVG()
#expression: target expression or column on which the window function operates



