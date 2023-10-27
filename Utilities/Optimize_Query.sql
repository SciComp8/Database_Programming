EXPLAIN ANALYZE
SELECT *,
  AVG(Price) OVER(
      ORDER BY Date
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS moving_average
FROM stock_price;

#Situation: big data & cloud computing
#1.When creating tables, index columns can be used in WHERE, GROUP BY, or ORDER BY clauses to speed up the search of columns within a table
#2.Use joins over subqueries
#3.Use inner joins over outer joins (e.g. left/right/full)
#4.Avoid placing wildcard operator % at the beginning of a search string (e.g., LIKE '%WS')
#5.Avoid including the columns or clauses that are not necessary
