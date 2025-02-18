WITH
  filtering AS (
    SELECT DISTINCT
      author,
      year
    FROM books
    WHERE genre = 'Fiction'
  ), calc_prev_year AS (
    SELECT
      author,
      year,
      lag(year, 1) OVER (PARTITION BY author ORDER BY year) prev_year
    FROM filtering
  ), calc_group_num AS (
    SELECT
      author,
      year,
      sum(
        CASE
        WHEN year - prev_year = 1 THEN 0 ELSE 1
        END
      ) OVER (PARTITION BY author ORDER BY year) group_num
    FROM calc_prev_year
  )

SELECT
  author,
  max(year) year,
  count(*) depth
FROM calc_group_num
GROUP BY author, group_num
HAVING count(*) >= 5