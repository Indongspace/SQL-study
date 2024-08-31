--7.trainer테이블에서“Iris”,”Whitney”,“Cynthia”트레이너의 정보를 알 수 있는 쿼리를 작성해주세요
-- (힌트)컬럼IN("Iris","Whitney","Cynthia")
-- 테이블: trainer
-- 조건: 이름 = "Iris","Whitney","Cynthia" 중에 있으면 추출
-- 컬럼: *
-- 집계: 없음
-- SELECT
--   *
-- FROM basic.trainer
-- WHERE
--   name IN("Iris","Whitney","Cynthia") 
-- name에 value가 있는 row만 추출

-- 8.전체포켓몬수는얼마나되나요?
-- 테이블: pokemon
-- 조건: 없음
-- 컬럼: 
-- 집계: COUNT(id)
-- SELECT
--   COUNT(DISTINCT id) AS cnt
-- FROM basic.pokemon

-- 9.세대(generation)별로포켓몬수가얼마나되는지알수있는쿼리를작성해주세요
-- 테이블: pokemon
-- 조건: 없음
-- 컬럼: generation
-- 집계: count
SELECT
  generation,
  COUNT(generation) AS cnt
FROM basic.pokemon
GROUP BY generation