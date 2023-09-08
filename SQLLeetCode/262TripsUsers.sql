# Write your MySQL query statement below
SELECT t.request_at AS 'Day', 
    CAST(
        AVG(CASE 
                WHEN status = 'completed' then 0
                ELSE 1.0
            END)
        AS DECIMAL(3,2)
    ) AS 'Cancellation Rate'
FROM Trips AS t
INNER JOIN Users AS c 
    ON t.client_id=c.users_id
INNER JOIN Users AS d 
    ON t.driver_id=d.users_id
WHERE c.banned='no' AND
      d.banned='no' AND
      t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at;
