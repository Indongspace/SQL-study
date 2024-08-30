-- 3.트레이너의고향(hometown)과포켓몬을포획한위치(location)를비교하여,자신의
-- 고향에서포켓몬을포획한트레이너의수를계산해주세요.
-- 참고-status상관없이구해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 고향에서 포켓몬 포획한 트레이너 수, 
# 쿼리 계산 방법 : COUNT
# 데이터의 기간 :
# 사용할 테이블 : trainer.hometown ,trainer_pokemon.location
# Join KEY : hometown, location
# 데이터 특징 :
-- SELECT
--   COUNT(DISTINCT t.id) AS cnt,
--   t.hometown
-- FROM(
--   SELECT
--     *
--   FROM basic.trainer 
-- ) AS t
-- LEFT JOIN basic.trainer_pokemon AS tp
-- ON t.hometown = tp.location 
-- GROUP BY t.hometown
-- ORDER BY cnt DESC 

-- SELECT
--   COUNT(DISTINCT tp.trainer_id) AS trainer_uniq, # 트레이너의 수=> 28명
--   #COUNT(tp.trainer_id) AS trainer_cnt # 트레이너와 포켓몬이 같은 건이 43개
-- FROM basic.trainer AS t
-- LEFT JOIN basic.trainer_pokemon AS tp
-- ON t.id = tp.trainer_id
-- WHERE
--   tp.location IS NOT NULL
--   AND t.hometown = tp.location
--  -- current_health IS NULL
--  --  -- trainer 중에 포켓몬을 잡아보지 못한 trainer가 있으면 NULL 조건을 걸어줘야 함.

-- 4.Master등급인트레이너들은어떤타입의포켓몬을제일많이보유하고있을까요?
-- 참고-보유했다의정의는1번문제의정의와동일
# 쿼리를 작성하는 목표, 확인할 지표 : master 등급의 트레이너들이 보유하고 있는 포켓몬의 타입 수
# 쿼리 계산 방법 : trainer+pokemon+trainer_pokemon => Master => type1 GROUP BY + COUNT
# 데이터의 기간 : 
# 사용할 테이블 : trainer, pokemon, trainer_pokemon
# Join KEY : trainer.id = trainer_pokemon.trainer_id, pokemon.id = trainer_pokemon.pokemon_id
-- 2번 나오는 trainer_pokemon을 LEFT
# 데이터 특징 :

-- SELECT
--   type1,
--   COUNT(tp.id) AS pokemon_cnt
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
-- LEFT JOIN basic.trainer AS t
-- ON tp.trainer_id = t.id
-- WHERE
--   t.achievement_level = 'Master'
-- GROUP BY
--   type1
-- ORDER BY
--   2 DESC
-- LIMIT 1
# LEFT JOIN 을 연속해서 N번 사용할 수 있다.


-- 5. Incheon출신트레이너들은1세대,2세대포켓몬을각각얼마나보유하고있나요?
# 쿼리를 작성하는 목표, 확인할 지표 : 인천출신 트레이너가 1세대,2세대 포켓몬을 각각 몇 마리씩 보유하는지 
# 쿼리 계산 방법 : 인천출신 => generation count, status
# 데이터의 기간 :
# 사용할 테이블 : trainer, pokemon, trainer_pokemon
# Join KEY : trainer_pokemon.trainer_id = trainer.id , trainer_pokemon.pokemon_id = pokemon.id
# 데이터 특징 :

-- SELECT
--   p.generation,
--   COUNT(p.id) AS pokemon_cnt
-- FROM(
--   SELECT
--     *
--   FROM basic.trainer_pokemon
--   WHERE
--     status IN ('Active','Training')
-- ) AS tp
-- LEFT JOIN basic.trainer AS t 
-- ON tp.trainer_id = t.id
-- LEFT JOIN basic.pokemon AS p
-- ON tp.pokemon_id = p.id
-- WHERE
--   t.hometown = 'Incheon'
-- -- 3세대가 생겨도 1,2 세대만 나오게 해줘! => WHERE 조건에 generation IN (1,2)
-- GROUP BY 
--   p.generation

