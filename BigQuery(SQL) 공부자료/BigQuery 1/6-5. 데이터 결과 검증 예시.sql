WITH battle_basic AS (
  SELECT
    id AS battle_id,
    player1_id AS trainer_id,
    winner_id
  FROM basic.battle
  UNION ALL
  SELECT
    id AS battle_id,
    player2_id AS trainer_id,
    winner_id
  FROM basic.battle
), battle_with_result AS (
  SELECT
    *,
    CASE
      WHEN trainer_id = winner_id THEN "WIN"
      WHEN winner_id IS NULL THEN "DRAW"
    ELSE "LOSE"
    END AS battle_result
  FROM battle_basic
  #WHERE trainer_id = 7 
)

SELECT
  trainer_id,
  COUNTIF(battle_result="WIN") AS win_count,
  COUNT(battle_id) AS total_battle_count,
  COUNTIF(battle_result="WIN")/COUNT(DISTINCT battle_id) AS win_ratio
FROM battle_with_result
GROUP BY
  trainer_id 
HAVING
  total_battle_count >= 9 
