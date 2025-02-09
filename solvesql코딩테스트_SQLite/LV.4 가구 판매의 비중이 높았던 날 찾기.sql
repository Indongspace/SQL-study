SELECT
  order_date,
  furniture,
  ROUND((furniture * 100.0) / total_cnt, 2) AS furniture_pct
FROM (
  SELECT
    order_date,
    COUNT(DISTINCT order_id) AS total_cnt,
    COUNT(DISTINCT CASE WHEN category = 'Furniture' THEN order_id END) AS furniture
  FROM records
  GROUP BY
    order_date
  HAVING
    COUNT(DISTINCT order_id) >= 10
)
WHERE
  (furniture * 100.0) / total_cnt >= 40
ORDER BY
  furniture_pct DESC, order_date ASC 
