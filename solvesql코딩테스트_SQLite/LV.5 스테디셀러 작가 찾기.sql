SELECT
  author,
  MAX(year) AS year,
  SUM(diff) AS depth
FROM (
  SELECT
    *,
    year - prev_best AS diff
  FROM (
    SELECT
      author,
      year,
      LAG(year) OVER(PARTITION BY author ORDER BY year) AS prev_best
    FROM books
  )
  WHERE
    diff = 1
)
GROUP BY
  author
HAVING
  SUM(diff) >= 5
