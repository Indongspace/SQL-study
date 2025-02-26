WITH base AS (
  SELECT
    DISTINCT 
      author,
      year
  FROM books
  WHERE
    genre = 'Fiction'
  ORDER BY
    author, year
)
SELECT
  author,
  MAX(year) AS year,
  COUNT(*) AS depth
FROM (
  SELECT
    author,
    year,
    year - ROW_NUMBER() OVER() AS grp_num
  FROM base
)
GROUP BY
  author, grp_num
HAVING
  COUNT(*) >= 5
