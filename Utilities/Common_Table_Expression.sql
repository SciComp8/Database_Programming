#Traditional subqueries
SELECT DISTINCT department_id
FROM
(  
SELECT h.department_id, h.department_name, d.doctor_id, COUNT(d.visit_id) AS visit_count
FROM Hospital as h
  INNER JOIN [Doctor Details] AS d
  ON h.doctor_id = d.doctor_id
GROUP BY h.department_id, h.department_name, d.doctor_id
HAVING COUNT(d.visit_id) >= 60
ORDER BY h.department_id
);

#CTEs: improve readability; increase the query speed since the results of CTE are stored in memory and referenced by the given name (e.g., best_doctor)
#The results of CTE are removed from memory after the main query runs
WITH best_doctor AS
(
SELECT h.department_id, h.department_name, d.doctor_id, COUNT(d.visit_id) AS visit_count
FROM Hospital as h
  INNER JOIN [Doctor Details] AS d
  ON h.doctor_id = d.doctor_id
GROUP BY h.department_id, h.department_name, d.doctor_id
HAVING COUNT(d.visit_id) >= 60
ORDER BY h.department_id
)
#Main query starts
SELECT DISTINCT department_id
FROM best_doctor;
