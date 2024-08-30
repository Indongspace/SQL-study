-- Weekly 리텐션
-- 핵심 : event_date => event_week으로 변경하면 됨
-- 2024-06-30(일) => 2024년 26주차. 2024-06-24(월)도 같은 26주차
-- 데이터를 전처리(가공)하기 위해서 WEEK 함수를 사용할 수도 있고, DATE_TRUNC(일자, 자를 기준)
  -- DATE_TRUNC : 2024-06-30 => 2024-06-24
  -- WEEK : 26. 2024년 26주차! 주차 별 date를 직관적으로 알기 어렵다고 생각하는 편(개인 생각)
-- (깨알 지식) WEEK vs ISO_WEEK
  -- 주 번호를 계산할 때 사용할 수 있는 함수
  -- WEEK : 일요일이 주의 첫 날로 간주. 1월 1일이 속한 주가 1주차
  -- ISO_WEEK : 월요일이 주의 첫 날로 간주. ISO 8601 국제 표준에 따라 정의. 목요일이 속한 주를 기준으로 주 번호를 지정
    -- 목요일이 속하면 그 주의 4일 이상이 포함되기 때문
    -- 연도의 첫 목요일이 있는 주부터 1주차
  -- 2022년 1월 1일(토요일) WEEK : 2022년 1주차. ISO_WEEK 2021년 52주차. 
  -- 첫 목요일은 2022-01-06. 2022-01-03~2022-01-09가 2022년 1주차

WITH base AS (
  SELECT
    DISTINCT
      user_id,
      user_pseudo_id,
      event_name,
      DATE(DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul')) AS event_date,
      DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime
  FROM advanced.app_logs
  WHERE
    event_date BETWEEN "2022-08-01" AND "2022-11-03"
), first_week_and_diff AS (
  SELECT
    *,
    -- DATE_DIFF(event_date, first_date, DAY) AS diff_of_day
    DATE_DIFF(event_week, first_week, WEEK) AS diff_of_week
  FROM (
    SELECT
      # 일자별로 중복 제거
      DISTINCT 
        user_pseudo_id,
        -- DATE_TRUNC
        DATE_TRUNC(MIN(event_date) OVER(PARTITION BY user_pseudo_id), WEEK(MONDAY)) AS first_week,
        DATE_TRUNC(event_date, WEEK(MONDAY)) AS event_week
    FROM base
  )
), user_counts AS (
  SELECT
  diff_of_week,
  COUNT(DISTINCT user_pseudo_id) AS user_cnt
  FROM first_week_and_diff
  GROUP BY diff_of_week
)


SELECT
  *,
  ROUND(SAFE_DIVIDE(user_cnt, first_week_user_cnt), 2) AS retention_rate
FROM (
  SELECT
    diff_of_week,
    user_cnt,
    FIRST_VALUE(user_cnt) OVER(ORDER BY diff_of_week ASC) AS first_week_user_cnt
  FROM user_counts
)

-- SELECT
--   diff_of_week,
--   COUNT(DISTINCT user_pseudo_id) AS user_cnt
-- FROM first_week_and_diff
-- GROUP BY diff_of_week
-- ORDER BY diff_of_week

# Monthly 리텐션 쿼리 작성해보기!