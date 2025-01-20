SELECT
  region AS Region,
  SUM(CASE WHEN category = 'Furniture' THEN cnt ELSE 0 END) AS Furniture,
  SUM(CASE WHEN category = 'Office Supplies' THEN cnt ELSE 0 END) AS `Office Supplies`,
  SUM(CASE WHEN category = 'Technology' THEN cnt ELSE 0 END) AS Technology
FROM (
  SELECT
    region,
    category,
    COUNT(DISTINCT order_id) AS cnt
  FROM records
  GROUP BY
    region, category 
)
GROUP BY
  region 
ORDER BY
  region ASC 
