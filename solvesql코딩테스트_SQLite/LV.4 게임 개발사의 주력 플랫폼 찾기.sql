SELECT
  DISTINCT 
    c.name AS developer,
    b.name AS platform,
    b.sales
FROM (
  SELECT
    *,
    DENSE_RANK() OVER(PARTITION BY developer_id ORDER BY sales DESC) AS rnk
  FROM (
    SELECT
      developer_id,
      name,
      SUM(sales) OVER(PARTITION BY developer_id, name) AS sales
    FROM (
      SELECT
        g.developer_id,
        p.name,
        g.sales_na + g.sales_eu + g.sales_jp + g.sales_other AS sales 
      FROM games AS g 
      INNER JOIN platforms AS p 
      ON g.platform_id = p.platform_id
      WHERE
        g.developer_id IS NOT NULL
    )
  )
) AS b
INNER JOIN companies AS c 
ON b.developer_id = c.company_id
WHERE
  b.rnk = 1
