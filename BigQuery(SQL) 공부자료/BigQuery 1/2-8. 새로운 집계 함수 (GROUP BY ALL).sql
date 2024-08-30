WITH PlayerStats AS (
  SELECT 'Adams' as LastName, 'Noam' as FirstName, 3 as PointScored UNION ALL
  SELECT 'Buchanan', 'Jie', 0 UNION ALL
  SELECT 'Coolidge','Kiran', 1 UNION ALL
  SELECT 'Adams', 'Noam', 4 UNION ALL
  SELECT 'Buchanan', 'Jie', 13
)

SELECT
  FirstName AS first_name,
  LastName AS last_name,
  # 다른 컬럼,
  SUM(PointScored) AS total_points
FROM PlayerStats
GROUP BY ALL
-- GROUP BY
--   first_name,
--   last_name
--   # 다른 컬럼
