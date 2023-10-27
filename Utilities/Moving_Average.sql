#The main idea is to examine how the averages behave over time instead of examining the behavior of the original or raw data points
#Working with moving averages gives us a better representation of the time series, since longer-term trends are much easier to see with moving averages than with raw data points
#Smoothing is the main objective of the moving average technique; it is used to remove noise from the data. With less noise, the real trends in time series data are easier to see
##The higher the number of previous values, the smoother our curve will be. The smaller the number of rows used to calculate the averages, the closer the graph of the moving average will be to that of the original values
#Analysis of confirmed COVID-19 cases: moving averages help show how the trend of number of confirmed cases is changing over time.

SELECT *,
	AVG(Price) OVER(
		ORDER BY Date
     		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
FROM stock_price;

#ROWS BETWEEN 2 PRECEDING AND CURRENT ROW: this syntax defines the window frame: the size of the window in our example is three. For each given row, we take the row itself and the two previous rows, and we calculate the average price from those three rows
#!Data should not have any gaps in dates. For each day, we need to calculate the average of the prices from that day and the two previous days. If there are missing dates in the data, this analysis will not make sense


SELECT *,
	AVG(Price) OVER(
		ORDER BY Date
     		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS three_day_moving_average
	AVG(Price) OVER(
		ORDER BY Date
     		ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS thirty_day_moving_average
FROM stock_price;
