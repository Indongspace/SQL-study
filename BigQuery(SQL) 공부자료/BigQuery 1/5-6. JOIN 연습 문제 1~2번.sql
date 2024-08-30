-- 1.트레이너가보유한포켓몬들은얼마나있는지알수있는쿼리를작성해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 포켓몬 이름, statue가 active, training
# 쿼리 계산 방법 : 
# 데이터의 기간 : 
# 사용할 테이블 : pokemon, trainer_pokemon
# Join KEY : pokemon.id, trainer_pokemon.pokemon_id
# 데이터 특징 :

-- SELECT
--   kor_name,
--   COUNT(id) AS cnt
-- FROM(
--   SELECT
--     p.id,
--     p.kor_name,
--     tp.status
--   FROM basic.pokemon AS p
--   LEFT JOIN basic.trainer_pokemon AS tp
--   ON p.id = tp.pokemon_id
-- )
-- WHERE
--   status!='Released'
-- GROUP BY
--   kor_name

-- SELECT
--   -- tp.*,
--   -- p.id,
--   -- p.kor_name
--   kor_name,
--   COUNT(tp.id) AS pokemon_cnt
--   -- JOIN에서 사용하는 테이블에 중복된 컬림의 이름이 있으면 꼭 어떤 테이블의 컬럼인지 명시해야 함
-- FROM(
--   SELECT
--     id,
--     trainer_id,
--     pokemon_id,
--     status
--   FROM basic.trainer_pokemon
--   WHERE
--     status IN ('Active','Training')
-- ) AS tp
-- LEFT JOIN basic.pokemon AS p
-- ON tp.pokemon_id = p.id
-- GROUP BY
--   kor_name
-- ORDER BY 
--   pokemon_cnt DESC
-- -- WHERE
-- --  1=1
-- --  AND status = "Active"
-- --  AND status = "Training" # 빨리 주석처리하기 위해서 앞에선 TRUE인 1=1을 넣고, AND 쓰고 빠르게 주석 처리

-- 2.각트레이너가가진포켓몬중에서'Grass'타입의포켓몬수를계산해주세요
-- (단,편의를위해type1기준으로계산해주세요)
# 쿼리를 작성하는 목표, 확인할 지표 : Grass 타입의 포켓몬 계산/ 트레이너가 가진 포켓몬 중, pokemon.type1, pokemon.id, trainer_pokemon.pokemon_id, status 
# 쿼리 계산 방법 : COUNT Grass
# 데이터의 기간 :
# 사용할 테이블 : trainer_pokemon, pokemon
# Join KEY : trainer_pokemon.pokemon_id, pokemon_id
# 데이터 특징 :

-- SELECT
--   p.type1,
--   COUNT(p.id) AS cnt 
-- FROM(
-- SELECT
--   *
-- FROM basic.trainer_pokemon
-- WHERE 
--   status IN ('Active','Training')
-- ) AS tp
-- LEFT JOIN basic.pokemon AS p 
-- ON tp.pokemon_id = p.id
-- WHERE
--   p.type1 = "Grass"
-- GROUP BY
--   p.type1

-- 기준이 되는 테이블은 내가 구하고자 하는 데이터가 어디에 제일 잘 저장되어 있는가?
SELECT
  #tp.*,
  p.type1,
  COUNT(tp.id) AS pokemon_cnt
FROM(
  SELECT
    id,
    trainer_id,
    pokemon_id,
    status
  FROM basic.trainer_pokemon 
  WHERE
    status IN ('Active','Training')
) AS tp
LEFT JOIN basic.pokemon AS P
ON tp.pokemon_id = p.id 
WHERE
  type1 = 'Grass'
GROUP BY
  type1
ORDER BY
  2 DESC # 2 대신에 pokemon_cnt도 가능

