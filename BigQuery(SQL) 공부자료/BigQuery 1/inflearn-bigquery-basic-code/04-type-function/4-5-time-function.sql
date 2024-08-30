-- 1. 트레이너가 포켓몬을 포획한 날짜(catch_date)를 기준으로, 2023년 1월에 포획한 포켓몬의 수를 계산해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 포켓몬의 수
# 쿼리 계산 방법 : COUNT
# 데이터의 기간 : 2023년 1월! => catch_datetime을 사용해야 함 => EXTRACT
# 사용할 테이블: trainer_pokemon
# Join KEY : X
# 데이터 특징 : 직접 봐야함! 
  -- catch_date : DATE 타입
  -- catch_datetime : UTC. TIMESTAMP 타입 => 컬럼의 이름은 datetime인데 TIMESTAMP 타입으로 저장되어 있다!
  -- 회사에서도 이런 경우가 있을 수 있음. 데이터가 잘못 저장된 경우
  -- 컬럼의 이름만 믿고 바로 쿼리를 작성하는 것이 아니라, 이렇게 꼭 데이터를 확인해야 한다!
  -- catch_date => KR 기준? UTC 기준?
  -- catch_date_kr 또는 catch_date 컬럼의 Description에 작성
  -- catch_date가 UTC 기준인지? KR 기준? => 확인 필요
  -- catch_date 컬럼 catch_datetime 컬럼을 비교 => DATE(DATETIME(catch_datetime, "Asia/Seoul"))
  -- catch_date != DATE(DATETIME(catch_datetime, "Asia/Seoul")) => 있다면 catch_date는 사용하기 어려울 수 있다
  -- 데이터를 저장하는 부분에서 이슈가 발생한 경우가 있음 
-- -- #0. 데이터 검증을 위한 쿼리
-- SELECT
--   COUNT(*)
-- FROM (
-- SELECT
--   id,
--   catch_date,
--   DATE(DATETIME(catch_datetime, "Asia/Seoul")) As catch_datetime_kr_date
-- FROM basic.trainer_pokemon
-- )
-- WHERE
--   catch_date = catch_datetime_kr_date
--   # != : 같지 않다. 같지 않은 경우는 141건, 같은 경우는 238건
--   -- 컬럼의 설명을 꼭 확인하고 SQL을 작성해야 한다!

SELECT
  COUNT(DISTINCT id) AS cnt
FROM basic.trainer_pokemon
WHERE
  EXTRACT(YEAR FROM DATETIME(catch_datetime, "Asia/Seoul")) = 2023 # catch_datetime은 TIMESTAMP로 저장되어 있으므로, DATETIME으로 변경해야 함
  AND EXTRACT(MONTH FROM DATETIME(catch_datetime, "Asia/Seoul")) = 1
-- 문제 출제 의도 : 요청한 사람 또는 문제를 그대로 볼 경우에 틀릴 수가 있다. 회사에서도 비슷한 상황일 수 있음. 
-- 컬럼을 꼭 파악하고(정의 확인) 쿼리를 작성하자!



-- 2. 배틀이 일어난 시간(battle_datetime)을 기준으로, 오전 6시에서 오후 6시 사이에 일어난 배틀의 수를 계산해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 오전 6시 ~ 오후 6시 배틀의 수
# 쿼리 계산 방법 : COUNT
# 데이터의 기간 : 일자는 상관없고, 오전 6시 ~ 오후 6시 => battle_datetime => EXTRACT!
# 사용할 테이블: battle
# Join KEY : X
# 데이터 특징 
  -- battle_date : battle_datetime 기반으로 만들어진 DATE
  -- battle_datetime : DATETIME
  -- battle_timestamp : TIMESTAMP
  -- battle_datetime이랑 DATETIME(battle_timestamp, "Asia/Seoul") 같은지 확인!

-- 2-0. battle_datetime, battle_timestamp 검증
-- SELECT
--   -- id,
--   -- battle_datetime,
--   -- DATETIME(battle_timestamp, "Asia/Seoul") AS battle_timestamp_kr,
--   COUNTIF(battle_datetime = DATETIME(battle_timestamp, "Asia/Seoul")) AS battle_datetime_same_battle_timestamp_kr,
--   COUNTIF(battle_datetime != DATETIME(battle_timestamp, "Asia/Seoul")) AS battle_datetime_not_same_battle_timestamp_kr
-- FROM basic.battle
SELECT
  COUNT(DISTINCT id) AS battle_cnt
FROM basic.battle
WHERE
  -- EXTRACT(HOUR FROM battle_datetime) >= 6
  -- AND EXTRACT(HOUR FROM battle_datetime) <= 18
  EXTRACT(HOUR FROM battle_datetime) BETWEEN 6 and 18
  # BETWEEN a and b => a와 b 사이에 있는 것을 반환
  

-- 2. 배틀이 일어난 시간(battle_datetime)을 기준으로, 오전 6시에서 오후 6시 사이에 일어난 배틀의 수를 계산해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 오전 6시 ~ 오후 6시 배틀의 수
# 쿼리 계산 방법 : COUNT
# 데이터의 기간 : 일자는 상관없고, 오전 6시 ~ 오후 6시 => battle_datetime => EXTRACT!
# 사용할 테이블: battle
# Join KEY : X
# 데이터 특징 
  -- battle_date : battle_datetime 기반으로 만들어진 DATE
  -- battle_datetime : DATETIME
  -- battle_timestamp : TIMESTAMP
  -- battle_datetime이랑 DATETIME(battle_timestamp, "Asia/Seoul") 같은지 확인!

-- 2-0. battle_datetime, battle_timestamp 검증
-- SELECT
--   -- id,
--   -- battle_datetime,
--   -- DATETIME(battle_timestamp, "Asia/Seoul") AS battle_timestamp_kr,
--   COUNTIF(battle_datetime = DATETIME(battle_timestamp, "Asia/Seoul")) AS battle_datetime_same_battle_timestamp_kr,
--   COUNTIF(battle_datetime != DATETIME(battle_timestamp, "Asia/Seoul")) AS battle_datetime_not_same_battle_timestamp_kr
-- FROM basic.battle
-- SELECT
--   COUNT(DISTINCT id) AS battle_cnt
-- FROM basic.battle
-- WHERE
--   -- EXTRACT(HOUR FROM battle_datetime) >= 6
--   -- AND EXTRACT(HOUR FROM battle_datetime) <= 18
--   EXTRACT(HOUR FROM battle_datetime) BETWEEN 6 and 18
--   # BETWEEN a and b => a와 b 사이에 있는 것을 반환

-- 2-1. 시간대별로 몇 건이 있는가?
-- SELECT
--   hour,
--   COUNT(DISTINCT id) AS battle_cnt
-- FROM (
--   SELECT
--     *,
--     EXTRACT(HOUR FROM battle_datetime) AS hour
--   FROM basic.battle
-- )
-- GROUP BY
--   hour
-- ORDER BY
--   hour

-- 3. 각 트레이너별로 그들이 포켓몬을 포획한 첫 날(catch_date)을 찾고, 그 날짜를 'DD/MM/YYYY' 형식으로 출력해주세요.
-- (2024-01-01 => 01/01/2024)
# 쿼리를 작성하는 목표, 확인할 지표 : 날짜를 특정 형태로 변경! + 포획한 첫 날
# 쿼리 계산 방법 : DATE => 문자열. FORMAT_DATETIME + MIN
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon
# Join KEY : X
# 데이터 특징 : catch_date는 UTC 기준의 데이터. 한국 기준으로 하려면 catch_datetime을 사용해야 한다! 

-- SELECT
--   trainer_id,
--   FORMAT_DATE("%d/%m/%Y", min_catch_date) AS new_min_catch_date
--   -- 'DD/MM/YYYY'
-- FROM (
--   SELECT
--   -- 포획한 첫 날 + 날짜를 변경
--     trainer_id,
--     MIN(DATE(catch_datetime, "Asia/Seoul")) AS min_catch_date
--   FROM basic.trainer_pokemon
--   GROUP BY
--     trainer_id
-- )
-- ORDER BY
--   trainer_id

-- ORDER BY : SELECT 제일 바깥에서 1번만 하면 됨
-- ORDER BY => 모든 ROW를 확인해서 재정렬 => 연산이 많이 소요 => 시간이 오래 걸린다
-- ORDER BY 위치는 SELECT의 가장 바깥에서 실행

-- 4. 배틀이 일어난 날짜(battle_date)를 기준으로, 요일별로 배틀이 얼마나 자주 일어났는지 계산해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 요일별로 배틀이 얼마나 자주 일어났는가? 배틀의 건!
# 쿼리 계산 방법 : 요일별로 COUNT
# 데이터의 기간 : X
# 사용할 테이블: battle
# Join KEY : X
# 데이터 특징 : battle_date가 정상적임
-- 요일을 어떻게 추출할 것인가?
-- EXTRACT

-- SELECT
--   day_of_week,
--   COUNT(DISTINCT id) AS battle_cnt
-- FROM (
--   SELECT
--     *,
--     EXTRACT(DAYOFWEEK FROM battle_date) AS day_of_week
--   FROM basic.battle
-- )
-- GROUP BY
--   day_of_week
-- ORDER BY
--   day_of_week

-- 5. 트레이너가 포켓몬을 처음으로 포획한 날짜와 마지막으로 포획한 날짜의 간격이 큰 순으로 정렬하는 쿼리를 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 트레이너의 처음과 마지막의 diff 큰 순으로 정렬!
# 쿼리 계산 방법 : 처음 포획한 날짜(MIN) + 마지막으로 포획한 날짜(??) -> 차이를 구하고(DATETIME_DIFF) -> 차이가 큰 순으로 정렬(ORDER BY)
# 데이터의 기간 : X
# 사용할 테이블: trainer_pokemon
# Join KEY : X
# 데이터 특징 : catch_date는 UTC 기반으로 만들어진 일자. catch_datetime을 사용해야 한다 

-- SELECT
--   *,
--   DATETIME_DIFF(max_catch_datetime, min_catch_datetime, DAY) AS diff
--   -- 날짜 하나를 찍고, 네이버 지도 등에서 D Day 계산기 => 내가 예상한 답과 같은지 확인
-- FROM (
-- SELECT
--   trainer_id,
--   MIN(DATETIME(catch_datetime, "Asia/Seoul")) AS min_catch_datetime,
--   MAX(DATETIME(catch_datetime, "Asia/Seoul")) AS max_catch_datetime,
-- FROM basic.trainer_pokemon
-- GROUP BY
--   trainer_id
-- )
-- ORDER BY
--   diff DESC