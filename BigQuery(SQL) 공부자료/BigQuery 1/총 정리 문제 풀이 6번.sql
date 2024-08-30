-- 6.각포켓몬의최고레벨과최저레벨을계산하고,레벨차이가가장큰포켓몬의이름을 출력하세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 포켓몬의 레벨 차이(최고레벨 - 최저레벨)
# 쿼리 계산 방법 : trainer_pokemon에서 포켓몬의 최고 레벨, 최저 레벨을 계산 -> 차이를 구하고 -> 차이가 큰 순으로 정렬
# 데이터의 기간 :
# 사용할 테이블 : trainer_pokemon, pokemon
# Join KEY : trainer_pokemon.pokemon_id = pokemon_id
# 데이터 특징 :

# (1) 레벨 차이를 구하는 쿼리
WITH level_diff AS (
  SELECT
    tp.pokemon_id,
    p.kor_name,
    MIN(tp.level) AS min_level,
    MAX(tp.level) AS max_level,
    MAX(tp.level) - MIN(tp.level) AS level_difference
  FROM basic.trainer_pokemon AS tp
  LEFT JOIN basic.pokemon AS p
  ON tp.pokemon_id = p.id 
  -- WHERE
  --   pokemon_id = 12
  GROUP BY
    tp.pokemon_id,
    p.kor_name 
# pokemon_id => min level : 6, max level : 22, level_difference = 16
# 12 | 16
# min level => MIN
# max level => MAX
)

SELECT
  kor_name,
  min_level, max_level,
  level_difference
FROM level_diff
ORDER BY
  level_difference DESC
LIMIT 1
