WITH base AS (
  SELECT
    g.name,
    CASE
    WHEN p.name IN ('PS3', 'PS4', 'PSP', 'PSV') THEN 'Sony'
    WHEN p.name IN ('Wii', 'WiiU', 'DS', '3DS') THEN 'Nintendo'
    WHEN p.name IN ('X360', 'XONE') THEN 'Microsoft'
    ELSE NULL
  END AS platform 
  FROM games AS g
  INNER JOIN platforms AS p 
  ON g.platform_id = p.platform_id
  WHERE
    g.year >= 2012
)
SELECT
  name
FROM base
WHERE
  platform IS NOT NULL
GROUP BY
  name  
HAVING
  COUNT(DISTINCT platform) >= 2
