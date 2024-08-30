-- 1.트레이너가포켓몬을포획한날짜(catch_date)를기준으로,2023년1월에포획한 포켓몬의수를계산해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 포켓몬의 수 계산, catch_date, 2023년 1월에 포획
# 쿼리 계산 방법 : COUNT, WHERE 2023-01
# 데이터의 기간 : 2023-01
# 사용할 테이블 : trainer_pokemon
# Join KEY : 
# 데이터 특징 : 
  -- catch_date : DATE 타입
  -- catch_datetime : UTC, TIMESTAMP 타입 => 컬럼의 이름은 datetime인데 TIMESTAMP 타입으로 저장되어 있다
  -- 데이터가 잘못 저장된 경우
  -- 컬럼의 이름만 믿고 바로 쿼리를 작성하는 것이 아니라, 이렇게 꼭 데이터를 확인해야 한다
  -- catch_date => KR 기준? UTC 기준?
  -- catch_date_kr 또는 catch_date 컬럼의 Description에 작성
  -- catch_date 컬럼 catch_datetime 컬럼을 비교
  -- catch_date != DATE(DATETIME(catch_datetime, "Asia/Seoul")) => 있다면 catch_date는 사용하기 어려울 수 있다.
#0 데이터 검증을 위한 쿼리
-- SELECT
--   COUNT(*)
-- FROM(
-- SELECT
--   catch_date,
--   DATE(DATETIME(catch_datetime, "Asia/Seoul")) AS catch_datetime_kr_date
-- FROM basic.trainer_pokemon
-- )
-- WHERE
--   catch_date != catch_datetime_kr_date
#1
-- SELECT
--   COUNT(DISTINCT id) AS cnt
-- FROM basic.trainer_pokemon
-- WHERE
--   EXTRACT(YEAR FROM DATETIME(catch_datetime, "Asia/Seoul")) = 2023
--   AND
--   EXTRACT(MONTH FROM DATETIME(catch_datetime, "Asia/Seoul")) = 01
-- 요청한 사람 또는 문제를 그대로 믿을 경우에 틀릴 수 있다. 회사에서도 비슷한 상황일 수 있음
-- 컬럼을 꼭 파악하고 (정의확인) 쿼리를 작성하자!

-- 2.배틀이일어난시간(battle_datetime)을기준으로,오전6시에서오후6시사이에 일어난배틀의수를계산해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 오전 6시 ~ 오후 6시 사이에 일어난 배틀의 수 계산, battle_datetime
# 쿼리 계산 방법 : count, 
# 데이터의 기간 : 오전 6시~ 오후 6시
# 사용할 테이블 : battle
# Join KEY :
# 데이터 특징 :
  -- battle_date : battle_datetime 기반으로 만들어진 DATE
  -- battle_datetime : DATETIME
  -- battle_timestamp : TIMESTAMP
  -- battle_datetime 이랑 DATETIME(battle_timestamp, "Asia/Seoul") 같은지 확인
# validation
-- SELECT
--   COUNTIF(battle_datetime = DATETIME(battle_timestamp, "Asia/Seoul")) AS correct,
--   COUNTIF(battle_datetime != DATETIME(battle_timestamp, "Asia/Seoul")) AS incorrect
-- FROM basic.battle
# answer
-- SELECT
--   COUNT(DISTINCT id) AS battle_cnt
-- FROM basic.battle
-- WHERE
--   EXTRACT(HOUR FROM battle_datetime) BETWEEN 6 AND 18 
# 시간대별로 몇 건이 있는가
SELECT
  hour,
  COUNT(DISTINCT id) AS battle_cnt
FROM(
SELECT
  *,
  EXTRACT(HOUR FROM battle_datetime) AS hour
FROM basic.battle
)
GROUP BY
  hour 
ORDER BY
  hour 
