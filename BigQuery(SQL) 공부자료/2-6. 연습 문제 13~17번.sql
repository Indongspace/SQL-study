-- 13.포켓몬의이름에"파"가들어가는포켓몬은어떤포켓몬이있을까요?
-- (힌트)컬럼LIKE"파%"
-- 테이블: pokemon
-- 조건: like"파"
-- 컬럼: kor_name
-- 집계: 없음
-- SELECT
--   kor_name
-- FROM basic.pokemon
-- WHERE
--   kor_name LIKE "%파%"
-- 컬럼 LIKE "특정단어%", %는 앞에도 붙을 수 있고, 뒤에도 붙을 수 있음.
-- "%파" : 파로 끝나는 단어, "파%" : 파로 시작하는 단어, "%파%" : 파가 들어간 단어
-- 문자열 컬럼에서 특정 단어가 포함되어 있는지 알고 싶은 경우엔 LIKE를 사용하면 편함

-- 14.뱃지가6개이상인트레이너는몇명이있나요?
-- 테이블: trainer
-- 조건: badge_count >= 6
-- 컬럼: 없음
-- 집계: count
-- SELECT
--   COUNT(id) AS cnt
-- FROM basic.trainer
-- WHERE
--   badge_count >= 6

-- 15.트레이너가보유한포켓몬(trainer_pokemon)이제일많은트레이너는누구일까요?
-- 테이블: trainer_pokemon
-- 조건: 없음
-- 컬럼: trainer_id
-- 집계: count
-- SELECT
--   trainer_id,
--   COUNT(pokemon_id) AS cnt,
--   COUNT(DISTINCT pokemon_id) AS species_cnt
-- FROM basic.trainer_pokemon
-- GROUP BY
--   trainer_id
-- ORDER BY
--   cnt DESC

-- 16.포켓몬을많이풀어준트레이너는누구일까요?
-- 테이블: trainer_pokemon
-- 조건: status = 'Released'
-- 컬럼: trainer_id
-- 집계: count
-- SELECT
--   trainer_id,
--   COUNT(pokemon_id) AS cnt
-- FROM basic.trainer_pokemon
-- WHERE
--   status = 'Released'
-- GROUP BY
--   trainer_id
-- ORDER BY
--   cnt DESC
-- LIMIT 1

-- 17.트레이너별로풀어준포켓몬의비율이20%가넘는포켓몬트레이너는누구일까요?
-- 풀어준포켓몬의비율=(풀어준포켓몬수/전체포켓몬의수)
-- (힌트)COUNTIF(조건)
-- 테이블: trainer_pokemon
-- 조건: 비율 >= 20
-- 컬럼: trainer_id
-- 집계: count, countif
SELECT
  trainer_id,
  COUNT(pokemon_id) AS pokemon_cnt,
  COUNTIF(status='Released') AS released_pokemon_cnt,
  COUNTIF(status='Released')/COUNT(pokemon_id) AS released_proportion
FROM basic.trainer_pokemon
GROUP BY
  trainer_id
HAVING
  released_proportion >= 0.2