-- 3.각트레이너별로그들이포켓몬을포획한첫날(catch_date)을찾고,그날짜를 'DD/MM/YYYY'형식으로출력해주세요.
-- (2024-01-01=>01/01/2024)
# 쿼리를 작성하는 목표, 확인할 지표 : 포켓몬 포획한 첫날을 찾고, 형식으로 출력, catch_date
# 쿼리 계산 방법 : format_datetime
# 데이터의 기간 : 첫날
# 사용할 테이블 : trainer_pokemon
# Join KEY :
# 데이터 특징 :
-- SELECT
--   trainer_id,
--   FORMAT_DATE("%d/%m/%Y",first_catch) AS first_catch
-- FROM(
--   SELECT
--     trainer_id,
--     MIN(DATE(catch_datetime, "Asia/Seoul")) AS first_catch
--   FROM basic.trainer_pokemon
--   GROUP BY 
--     trainer_id
-- )
-- ORDER BY
--   trainer_id
-- ORDER BY : SELECT 제일 바깥에서 1번만 하면 됨
-- 모든 ROW를 확인해서 재정렬 => 연산이 많이 소요 => 시간이 오래 걸린다
-- ORDER BY 위치는 SELECT의 가장 바깥에서 실행.

-- 4.배틀이일어난날짜(battle_date)를기준으로,요일별로배틀이얼마나자주 일어났는지계산해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 요일별로 배틀 수 계산
# 쿼리 계산 방법 : COUNT
# 데이터의 기간 : 
# 사용할 테이블 : battle
# Join KEY : 
# 데이터 특징 :
-- SELECT
--   day_of_week,
--   COUNT(DISTINCT id) AS cnt
-- FROM(
--   SELECT
--     *,
--     EXTRACT(DAYOFWEEK FROM battle_date) AS day_of_week
--   FROM basic.battle
-- )
-- GROUP BY
--   day_of_week
-- ORDER BY
--   day_of_week

-- 5.트레이너가 포켓몬을 처음으로 포획한 날짜와 마지막으로 포획한 날짜의 간격이 큰 순으로 정렬하는 쿼리를 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 처음 날짜와 마지막 날짜의 간격
# 쿼리 계산 방법 : DATETIME_DIFF
# 데이터의 기간 : 
# 사용할 테이블 : trainer_pokemon
# Join KEY :
# 데이터 특징 : Asia/Seoul 로 변환 해야됨
SELECT
  trainer_id,
  DATETIME_DIFF(catch_datetime_max,catch_datetime_min, DAY) AS day_diff
  -- 날짜 하나를 찍고, 네이버 지도 등에서 D DAY 계산기 => 내가 예상한 답과 같은지 확인
FROM(
  SELECT
    trainer_id,
    MIN(DATE(catch_datetime, "Asia/Seoul")) AS catch_datetime_min,
    MAX(DATE(catch_datetime, "Asia/Seoul")) AS catch_datetime_max
  FROM basic.trainer_pokemon
  GROUP BY
    trainer_id
)
ORDER BY
  day_diff DESC

