-- 1. pokemon 테이블에 있는 포켓몬 수를 구하는 쿼리를 작성해주세요
-- 사용할 테이블 : pokemon
-- 조건 : X
-- 그룹화를 할 때 사용할 컬럼 : X
-- 집계할 때 사용할 계산 : 수를 구한다 => COUNT, 포켓몬
-- SELECT
--   COUNT(id) AS cnt
-- FROM basic.pokemon

-- 2. 포켓몬의 수가 세대별로 얼마나 있는지 알 수 있는 쿼리를 작성해주세요
-- 사용할 테이블 : pokemon
-- 조건 : X
-- 그룹화를 할 때 사용할 컬럼 : 세대
-- 집계할 때 사용할 계산 : 얼마나 있는지 => 수를 구한다 => COUNT

-- SELECT
--   generation,
--   COUNT(id) AS cnt  
-- FROM basic.pokemon
-- GROUP BY 
--   generation

-- 3. 포켓몬의 수를 타입 별로 집계하고, 포켓몬의 수가 10 이상인 타입만 남기는 쿼리를 작성해주세요. 포켓몬의 수가 많은 순으로 정렬해주세요
-- pokemon
-- 조건 (WHERE) => 테이블 원본 => 없음
-- 집계 후 조건 (HAVING) => 10 이상
-- 포켓몬의 수가 많은 순으로 정렬(ORDER BY 포켓몬 수 DESC)
-- 단계적으로 실행해보면서 가도 된다! 한번에 정답을 맞추려고 안해도 된다

SELECT
  type1, 
  COUNT(id) AS cnt
FROM basic.pokemon
GROUP BY
  type1
HAVING cnt >= 10
ORDER BY cnt DESC  

