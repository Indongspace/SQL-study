-- 10.type2가존재하는포켓몬의수는얼마나되나요?
-- 테이블: pokemon
-- 조건: type2 is not null
-- 컬럼: 없음
-- 집계: count
-- SELECT
--   COUNT(id) AS cnt
-- FROM basic.pokemon
-- WHERE
--   type2 IS NOT NULL

-- 11.type2가있는포켓몬중에제일많은type1은무엇인가요?
-- 테이블: pokemon
-- 조건: type2 is not null
-- 컬럼: type1
-- 집계: count
-- SELECT
--   type1,
--   COUNT(id) AS cnt 
-- FROM basic.pokemon
-- WHERE
--   type2 IS NOT NULL   
-- GROUP BY
--   type1
-- ORDER BY cnt DESC
-- LIMIT 1

-- 12.단일(하나의타입만있는)타입포켓몬중많은type1은무엇일까요?
-- 테이블: pokemon
-- 조건: type2 is null
-- 컬럼: type1
-- 집계: count
SELECT
  type1,
  COUNT(id) AS cnt
FROM basic.pokemon
WHERE
  type2 IS NULL
GROUP BY
  type1
ORDER BY
  type1 DESC
LIMIT 1