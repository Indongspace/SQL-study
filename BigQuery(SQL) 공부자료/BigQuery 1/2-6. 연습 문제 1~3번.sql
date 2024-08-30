-- 1.포켓몬중에type2가없는포켓몬의수를작성하는쿼리를작성해주세요
-- (힌트)~가없다:컬럼ISNULL
-- SELECT
--   type2,
--   COUNT(type2 IS NULL) AS type2_isnull
-- FROM basic.pokemon
-- GROUP BY type2 
-- SELECT
--   COUNT(id) AS cnt
-- FROM basic.pokemon
-- WHERE 
--   (type2 IS NULL)
--   OR (type1 = "Fire")
-- WHERE 절에서 여러 조건을 연결하고 싶은 경우 => AND 조건을 사용
-- OR 조건 => ( ) OR ( )

-- 2.type2가없는포켓몬의type1과type1의포켓몬수를알려주는쿼리를작성해주세요.
-- 단,type1의포켓몬수가큰순으로정렬해주세요
-- SELECT
--   type1,
--   type2,
--   COUNT(type1) AS cnt_type1
-- FROM basic.pokemon
-- GROUP BY
--   type1,
--   type2
-- HAVING 
--   type2 IS NULL  
-- ORDER BY type1 DESC
-- SELECT
--   type1,
--   COUNT(id) AS pokemon_cnt
--   -- 집계 함수는 GROUP BY와 같이 다님. 집계하는 기준(컬럼)이 없으면 COUNT만 쓸 수 있으나, 집계하는 기준이 있다면 그 기준 컬럼을 GROUP BY에 써줘야 한다
-- FROM basic.pokemon
-- WHERE
--   type2 IS NULL
-- GROUP BY
--   type1
-- ORDER BY
--   pokemon_cnt DESC

-- 3.type2상관없이type1의포켓몬수를알수있는쿼리를작성해주세요
SELECT
 type1,
 COUNT(id) AS pokemon_cnt,
 COUNT(DISTINCT id) AS pokemon_cnt2
 -- DISTINCT => 고유한 값만 보고 싶을 때 사용. Unique한 값만 알고 싶은 경우 사용
 -- DISTINCT : DAU(Daily Active User)
 -- Active한 유저의 수를 하루 단위로 집계
 -- COUNT(DISTINCT user_id) AS dau => 이런 데이터를 저장하는 곳에 접속 기록, 이벤트 로그가 여러 Row가 존재 => Unique => DISTINCT
FROM basic.pokemon
GROUP BY
  type1