#A SELECT query that is nested within one of the caluses (WHERE/HAVING/FROM/SELECT) of another query

#Subquery in the WHERE clause generates values or lists to be used in the filtering criteria
#There can only be 1 varibale in the SELECT clause for this type of subquery
#Example: obtain information on patients who have no records in the follow-up table
SELECT patient_id, treatment
FROM patients
WHERE patient_id NOT IN
  (SELECT patient_id
   FROM follow);

#Subquery in the FROM clause generates a derived table to select data from
#This is useful when we need to select from aggregated data
#Example: want a list of best-visited hospital departments in the past month
#Solution: 1. aggregate the data to get a count of each doctor visited by patients in the past 30 days, and select doctors who have at least 60 times visits in the past 30 days; 2. select the distinct list of hospital department from the derived table in 1

