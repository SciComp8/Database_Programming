#The window function allow us to add aggreate values to non-grouped result sets, 
#so that we leave the non-aggregated variables the way they are, and add columns that contain aggregated values
#We can add 'down-column' calculations (e.g., average, max, min, sum) to non-grouped results, based on certain rows of the data

#OVER()
#Example: add the overall average to each row
SELECT patient_id, start_date, end_date,
  DATEDIFF(end_date, start_date) AS duration_days,
  AVG(DATEDIFF(end_date, start_date)) OVER() AS avg_duration
FROM date_table;
