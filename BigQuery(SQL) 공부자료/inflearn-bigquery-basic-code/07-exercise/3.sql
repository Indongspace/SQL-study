WITH legendary_counts AS (
  SELECT 
    tp.trainer_id, 
    SUM(CASE WHEN p.is_legendary THEN 1 ELSE 0 END) AS legendary_count,
    SUM(CASE WHEN NOT p.is_legendary THEN 1 ELSE 0 END) AS normal_count
  FROM basic.trainer_pokemon AS tp
  LEFT JOIN basic.pokemon AS p 
  ON tp.pokemon_id = p.id
  WHERE tp.status IN ("Active", "Training")
  GROUP BY tp.trainer_id
)

SELECT 
  t.name AS trainer_name, 
  lc.legendary_count, 
  normal_count
FROM basic.trainer AS t
JOIN legendary_counts AS lc 
ON t.id = lc.trainer_id
WHERE lc.legendary_count != 0


===
-- 3. 전설의 포켓몬을 보유한 트레이너들은 전설의 포켓몬과 일반 포켓몬을 얼마나 보유하고 있을까요? (트레이너의 이름을 같이 출력해주세요)
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너마다 전설의 포켓몬을 얼마나 보유하고 있는가? 일반 포켓몬을 얼마나 가지고 있는가?
# 쿼리 계산 방법 : trainer_pokemon + pokemon => 전설 T/F => 전설 여부에 따라 얼마나 있는지 COUNT. + trainer JOIN 이름을 출력
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon, pokemon, trainer
# Join KEY : trainer_pokemon.pokemon_id = pokemon.id, (  ).trainer_id = trainer.id
# 데이터 특징 : 전설 여부에 따라서 COUNT를 해야 한다! => COUNTIF, SUM(CASE WHEN ~)

WITH legendary_cnts AS (
  SELECT
    tp.trainer_id,
    -- SUM(CASE WHEN p.is_legendary THEN 1 ELSE 0 END) AS legendary_cnt,
    SUM(CASE WHEN p.is_legendary IS TRUE THEN 1 ELSE 0 END) AS legendary_cnt,
    -- SUM(CASE WHEN NOT p.is_legendary THEN 1 ELSE 0 END) AS normal_cnt # 전설의 포켓몬이 아니다! => 일반 포켓몬
    SUM(CASE WHEN p.is_legendary IS NOT TRUE THEN 1 ELSE 0 END) AS normal_cnt # 전설의 포켓몬이 아니다! => 일반 포켓몬
  FROM basic.trainer_pokemon AS tp
  LEFT JOIN basic.pokemon AS p
  ON tp.pokemon_id = p.id
  WHERE tp.status IN ("Active", "Training")
  GROUP BY
    tp.trainer_id
)

# legendary_cnts + trainer
SELECT
  t.name AS trainer_name,
  lc.legendary_cnt,
  lc.normal_cnt
FROM basic.trainer AS t
LEFT JOIN legendary_cnts AS lc
ON t.id = lc.trainer_id
WHERE
  lc.legendary_cnt >= 1 
# SUM(CASE WHEN )