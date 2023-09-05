SELECT DISTINCT seller_id
FROM Sales
GROUP BY seller_id
HAVING sum(price) = (
    SELECT sum(price) AS max_price
    FROM Sales
    GROUP BY seller_id
    ORDER BY max_price DESC
    LIMIT 1)
