# 쿼리를 작성하는 목표, 확인할 지표 : type이 Rock 또는 Ground면 => Rock&Ground라고 수정하겠다!
# 쿼리 계산 방법 : CASE WHEN
# 데이터의 기간 : X
# 사용할 테이블 : pokemon
# Join KEY : X
# 데이터 특징 : type이 type1, type2로 나뉘어서 두 가지 타입을 모두 고려해야 한다!
-- SELECT
--   new_type1,
--   COUNT(DISTINCT id) AS cnt  
-- FROM(
--   SELECT
--     *,
--     CASE
--       WHEN (type1 IN ("Rock","Ground")) OR (type2 IN ("Rock","Ground")) THEN "Rock&Ground"
--     ELSE type1
--     END AS new_type1
--   FROM basic.pokemon
-- )
-- GROUP BY 
--   new_type1

-- 각포켓몬의공격력(attack)을기준으로,50이상이면'Strong',100이상이면'Very Strong',그이하면'Weak'으로분류해주세요
SELECT
  eng_name,
  attack,
  CASE
    WHEN attack >= 100 THEN "Very Strong"
    WHEN attack >= 50 THEN "Strong"
    ELSE 'Weak'
  END AS attack_level
FROM basic.pokemon
ORDER BY attack DESC


