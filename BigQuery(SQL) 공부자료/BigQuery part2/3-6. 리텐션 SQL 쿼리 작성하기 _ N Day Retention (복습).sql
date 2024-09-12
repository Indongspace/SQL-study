# N Day Retention 연습
# user_pseudo_id | first_date | event_date | diff_of_day

# A 방법
-- WITH base AS (
--   SELECT
--     DISTINCT
--       user_id,
--       event_name,
--       DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime,
--       DATE(DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul')) AS event_date,
--       user_pseudo_id
--   FROM advanced.app_logs
--   WHERE
--     event_date BETWEEN '2022-08-01' AND '2022-11-03'
-- ), first_data AS (
--   # 첫 접속일을 구하기 위한 데이터
--   SELECT
--     user_pseudo_id,
--     MIN(event_date) AS first_date
--   FROM base
--   GROUP BY
--     user_pseudo_id
-- ), event_data AS (
--   SELECT
--     user_pseudo_id,
--     event_date
--   FROM base
--   GROUP BY ALL
-- ), retain_base AS (
--   SELECT
--     fd.user_pseudo_id,
--     fd.first_date,
--     ed.event_date,
--     DATE_DIFF(ed.event_date, fd.first_date, DAY) AS diff_of_day
--   FROM first_data AS fd
--   LEFT JOIN event_data AS ed
--   ON fd.user_pseudo_id = ed.user_pseudo_id
-- ), user_counts AS (
--   SELECT
--     diff_of_day,
--     COUNT(DISTINCT user_pseudo_id) AS user_cnt
--   FROM retain_base
--   GROUP BY
--     diff_of_day
-- ), first_day_user_count AS (
--   SELECT
--     user_cnt AS first_day_user_cnt
--   FROM user_counts 
--   WHERE
--     diff_of_day = 0
-- )

# first_day_user_cnt 를 붙이는 방법 A-1, A-2 2가지
# A-1 CROSS JOIN
-- SELECT
--   uc.diff_of_day,
--   uc.user_cnt,
--   fduc.first_day_user_cnt,
--   ROUND(SAFE_DIVIDE(uc.user_cnt, fduc.first_day_user_cnt), 3) AS retention_rate
-- FROM user_counts AS uc
-- CROSS JOIN first_day_user_count AS fduc
-- ORDER BY
--   uc.diff_of_day

# A-2 윈도우 함수
-- SELECT
--   *,
--   ROUND(SAFE_DIVIDE(user_cnt, first_day_user_cnt), 3) AS retention_rate
-- FROM (
--   SELECT
--     diff_of_day,
--     user_cnt,
--     FIRST_VALUE(user_cnt) OVER(ORDER BY diff_of_day) AS first_day_user_cnt
--   FROM user_counts
-- )
-- ORDER BY
--   diff_of_day

# B 방법
WITH base AS (
  SELECT
    DISTINCT
      user_id,
      event_name,
      DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul') AS event_datetime,
      DATE(DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Seoul')) AS event_date,
      user_pseudo_id
  FROM advanced.app_logs
  WHERE
    event_date BETWEEN '2022-08-01' AND '2022-11-03'
), first_date_and_diff AS (
  SELECT
    *,
    DATE_DIFF(event_date, first_date, DAY) AS date_of_diff
  FROM (
    SELECT
      DISTINCT
        user_pseudo_id,
        MIN(event_date) OVER(PARTITION BY user_pseudo_id) AS first_date,
        event_date
    FROM base
  )
), user_counts AS (
  SELECT
    date_of_diff,
    COUNT(DISTINCT user_pseudo_id) AS user_cnt
  FROM first_date_and_diff 
  GROUP BY
    date_of_diff
)

SELECT
  *,
  ROUND(SAFE_DIVIDE(user_cnt, first_cnt), 3) AS retention_rate
FROM (
  SELECT
    date_of_diff,
    user_cnt,
    FIRST_VALUE(user_cnt) OVER(ORDER BY date_of_diff) AS first_cnt
  FROM user_counts
)
ORDER BY
  date_of_diff

  
