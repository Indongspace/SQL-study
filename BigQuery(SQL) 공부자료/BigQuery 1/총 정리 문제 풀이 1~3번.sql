-- 1.각트레이너별로가진포켓몬의평균레벨을계산하고,그중평균레벨이높은TOP3
-- 트레이너의이름과보유한포켓몬의수,평균레벨을출력해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너의 이름, 보유한 포켓몬의 수, 평균 레벨
# 쿼리 계산 방법 : 트레이너가 보유한 포켓몬의 포켓몬 수, 평균 레벨을 계산 + 트레이너 테이블과 연결해서 트레이너의 이름을 출력
# 데이터의 기간 :
# 사용할 테이블 : trainer_pokemon, trainer
# Join KEY : trainer_pokemon.trainer_id = trainer.id
# 데이터 특징 : trainer_pokemon의 status => Released는 방출

-- WITH trainer_avg_level AS (
-- # (1) 트레이너가 보유한 포켓몬의 평균 레벨, 포켓몬의 수
-- SELECT
--   trainer_id,
--   ROUND(AVG(level),2) AS avg_level,
--   COUNT(id) AS pokemon_cnt
-- --  DISTINCT status
-- FROM basic.trainer_pokemon
-- WHERE
--   status IN ("Active","Training")
-- GROUP BY
--   trainer_id
-- )
-- # (2) : (1)에서 만든 테이블 + trainer 테이블을 합쳐서 trainer의 name을 출력
-- SELECT
--  -- DISTINCT
--   t.name,
--   tal.avg_level,
--   tal.pokemon_cnt
-- FROM basic.trainer AS t
-- LEFT JOIN trainer_avg_level AS tal
-- ON t.id = tal.trainer_id
-- ORDER BY
--   avg_level DESC
-- LIMIT 3
# 중복 제거 : DISTINCT를 사용해도 괜찮고, GROUP BY 도 사용할 수 있음

-- 2.각포켓몬타입1을기준으로가장많이포획된(방출여부상관없음)포켓몬의타입1,포켓몬의이름과포획횟수를출력해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 포켓몬 타입1, 포켓몬 이름, 포켓몬의 포획 횟수
# 쿼리 계산 방법 : trainer_pokemon + pokemon type1, kor_name
# 데이터의 기간 :
# 사용할 테이블 : trainer_pokemon, pokemon
# Join KEY : trainer_pokemon.pokemon_id = pokemon.id
# 데이터 특징 :

-- SELECT
--   type1,
--   kor_name,
--   COUNT(tp.id) AS cnt
-- FROM basic.trainer_pokemon AS tp
-- LEFT JOIN basic.pokemon AS p
-- ON tp.pokemon_id = p.id
-- GROUP BY 
--   type1,
--   kor_name
-- ORDER BY
--   cnt DESC
-- LIMIT 3

-- 3.전설의포켓몬을보유한트레이너들은전설의포켓몬과일반포켓몬을얼마나보유하고 있을까요?(트레이너의이름을같이출력해주세요)
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너마다 전설의 포켓몬을 얼마나 보유하고 있는가? 일반 포켓몬을 얼마나 가지고 있는가?
# 쿼리 계산 방법 : trainer_pokemon + pokemon => 전설T/F => 전설 여부에 따라 얼마나 있는지 COUNT, + trainer JOIN 이름을 출력
# 데이터의 기간 : 
# 사용할 테이블 : trainer_pokemon, pokemon, trainer
# Join KEY : trainer_pokemon.pokemon_id = pokemon.id, ( ).trainer_id = trainer.id
# 데이터 특징 : 전설 여부에 따라서 COUNT를 해야 한다! => COUNTIF, SUM(CASE WHEN ~)

WITH legendary_cnts AS (
  SELECT
    tp.trainer_id,
    SUM(CASE WHEN p.is_legendary THEN 1 ELSE 0 END) AS legendary_cnt,
    SUM(CASE WHEN NOT p.is_legendary THEN 1 ELSE 0 END) AS normal_cnt
  FROM basic.trainer_pokemon AS tp
  LEFT JOIN basic.pokemon AS p
  ON tp.pokemon_id = p.id
  WHERE tp.status IN ("Active",'Training')
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
  lc.legendary_cnt >=1
# SUM(CASE WHEN)
