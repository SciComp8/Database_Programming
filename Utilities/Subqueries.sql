#A SELECT query that is nested within one of the caluses (WHERE/HAVING/FROM/SELECT) of another query

#Subquery in the WHERE clause generates values or lists to be used in the filtering criteria
#There can only be 1 varibale in the SELECT clause for this type of subquery
#Example 1: obtain information on patients who have no records in the follow-up table
SELECT patient_id, treatment
FROM patients
WHERE patient_id NOT IN
  (SELECT patient_id
   FROM follow);

#Alternative solution using the LEFT JOIN
SELECT p.patient_id, p.treatment
FROM patients as p
  LEFT JOIN visits as v
  ON p.patient_id = v.patient_id
WHERE v.patient_id IS NULL;

#Example 2: find the second highest salary
SELECT MAX(Salary) AS second_highest_salary
FROM Employee
WHERE Salary < (Select MAX(Salary) FROM Employee);
#WHERE Salary NOT IN (SELECT MAX(Salary) FROM Employee);

#Example 3: find the customers who never place orders
SELECT name AS Customers
FROM Customers AS C
WHERE C.id NOT IN
  (SELECT customerID
   FROM Orders);

#Subquery in the FROM clause generates a derived table to select data from
#This is useful when we need to select from aggregated data
#Example: want a list of best-visited hospital departments in the past month
#Solution: 1. aggregate the data to get a count of each doctor visited by patients in the past 30 days, and select doctors who have at least 60 times visits in the past 30 days; 2. select the distinct list of hospital department from the derived table in 1

