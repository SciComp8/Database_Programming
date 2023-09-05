select distinct seller_id
from Sales
group by seller_id
having sum(price) = (
    select sum(price) as max_price
    from Sales
    group by seller_id
    order by max_price desc
    limit 1)
