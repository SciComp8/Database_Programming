#Compared to CTE, the results of query in a temporary table is stored in memory for the entire MySQL session
CREATE TEMPORARY TABLE best_doctor AS
(
SELECT h.department_id, h.department_name, d.doctor_id, COUNT(d.visit_id) AS visit_count
FROM Hospital as h
  INNER JOIN [Doctor Details] AS d
  ON h.doctor_id = d.doctor_id
GROUP BY h.department_id, h.department_name, d.doctor_id
HAVING COUNT(d.visit_id) >= 60
ORDER BY h.department_id
)

#We can run multiple queries on the same temporary result set
SELECT DISTINCT department_id
FROM best_doctor;

SELECT doctor_id
FROM best_doctor;

