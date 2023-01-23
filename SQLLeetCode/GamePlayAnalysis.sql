SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id;

# Another variant
SELECT DISTINCT
  A.player_id,
  FIRST_VALUE(A.event_date) OVER (
    PARTITION BY
      A.player_id
    ORDER BY
      A.event_date
  ) AS first_login
FROM
  Activity A;
