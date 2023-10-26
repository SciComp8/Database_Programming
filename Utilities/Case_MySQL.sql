#！！！Once a value meets the first condition, it will not be checked against the second condition
#Example 1:
SELECT patient_id, bmi,
  CASE
      WHEN bmi >= 30 THEN 'Obese'
      WHEN bmi >= 25 THEN 'Overweight'
      ELSE 'Normal'
  END AS bmi_category
FROM patient_data;

#Example 2:
SELECT first_name, last_name, hire_date,
    CASE (2023 - YEAR(hire_date))
        WHEN 1 THEN '1 year'
        WHEN 3 THEN '3 years'
        WHEN 5 THEN '5 years'
        WHEN 10 THEN '10 years'
        WHEN 15 THEN '15 years'
        WHEN 20 THEN '20 years'
    END AS aniversary
FROM employee_table
ORDER BY first_name;
