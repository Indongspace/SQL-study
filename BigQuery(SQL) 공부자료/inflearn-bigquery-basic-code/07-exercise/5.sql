-- 5. 트레이너가 잡았던 포켓몬의 총 공격력(attack)과 방어력(defense)의 합을 계산하고, 이 합이 가장 높은 트레이너를 찾으세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너 포켓몬의 총 (공격+방어) 공방
# 쿼리 계산 방법 : trainer_pokemon => pokemon. attack + defense
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon, pokemon, trainer
# Join KEY : trainer_pokemon.pokemon_id = pokemon.id
# 데이터 특징 : 

# (1) 트레이너가 보유한 포켓몬들의 attack, defense
WITH total_stats AS (
  SELECT
    tp.trainer_id,
    -- p.attack,
    -- p.defense,
    SUM(p.attack + p.defense) AS total_stat
  FROM basic.trainer_pokemon AS tp
  LEFT JOIN basic.pokemon AS P
  ON tp.pokemon_id = p.id
  GROUP BY
    tp.trainer_id
)

SELECT
  t.name,
  ts.trainer_id,
  ts.total_stat
FROM total_stats AS ts
LEFT JOIN basic.trainer AS t
ON ts.trainer_id = t.id
ORDER BY 
  total_stat DESC
LIMIT 1