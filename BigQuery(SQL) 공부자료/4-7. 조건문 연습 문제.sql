-- 1.포켓몬의'speed'가70이상이면'빠름',그렇지않으면'느림'으로표시하는새로운 컬럼'Speed_Category'를만들어주세요
# 쿼리를 작성하는 목표, 확인할 지표 : speed에 관해 새로운 컬럼 만들기, speed 
# 쿼리 계산 방법 : case when
# 데이터의 기간 : 
# 사용할 테이블 : pokemon
# Join KEY :
# 데이터 특징 :
-- SELECT
--   *,
--   CASE
--     WHEN speed >= 70 THEN '빠름'
--     ELSE "느림"
--   END AS Speed_Category
-- --IF(speed >= 70, "빠름","느림") AS Speed_Category
-- FROM basic.pokemon

-- 2.포켓몬의'type1'에따라'Water','Fire','Electric'타입은각각'물','불','전기'로,그 외 타입은'기타'로분류하는새로운컬럼'type_Korean'을만들어주세요
# 쿼리를 작성하는 목표, 확인할 지표 : type1에 따라 분류하는 새로운 컬럼 만들기, type1
# 쿼리 계산 방법 : case when
# 데이터의 기간 :
# 사용할 테이블 : pokemon
# Join KEY :
# 데이터 특징 :
-- SELECT
--   eng_name,
--   type1,
--   CASE
--     WHEN type1 = 'Water' THEN '물'
--     WHEN type1 = 'Fire' THEN '불'
--     WHEN type1 = 'Electric' THEN '전기'
--     ELSE '기타'
--   END AS type_korean
-- FROM basic.pokemon

-- 3.각포켓몬의총점(total)을기준으로,300이하면'Low', 301에서500사이면'Medium', 501이상이면'High'로분류해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 총점을 기준으로 다른 분류, total
# 쿼리 계산 방법 : case when
# 데이터의 기간 : 
# 사용할 테이블 : pokemon
# Join KEY :
# 데이터 특징 :
-- SELECT
--   eng_name,
--   total,
--   CASE
--     WHEN total <= 300 THEN 'Low'
--     WHEN total >= 301 AND total <= 500 THEN 'Medium'
--   --WHEN total BETWEEN 301 AND 500 THEN 'Medium'
--     ELSE 'High'
--   END AS total_level
-- FROM basic.pokemon

-- 4.각트레이너의배지개수(badge_count)를기준으로,5개이하면'Beginner',6개에서 8개사이면'Intermediate',그이상이면'Advanced'로분류해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 배지 개수를 기준으로 분류, badge_count
# 쿼리 계산 방법 : case when
# 데이터의 기간 : 
# 사용할 테이블 : trainer
# Join KEY :
# 데이터 특징
-- SELECT
--   trainer_class,
--   COUNT(DISTINCT id) AS cnt
-- FROM(
--   SELECT
--     *,
--     CASE
--       WHEN badge_count <= 5 THEN 'Beginner'
--       WHEN badge_count BETWEEN 6 AND 8 THEN 'Intermediate'
--       ELSE 'Advanced'
--     END AS trainer_class
--   FROM basic.trainer
-- )
-- GROUP BY
--   trainer_class

-- 5.트레이너가포켓몬을포획한날짜(catch_date)가'2023-01-01'이후이면'Recent', 그렇지않으면'Old'로분류해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 포획한 날짜로 분류
# 쿼리 계산 방법 : if
# 데이터의 기간 :
# 사용할 테이블 : trainer_pokemon
# Join KEY :
# 데이터 특징 : utc 라서 kor_time으로 변경해야됨
-- SELECT
--   catch_period,
--   COUNT(DISTINCT id)
-- FROM(
--   SELECT
--     *,
--     IF (DATE(catch_datetime, "Asia/Seoul")>'2023-01-01','Recent','Old') AS catch_period,
--     -- 모든 조건이 A로 변환한다
--   --'Recent' AS recent_value # 모든 컬럼에 동일한 값을 추가하고 싶을 때는 이렇게 문자를 바로 작성해도 된다.
--   FROM basic.trainer_pokemon
-- )
-- GROUP BY
--   catch_period

-- 6.배틀에서승자(winner_id)가player1_id와같으면'Player1Wins',player2_id와 같으면'Player2Wins',그렇지않으면'Draw'로결과가나오게해주세요
# 쿼리를 작성하는 목표, 확인할 지표 : 승패여부 표시
# 쿼리 계산 방법 : CASE WHEN
# 데이터의 기간 :
# 사용할 테이블 : battle
# Join KEY :
# 데이터 특징 :
SELECT
  battle_result,
  COUNT(DISTINCT id)
FROM(
  SELECT
    id,
    player1_id,
    player2_id,
    winner_id,
    CASE
      WHEN winner_id = player1_id THEN 'Player1Wins'
      WHEN winner_id = player2_id THEN 'Player2WINS'
      ELSE 'Draw'
    END AS battle_result
  FROM basic.battle
)
GROUP BY
  battle_result
  