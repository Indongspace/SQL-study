-- 1. pokemon 테이블에 있는 포켓몬 수를 구하는 쿼리를 작성해주세요.
-- SELECT 
--   COUNT(id) AS cnt,
--   COUNT(*) AS cnt2
-- FROM basic.pokemon

-- 2. 포켓몬의 수가 세대별로 얼마나 있는지 알 수 있는 쿼리를 작성해주세요
-- SELECT
--   generation,
--   COUNT(id) AS cnt
-- FROM basic.pokemon
-- GROUP BY
--   generation

-- 3. 포켓몬의수를타입별로집계하고,포켓몬의수가10이상인타입만남기는쿼리를
-- 작성해주세요.포켓몬의수가많은순으로정렬해주세요
SELECT
  type1,
  COUNT(id) AS cnt
FROM basic.pokemon
GROUP BY
  type1
HAVING cnt >= 10
ORDER BY cnt DESC