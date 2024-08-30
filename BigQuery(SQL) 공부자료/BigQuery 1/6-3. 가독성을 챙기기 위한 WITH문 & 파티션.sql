WITH sample AS (
  SELECT
    id,
    player1_id,
    player2_id
  FROM `inflearn-bigquery-study-420008.basic.battle` 
), sample2 AS (
  SELECT
    id,
    name,
    hometown
  FROM basic.trainer
  WHERE
    id = 3
), sample3 AS (
  SELECT
    *
  FROM sample2
)

SELECT
  *
FROM sample3